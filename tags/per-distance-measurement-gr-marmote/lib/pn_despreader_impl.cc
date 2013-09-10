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
#include "pn_despreader_impl.h"

#include <iomanip>

namespace gr {
  namespace marmote {

    pn_despreader::sptr
    pn_despreader::make(bool debug, int mask, int seed, int seed_offset, int payload_len, int spread_factor, int oversample_factor)
    {
      return gnuradio::get_initial_sptr (new pn_despreader_impl(debug, mask, seed, seed_offset, payload_len, spread_factor, oversample_factor));
    }

    pn_despreader_impl::pn_despreader_impl(bool debug, int mask, int seed, int seed_offset, int payload_len, int spread_factor, int oversample_factor)
      : gr::block("pn_despreader",
		      gr::io_signature::make(1, 1, sizeof(gr_complex)),
		      gr::io_signature::make(0, 0, 0)),
        d_debug(debug),
        d_payload_len(payload_len * 8),
        d_seed_offset(seed_offset),
        d_spread_factor(spread_factor),
        d_oversample_factor(oversample_factor),
        d_state(ST_IDLE)
    {
        d_lfsr = new mseq_lfsr(mask, seed);

        for (int i = 0; i < seed_offset; i++)
        {
          d_lfsr->get_next_bit();
        }

        message_port_register_out(pmt::mp("out"));
    }

    pn_despreader_impl::~pn_despreader_impl()
    {
    }

    void pn_despreader_impl::forecast (int noutput_items, gr_vector_int &ninput_items_required)
    {
        // ninput_items_required[0] = history() + noutput_items * d_spread_factor; // FIXME: revise this calculation
        ninput_items_required[0] = noutput_items * d_spread_factor; // FIXME: revise this calculation
    }


    void pn_despreader_impl::enter_idle()
    {
        d_state = ST_IDLE;
        d_payload_ctr = 0;
        d_chip_ctr = 0;
        d_chip_sum = 0;
        d_sample_offset = 0;

        d_lfsr->reset();
        // FIXME: move this into reset()
        for (int i = 0; i < d_seed_offset; i++)
        {
          d_lfsr->get_next_bit();
        }

        // if (d_debug)
        //     std::cout << "pn_despreader_impl::enter_idle()" << std::endl;
    }

    void pn_despreader_impl::enter_locked()
    {
        d_state = ST_LOCKED;

        // if (d_debug)
        //     std::cout << "pn_despreader_impl::enter_locked()" << std::endl;
    }

    int
    pn_despreader_impl::general_work (int noutput_items,
                       gr_vector_int &ninput_items,
                       gr_vector_const_void_star &input_items,
                       gr_vector_void_star &output_items)
    {
        const gr_complex *in = (const gr_complex *) input_items[0];
        int ninput = ninput_items[0];
        int nprocd = d_sample_offset;

        std::vector<gr::tag_t>::iterator lti;

        if (d_debug)
        {
            std::cout << "Despreading..." << " [" << ninput << " chips] " << (d_state == ST_IDLE ? "IDLE" : "LOCKED") << std::endl;
            std::cout << "DSPR: received: " << ninput << " bit_ctr: " << d_payload_ctr << " chip_ctr: " << d_chip_ctr;
            std::cout << " sample_offset: " << d_sample_offset << std::endl;
        }

        d_tags.clear();
        get_tags_in_range(d_tags, 0, nitems_read(0), nitems_read(0) + ninput);
        d_tags_itr = d_tags.begin();

        while (nprocd < ninput)
        {
            switch (d_state)
            {
                case ST_IDLE:

                    if (d_debug)
                    {
                        std::cout << "IDLE... ";
                        std::cout << "nprocd: " << nprocd << " ninput: " << ninput << std::endl;

                        std::cout << "Tags: ";
                        for (lti = d_tags.begin(); lti != d_tags.end(); lti++)
                        {
                            std::cout << (int)lti->offset << " ";
                            // std::cout << (int)(lti->offset - nitems_read(0)) << " ";
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
                        std::cout << "d_tags_itr++ (IDLE)" << std::endl;

                        d_tags_itr++;
                        break;
                    }

                    nprocd = d_tags_itr->offset - nitems_read(0);

                    if (d_debug)
                    {
                        std::cout << "IDLE: starting at offset " << d_tags_itr->offset - nitems_read(0) << std::endl;

                        for (int k = nprocd; k < ninput; k++)
                        {
                            // std::cout << std::setw(2) << in[k].real() << " ";
                            std::cout << (in[k].real() > 0 ? 0 : 1) << " ";
                        }
                        std::cout << std::endl;
                    }

                    // FIXME: Synchronizer block inserts tags in the future
                    assert(nprocd <= nitems_read(0));

                    while (nprocd < ninput && d_payload_ctr < d_payload_len)
                    {
                        // std::cout << int(in[nprocd] > 0.0 ? 0 : 1) << " ";

                        float pn = (d_lfsr->get_next_bit() ? 1.0 : -1.0);

                        // d_chip_sum = d_chip_sum + in[nprocd] * pn;
                        d_chip_sum.real(d_chip_sum.real() + in[nprocd].real() * pn);
                        d_chip_sum.imag(d_chip_sum.imag() + in[nprocd].imag() * pn);
                        d_chip_ctr++;

                        if (d_chip_ctr == d_spread_factor)
                        {
                            d_pmt_buf[d_payload_ctr++] = (d_chip_sum.real() > 0.0) ? 1 : 0;

                            d_chip_sum = 0;
                            d_chip_ctr = 0;
                        }

                        // nprocd++;
                        nprocd += d_oversample_factor;
                    }
                    // std::cout << std::endl;

                    if (d_payload_ctr == d_payload_len)
                    {
                        if (d_debug)
                        {
                            std::cout << "IDLE: ";
                            std::cout << "Packet received." << std::endl;
                            std::cout << "IDLE: nprocd: " << nprocd << " bit_ctr: " << d_payload_ctr << " chip_ctr: " << d_chip_ctr << std::endl;
                        }

                        // if (d_debug)
                        {
                            for (int i = 0; i < d_payload_ctr; i++)
                            {
                                std::cout << (int)d_pmt_buf[i] << " ";
                            }
                            std::cout << std::endl;
                        }
                        message_port_pub(pmt::mp("out"), pmt::make_blob(d_pmt_buf, d_payload_len));

                        if (d_debug)
                            std::cout << "IDLE: ";
                        enter_idle();
                    }
                    else
                    {
                        if (d_debug)
                        {
                            std::cout << "IDLE: nprocd: " << nprocd << " bit_ctr: " << d_payload_ctr << " chip_ctr: " << d_chip_ctr << std::endl;
                            std::cout << "IDLE: ";
                        }
                        enter_locked();
                    }

                    break;


                case ST_LOCKED:

                    if (d_debug)
                    {
                        std::cout << "LCKD... nprocd = " << nprocd << " < ninput = " << ninput << std::endl;
                        std::cout << "LCKD: continuing at offset " << d_tags_itr->offset - nitems_read(0) << std::endl;

                        for (int k = nprocd; k < ninput; k++)
                        {
                            // std::cout << std::setw(2) << in[k].real() << " ";
                            std::cout << (in[k].real() > 0 ? 0 : 1) << " ";
                        }
                        std::cout << std::endl;
                    }

                    // std::cout << "while d_tags_itr (locked)" << std::endl;
                    while (nprocd < ninput && d_payload_ctr < d_payload_len)
                    {
                        // std::cout << "while nprocd (locked)" << std::endl;
                        float pn = (d_lfsr->get_next_bit() ? 1.0 : -1.0);

                        d_chip_sum += *(in + nprocd) * pn;
                        d_chip_ctr++;

                        if (d_chip_ctr == d_spread_factor)
                        {
                            // d_pmt_buf[d_payload_ctr++] = (arg(d_chip_sum) > 0.0) ? 1 : 0; // FIXME
                            d_pmt_buf[d_payload_ctr++] = (d_chip_sum.real() > 0.0) ? 1 : 0;

                            d_chip_sum = gr_complex(0, 0);
                            d_chip_ctr = 0;
                        }

                        // nprocd++;
                        nprocd += d_oversample_factor;
                    }

                    if (d_payload_ctr == d_payload_len)
                    {
                        if (d_debug)
                        {
                            std::cout << "LCKD: ";
                            std::cout << "Packet received." << std::endl;
                            std::cout << "LCKD: nprocd: " << nprocd << " bit_ctr: " << d_payload_ctr << " chip_ctr: " << d_chip_ctr << std::endl;
                        }

                        if (d_debug)
                            // std::cout << "Packet received." << std::endl;
                        {
                            for (int i = 0; i < d_payload_ctr; i++)
                            {
                                std::cout << (int)d_pmt_buf[i] << " ";
                            }
                            std::cout << std::endl;
                        }
                        message_port_pub(pmt::mp("out"), pmt::make_blob(d_pmt_buf, d_payload_len));

                        while (d_tags_itr != d_tags.end() && d_tags_itr->offset - nitems_read(0) < nprocd)
                        {
                            std::cout << "d_tags_itr++ (LCKD)" << std::endl;
                            d_tags_itr++;
                        }

                        if (d_debug)
                            std::cout << "LCKD: ";
                        enter_idle();
                    }
                    else
                    {
                        if (d_debug)
                            std::cout << "LCKD: ";
                        enter_locked();
                        break;
                    }

                    break;
            }
        }

        d_sample_offset = nprocd % ninput;

        // std::cout << "DSPR: consumed: " << nprocd << std::endl;
        consume_each(nprocd < ninput ? nprocd : ninput);

        return 0;
    }

  } /* namespace marmote */
} /* namespace gr */

