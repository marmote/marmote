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

#include <gnuradio/io_signature.h>
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
            : gr::block("pn_despreader_cc",
                    gr::io_signature::make(1, 1, sizeof (gr_complex)),
                    gr::io_signature::make(1, 1, sizeof (gr_complex))),
            d_debug(debug),
            d_mask(mask),
            d_seed(seed),
            d_spread_factor(spread_factor),
            d_oversample_factor(oversample_factor),
            d_preamble_len(preamble_length),
            d_payload_len(payload_length * 8 + 1), // FIXME: add this bit for differential decoding in a different way
            d_seed_offset((preamble_length-1)*spread_factor),
            d_debug_ctr(0),
            d_debug_ctr_max(25)
        {
            d_lfsr = new mseq_lfsr(mask, seed);
            set_history(d_spread_factor * d_oversample_factor);
            enter_idle();
            d_prev_tag = 0;

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

            float diff_arg;

            d_tags.clear();
            get_tags_in_range(d_tags, 0, nitems_read(0), nitems_read(0) + ninput);
            d_tags_itr = d_tags.begin();

            std::vector<gr::tag_t>::iterator lti;

            // nprocd = ninput;
            // // std::cout << "Despreader nprocd: " << nprocd << std::endl;
            // memcpy(out, in, nprocd * sizeof (gr_complex));

            // if (!d_tags.empty())
            // {
            //     std::cout << "DSPR: [" << std::setw(7) << nitems_read(0) << " - " << std::setw(7)  << nitems_read(0) + ninput << "]" << std::endl;
            //     // std::cout << "Tags [" << d_tags.size() << "]: ";
            //     for (lti = d_tags.begin(); lti != d_tags.end(); lti++)
            //     {
            //         // std::cout << "[" << std::setw(7) << (int)lti->offset << "] @ " << (int)(lti->offset - nitems_read(0)) << " ";
            //         // out[(int)lti->offset - nitems_read(0)].imag(-2.0);
            //         // std::cout << "Tag diff: " << (int)lti->offset << " - " << d_prev_tag << " = " << (int)lti->offset - d_prev_tag << std::endl;
            //         // std::cout << "Tag: " << (int)lti->offset << " @ " << (int)(lti->offset - nitems_read(0))  << std::endl;
            //         std::cout << " -> Tag: " << (int)lti->offset << std::endl;
            //         std::cout << "@ " << (int)(lti->offset - nitems_read(0)) << std::endl;
                
            //         d_prev_tag = lti->offset;
            //     }
            //     // std::cout << std::endl;
            // }
            // consume_each(nprocd);
            // return nprocd;

            // memset(out, 0, sizeof (gr_complex) * ninput);
            // for (int i = 0; i < ninput; i++)
            // {
            //     out[i].real(abs(in[i]));
            //     out[i].imag(arg(in[i]));
            // }
            for (int i = 0; i < ninput; i++)
            {
                out[i] = gr_complex(0, 0);
            }

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

                            d_chip_sum += in[nprocd] * pn;
                            d_chip_ctr++;

                            for (int k = nprocd; k < nprocd + d_oversample_factor; k++)
                            {
                                out[k].real(abs(d_chip_sum));
                                // out[k].imag(arg(d_chip_sum));
                            }

                            if (d_chip_ctr == d_spread_factor)
                            {
                                d_chip_sum_buf[d_payload_ctr++] = d_chip_sum;
                                d_chip_sum = 0;
                                d_chip_ctr = 0;
                            }

                            // out[nprocd].real(4.0);
                            // out[nprocd].imag(4.0);
                            if (nprocd > ninput - d_oversample_factor)
                            {
                                // std::cout << "IDLE: boundary" << std::endl;
                                // out[nprocd].real(6.0);
                                out[nprocd].imag(6.0);
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
                                    diff_arg = abs(arg(d_chip_sum_buf[i]) - arg(d_chip_sum_buf[i-1]));
                                    std::cout << (int)(diff_arg > M_PI / 2 ? 1 : 0) << " ";
                                }
                                std::cout << std::endl;

                            }

                            for (int i = 1; i < d_payload_len; i++)
                            {
                                diff_arg = abs(arg(d_chip_sum_buf[i]) - arg(d_chip_sum_buf[i-1]));
                                d_pmt_buf[i-1] = (int)(diff_arg > M_PI / 2 && diff_arg < 3 * M_PI / 2 ? 1 : 0);
                            }

                            // if (d_debug_ctr++ < d_debug_ctr_max)
                            // {
                            //     std::cout << "IDLE: " << std::endl;
                            //     debug_pkt(d_pmt_buf, d_payload_len-1);
                            //     debug_chip(d_chip_sum_buf, d_payload_len);
                            // }


                            // FIXME: d_payload_len is +1 due to differential encoding
                            message_port_pub(pmt::mp("out"), pmt::make_blob(d_pmt_buf, d_payload_len-1));

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

                            d_chip_sum += in[nprocd] * pn;
                            d_chip_ctr++;

                            for (int k = nprocd; k < nprocd + d_oversample_factor; k++)
                            {
                                out[k].real(abs(d_chip_sum));
                                // out[k].imag(arg(d_chip_sum));
                            }


                            if (d_chip_ctr == d_spread_factor)
                            {
                                d_chip_sum_buf[d_payload_ctr++] = d_chip_sum;

                                d_chip_sum = gr_complex(0, 0);
                                d_chip_ctr = 0;
                            }

                            // out[nprocd].real(-4.0);
                            // out[nprocd].imag(-4.0);
                            if (nprocd > ninput - d_oversample_factor)
                            {
                                // std::cout << "LCKD: boundary" << std::endl;
                                out[nprocd].imag(-6.0);
                                // out[nprocd].real(-6.0);
                            }

                            nprocd += d_oversample_factor;
                        }

                        if (d_payload_ctr == d_payload_len)
                        {
                            for (int i = 1; i < d_payload_len; i++)
                            {
                                diff_arg = abs(arg(d_chip_sum_buf[i]) - arg(d_chip_sum_buf[i-1]));
                                d_pmt_buf[i-1] = (int)(diff_arg > M_PI / 2 && diff_arg < 3 * M_PI / 2 ? 1 : 0);
                                // d_pmt_buf[i-1] = (int)(abs(arg(d_chip_sum_buf[i]) - arg(d_chip_sum_buf[i-1])) > M_PI / 2 ? 1 : 0);
                            }

                            // FIXME: d_payload_len is +1 due to differential encoding
                            message_port_pub(pmt::mp("out"), pmt::make_blob(d_pmt_buf, d_payload_len-1));

                            // if (d_debug_ctr++ < d_debug_ctr_max)
                            // {
                            //     std::cout << "LCKD:" << std::endl;
                            //     debug_pkt(d_pmt_buf, d_payload_len-1);
                            //     debug_chip(d_chip_sum_buf, d_payload_len);
                            // }

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
            nprocd = nprocd < ninput ? nprocd : ninput;

            // std::cout << "DSPR: consumed: " << nprocd << std::endl;
            consume_each(nprocd);
            return nprocd;
        }

        void pn_despreader_cc_impl::debug_chip(gr_complex buf[], int len)
        {
            std::cout << "chip_sum_buf: " << std::endl;
            float diff_arg;

            for (int i = 0; i < len; i++)
            {
                std::cout << "[" << std::fixed << std::setprecision(2) << abs(buf[i]) << "] ";
                std::cout << std::fixed << std::setfill(' ') << std::setw(6) << std::setprecision(2) << arg(buf[i]) << " ";
                if (i > 0)
                {
                    diff_arg = arg(buf[i]) - arg(buf[i-1]);
                    std::cout << std::fixed << std::setw(6) << std::setprecision(2) << diff_arg << " ";
                    std::cout << "  " << std::setw(1) << (abs(diff_arg) > M_PI / 2 && abs(diff_arg) < 3 * M_PI / 2 ? 1 : 0);
                }

                if ((i-1) % 8 == 7)
                    std::cout << std::endl;

                std::cout << std::endl;
            }

        }

        void pn_despreader_cc_impl::debug_pkt(uint8_t buf[], int len)
        {
            int k = 0;
            uint8_t octet = 0;
            uint8_t* payload = buf;
            uint8_t oct_buf[32];
            uint16_t crc;


            // Assemble packet
            for (int i = 0; i < len; i++)
            {
                octet = (octet << 1) | buf[i];
                if (i % 8 == 7)
                {
                    oct_buf[k++] = octet;
                    std::cout << std::setw(2) << std::setfill('0') << std::hex << (int)octet << std::dec << " ";
                }
            }

            // Check CRC
            if (k >= 3 && (crc_16(oct_buf, k-2) != ((oct_buf[k-2] << 8) + oct_buf[k-1])))
            {
                std::cout << "#" << std::endl;
            }

            std::cout << std::endl;
            std::cout << std::endl;

            for (int i = 0; i < len; i++)
            {
                std::cout << (int)buf[i];
                if (i % 8 == 7)
                    std::cout << std::endl;
            }

            std::cout << std::endl;
        }

        uint16_t pn_despreader_cc_impl::crc_16(const uint8_t data[], uint8_t length)
        {
            uint8_t bit;
            uint8_t byte;
            uint16_t crc;

            crc = 0;
            for (byte = 0; byte < length; ++byte)
            {
                crc ^= (data[byte] << 8);

                for (bit = 8; bit > 0; --bit)
                {
                    if (crc & (1 << 15))
                    {
                        crc = (crc << 1) ^ 0x1021uL;
                    }
                    else
                    {
                        crc = (crc << 1);
                    }
                }
            }

            return crc;
        }

    } /* namespace marmote */
} /* namespace gr */

