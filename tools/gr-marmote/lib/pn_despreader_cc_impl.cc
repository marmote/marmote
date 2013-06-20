/* -*- c++ -*- */
/*
 * Copyright 2013 <+YOU OR YOUR COMPANY+>.
 *
 * This is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3, or (at your option)
 * any later version.
 *
 * This software is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this software; see the file COPYING.  If not, write to
 * the Free Software Foundation, Inc., 51 Franklin Street,
 * Boston, MA 02110-1301, USA.
 */

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include <gr_io_signature.h>
#include "pn_despreader_cc_impl.h"

#include <iomanip>
#include <math.h>

namespace gr {
    namespace marmote {

        pn_despreader_cc::sptr pn_despreader_cc::make(bool debug, int mask, int seed, int spread_factor, int oversample_factor, int preamble_length, int payload_length)
        {
            return gnuradio::get_initial_sptr (new pn_despreader_cc_impl(debug, mask, seed, spread_factor, oversample_factor, preamble_length, payload_length));
        }

        pn_despreader_cc_impl::pn_despreader_cc_impl(bool debug, int mask, int seed, int spread_factor, int oversample_factor, int preamble_length, int payload_length)
            : gr_block("pn_despreader_cc",
                    gr_make_io_signature(1, 1, sizeof (gr_complex)),
                    gr_make_io_signature(1, 1, sizeof (gr_complex))),
            d_debug(debug),
            d_mask(mask),
            d_seed(seed),
            d_spread_factor(spread_factor),
            d_oversample_factor(oversample_factor),
            d_preamble_len(preamble_length),
            d_payload_len(payload_length * 8 + 1), // FIXME: add this bit for differential decoding in a different way
            d_seed_offset((preamble_length-1)*spread_factor)
        {
            d_lfsr = new mseq_lfsr(mask, seed);
            set_history(d_spread_factor * d_oversample_factor);
            enter_idle();

            message_port_register_out(pmt::mp("out"));
        }

        pn_despreader_cc_impl::~pn_despreader_cc_impl()
        {
            delete d_lfsr;
        }

        void pn_despreader_cc_impl::forecast (int noutput_items, gr_vector_int &ninput_items_required)
        {
            ninput_items_required[0] = history() + noutput_items * d_spread_factor;
        }

        void pn_despreader_cc_impl::enter_idle()
        {
            d_state = ST_IDLE;
            d_lfsr->reset();

            d_sample_ctr = 0;
            d_chip_ctr = 0;
            d_payload_ctr = 0;
            d_chip_sum = 0;

            d_lfsr->reset();
            // FIXME: move this into reset()
            for (int i = 0; i < d_seed_offset; i++)
            {
              d_lfsr->get_next_bit();
            }
        }


        void pn_despreader_cc_impl::enter_locked()
        {
            d_state = ST_LOCKED;
        }


        int pn_despreader_cc_impl::general_work (int noutput_items,
                gr_vector_int &ninput_items,
                gr_vector_const_void_star &input_items,
                gr_vector_void_star &output_items)
        {
            const gr_complex *in = (const gr_complex *) input_items[0];
            gr_complex *out = (gr_complex *) output_items[0];

            int ninput = ninput_items[0];
            int nprocd = d_sample_ctr;

            d_tags.clear();
            get_tags_in_range(d_tags, 0, nitems_read(0), nitems_read(0) + ninput);
            d_tags_itr = d_tags.begin();

            std::vector<gr_tag_t>::iterator lti;

            // nprocd = ninput;
            // std::cout << "Despreader nprocd: " << nprocd << std::endl;
            // memcpy(out, in, nprocd * sizeof (gr_complex));
            // for (lti = d_tags.begin(); lti != d_tags.end(); lti++)
            // {
            //     std::cout << (int)(lti->offset - nitems_read(0)) << " ";
            //     out[(int)lti->offset - nitems_read(0)].imag(-2.0);
            // }
            // std::cout << " [" << d_tags.size() << "]" << std::endl;
            // consume_each(nprocd);
            // return nprocd;
            if (d_debug)
                std::cout << "Despreading..." << " [" << ninput << " chips] " << std::endl;


            while (nprocd < ninput)
            {
                switch (d_state)
                {

                    case ST_IDLE:

                        if (d_debug)
                        {
                            std::cout << "IDLE... ";
                            std::cout << "nprocd: " << nprocd << " ninput: " << ninput << std::endl;;
                            std::cout << "Tags at ";
                            for (lti = d_tags.begin(); lti != d_tags.end(); lti++)
                            {
                                std::cout << (int)(lti->offset - nitems_read(0)) << " ";
                            }
                            std::cout << " [" << d_tags.size() << "]" << std::endl;
                        }

                        if (d_tags.empty() || d_tags_itr == d_tags.end())
                        {
                            nprocd = ninput;
                            break;
                        }

                        if (d_tags_itr->offset - nitems_read(0) < nprocd)
                        {
                            d_tags_itr++;
                            break;
                        }

                        nprocd = d_tags_itr->offset - nitems_read(0);

                        if (d_debug)
                        {
                            std::cout << "IDLE: Despreading from " << nprocd << ":" << std::endl;
                        }

                        while (nprocd < ninput && d_payload_ctr < d_payload_len)
                        {
                            float pn = (d_lfsr->get_next_bit() ? -1.0 : 1.0);

                            d_chip_sum.real(d_chip_sum.real() + in[nprocd].real() * pn);
                            d_chip_sum.imag(d_chip_sum.imag() + in[nprocd].imag() * pn);
                            d_chip_ctr++;

                            if (d_chip_ctr == d_spread_factor)
                            {
                                d_chip_sum_buf[d_payload_ctr++] = d_chip_sum;
                                d_chip_sum = 0;
                                d_chip_ctr = 0;
                            }

                            nprocd += d_oversample_factor;
                        }

                        if (d_payload_ctr == d_payload_len)
                        {

                            if (d_debug)
                            {
                                std::cout << "IDLE: ";
                                std::cout << "IDLE: nprocd: " << nprocd << " bit_ctr: " << d_payload_ctr << " chip_ctr: " << d_chip_ctr << std::endl;
                            }

                            if (d_debug)
                            {

                                std::cout << "IDLE: Packet received:" << std::endl;
                                for (int i = 0; i < d_payload_ctr; i++)
                                {
                                    std::cout << d_chip_sum_buf[i].real() << " ";
                                }
                                std::cout << std::endl;

                                for (int i = 1; i < d_payload_ctr; i++)
                                {
                                    std::cout << (int)(abs(arg(d_chip_sum_buf[i]) - arg(d_chip_sum_buf[i-1])) > M_PI / 2 ? 1 : 0) << " ";
                                }
                                std::cout << std::endl;

                            }

                            for (int i = 1; i < d_payload_len; i++)
                            {
                                d_pmt_buf[i-1] = (int)(abs(arg(d_chip_sum_buf[i]) - arg(d_chip_sum_buf[i-1])) > M_PI / 2 ? 1 : 0);
                            }

                            // FIXME: d_payload_len is +1 due to differential encoding
                            message_port_pub(pmt::mp("out"), pmt::pmt_make_blob(d_pmt_buf, d_payload_len-1));

                            enter_idle();
                        }
                        else
                        {
                            if (d_debug)
                            {
                                std::cout << "IDLE: nprocd: " << nprocd << " bit_ctr: " << d_payload_ctr << " chip_ctr: " << d_chip_ctr << std::endl;
                                // std::cout << "IDLE: ";
                            }
                            enter_locked();
                        }

                        break;


                    case ST_LOCKED:

                        if (d_debug)
                        {
                            std::cout << "LCKD... nprocd < ninput (" << nprocd << " < " << ninput << ")" << std::endl;
                            std::cout << "LCKD: continuing at offset " << d_tags_itr->offset - nitems_read(0) << std::endl;
                        }
                        while (nprocd < ninput && d_payload_ctr < d_payload_len)
                        {
                            float pn = (d_lfsr->get_next_bit() ? -1.0 : 1.0);

                            d_chip_sum += *(in + nprocd) * pn;
                            d_chip_ctr++;

                            if (d_chip_ctr == d_spread_factor)
                            {
                                d_chip_sum_buf[d_payload_ctr++] = d_chip_sum;

                                d_chip_sum = gr_complex(0, 0);
                                d_chip_ctr = 0;
                            }

                            nprocd += d_oversample_factor;
                        }

                        if (d_payload_ctr == d_payload_len)
                        {
                            for (int i = 1; i < d_payload_len; i++)
                            {
                                d_pmt_buf[i-1] = (int)(abs(arg(d_chip_sum_buf[i]) - arg(d_chip_sum_buf[i-1])) > M_PI / 2 ? 1 : 0);
                            }

                            // FIXME: d_payload_len is +1 due to differential encoding
                            message_port_pub(pmt::mp("out"), pmt::pmt_make_blob(d_pmt_buf, d_payload_len-1));

                            if (d_debug)
                            {
                                std::cout << "LCKD: nprocd: " << nprocd << " bit_ctr: " << d_payload_ctr << " chip_ctr: " << d_chip_ctr << std::endl;
                                std::cout << "LCKD: Packet received:" << std::endl;
                                {
                                    for (int i = 1; i < d_payload_ctr; i++)
                                    {
                                        // std::cout << (int)(abs(arg(d_chip_sum_buf[i]) - arg(d_chip_sum_buf[i-1])) > M_PI / 2 ? 1 : 0) << " ";
                                        std::cout << (int)d_pmt_buf[i-1];
                                    }
                                    std::cout << std::endl;
                                }
                            }


                            while (d_tags_itr != d_tags.end() && d_tags_itr->offset - nitems_read(0) < nprocd)
                            {
                                d_tags_itr++;
                            }

                            enter_idle();
                        }
                        else
                        {
                            enter_locked();
                            break;
                        }

                        break;

                    default:

                        throw std::runtime_error ("invalid state");
                }
            }

            d_sample_ctr = nprocd % ninput;

            // std::cout << "DSPR: consumed: " << nprocd << std::endl;
            consume_each(nprocd < ninput ? nprocd : ninput); // FIXME: does nprocd contain the correct value?

            // memcpy(out, in, (nprocd < ninput ? nprocd : ninput) * sizeof (gr_complex));

            // return nprocd < ninput ? nprocd : ninput;
            return 0;
        }

    } /* namespace marmote */
} /* namespace gr */

