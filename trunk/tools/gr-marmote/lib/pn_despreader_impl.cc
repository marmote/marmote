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
#include "pn_despreader_impl.h"

#include <iomanip>

namespace gr {
  namespace marmote {

    pn_despreader::sptr
    pn_despreader::make(int mask, int seed, int seed_offset, int payload_len, int spread_factor)
    {
      return gnuradio::get_initial_sptr (new pn_despreader_impl(mask, seed, seed_offset, payload_len, spread_factor));
    }

    pn_despreader_impl::pn_despreader_impl(int mask, int seed, int seed_offset, int payload_len, int spread_factor)
      : gr_block("pn_despreader",
		      gr_make_io_signature(1, 1, sizeof(float)),
		      gr_make_io_signature(0, 0, 0)),
        d_payload_len(payload_len * 8),
        d_seed_offset(seed_offset),
        d_spread_factor(spread_factor),
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

    void pn_despreader_impl::enter_idle()
    {
        d_state = ST_IDLE;
        d_payload_ctr = 0;
        d_chip_ctr = 0;
        d_chip_sum = 0;

        d_lfsr->reset();
        // FIXME: move this into reset()
        for (int i = 0; i < d_seed_offset; i++)
        {
          d_lfsr->get_next_bit();
        }

        std::cout << "pn_despreader_impl::enter_idle()" << std::endl;
    }

    void pn_despreader_impl::enter_locked()
    {
        d_state = ST_LOCKED;
        std::cout << "pn_despreader_impl::enter_locked()" << std::endl;
    }

    int
    pn_despreader_impl::general_work (int noutput_items,
                       gr_vector_int &ninput_items,
                       gr_vector_const_void_star &input_items,
                       gr_vector_void_star &output_items)
    {
        const float *in = (const float *) input_items[0];
        int ninput = ninput_items[0];
        int nprocd = 0;

        // std::cout << "Despreading..." << " [" << ninput << " chips] " << (d_state == ST_IDLE ? "IDLE" : "LOCKED") << std::endl;
        std::cout << "DSPR: received: " << ninput << " bit_ctr: " << d_payload_ctr << " chip_ctr: " << d_chip_ctr << std::endl;

        d_tags.clear();
        get_tags_in_range(d_tags, 0, nitems_read(0), nitems_read(0) + ninput);
        d_tags_itr = d_tags.begin();

        while (nprocd < ninput)
        {
            switch (d_state)
            {
                case ST_IDLE:

                    std::cout << "IDLE... " << std::endl;

                    while (d_tags_itr != d_tags.end())
                    {
                        nprocd = d_tags_itr->offset - nitems_read(0);

                        std::cout << "IDLE: starting at offset " << d_tags_itr->offset - nitems_read(0) << std::endl;

                        // FIXME: Synchronizer block inserts tags in the future
                        assert(nprocd <= nitems_read(0));

                        while (nprocd < ninput && d_payload_ctr < d_payload_len)
                        {
                            float pn = (d_lfsr->get_next_bit() ? 1.0 : -1.0);

                            d_chip_sum = d_chip_sum + *(in + nprocd) * pn;
                            d_chip_ctr++;

                            if (d_chip_ctr == d_spread_factor)
                            {
                                d_pmt_buf[d_payload_ctr++] = (d_chip_sum > 0.0) ? 1 : 0;

                                d_chip_sum = 0;
                                d_chip_ctr = 0;
                            }

                            nprocd++;
                        }

                        if (d_payload_ctr == d_payload_len)
                        {
                            std::cout << "IDLE: ";
                            std::cout << "Packet received." << std::endl;
                            std::cout << "IDLE: nprocd: " << nprocd << " bit_ctr: " << d_payload_ctr << " chip_ctr: " << d_chip_ctr << std::endl;

                            message_port_pub(pmt::mp("out"), pmt::pmt_make_blob(d_pmt_buf, d_payload_len));

                            while (d_tags_itr != d_tags.end() && d_tags_itr->offset - nitems_read(0) < nprocd)
                            {
                                d_tags_itr++;
                                std::cout << "d_tags_itr++" << std::endl;
                            }
                            std::cout << "IDLE: ";
                            enter_idle();
                        }
                        else
                        {
                            std::cout << "IDLE: nprocd: " << nprocd << " bit_ctr: " << d_payload_ctr << " chip_ctr: " << d_chip_ctr << std::endl;
                            std::cout << "IDLE: ";
                            enter_locked();
                            break; // for
                        }
                    }

                    break;


                case ST_LOCKED:

                    std::cout << "LCKD... nprocd = " << nprocd << " < ninput = " << ninput << std::endl;
                    std::cout << "LCKD: continuing at offset " << d_tags_itr->offset - nitems_read(0) << std::endl;


                    while (d_tags_itr != d_tags.end())
                    {
                        std::cout << "while d_tags_itr (locked)" << std::endl;
                        while (nprocd < ninput && d_payload_ctr < d_payload_len)
                        {
                            std::cout << "while nprocd (locked)" << std::endl;
                            float pn = (d_lfsr->get_next_bit() ? 1.0 : -1.0);

                            d_chip_sum += *(in + nprocd) * pn;
                            d_chip_ctr++;

                            if (d_chip_ctr == d_spread_factor)
                            {
                                d_pmt_buf[d_payload_ctr++] = (d_chip_sum > 0.0) ? 1 : 0;

                                d_chip_sum = 0;
                                d_chip_ctr = 0;
                            }

                            nprocd++;
                        }

                        if (d_payload_ctr == d_payload_len)
                        {
                            std::cout << "LCKD: ";
                            std::cout << "Packet received." << std::endl;
                            std::cout << "LCKD: nprocd: " << nprocd << " bit_ctr: " << d_payload_ctr << " chip_ctr: " << d_chip_ctr << std::endl;
                            message_port_pub(pmt::mp("out"), pmt::pmt_make_blob(d_pmt_buf, d_payload_len));

                            while (d_tags_itr != d_tags.end() && d_tags_itr->offset - nitems_read(0) < nprocd)
                            {
                                d_tags_itr++;
                                std::cout << "d_tags_itr++" << std::endl;
                            }
                            std::cout << "LCKD: ";
                            enter_idle();
                        }
                        else
                        {
                            std::cout << "LCKD: ";
                            enter_locked();
                            break;
                        }

                        break;
                    }
            }
        }

        std::cout << "DSPR: consumed: " << nprocd << std::endl;
        consume_each(nprocd);

        return 0;
    }

  } /* namespace marmote */
} /* namespace gr */

