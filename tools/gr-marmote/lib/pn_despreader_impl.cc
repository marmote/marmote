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
        d_payload_len(payload_len * 8 * spread_factor),
        d_spread_factor(spread_factor),
        d_state(ST_IDLE)
    {
        lfsr = new mseq_lfsr(mask, seed);

        for (int i = 0; i < seed_offset; i++)
        {
          lfsr->get_next_bit();
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

        // std::cout << "pn_despreader_impl::enter_idle()" << std::endl;
    }

    void pn_despreader_impl::enter_locked()
    {
        d_state = ST_LOCKED;
        // std::cout << "pn_despreader_impl::enter_locked()" << std::endl;
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

        // std::cout << "Despreading..." << " [" << ninput << " chips]" << std::endl;

        d_tags.clear();
        get_tags_in_range(d_tags, 0, nitems_read(0), nitems_read(0) + ninput);
        d_tags_itr = d_tags.begin();

        while (nprocd < ninput)
        {
            switch (d_state)
            {
                case ST_IDLE:

                    while (d_tags_itr != d_tags.end())
                    {
                        // Go with the first synchronizer tag
                        nprocd = d_tags_itr->offset - nitems_read(0);

                        // FIXME: Synchronizer block inserts tags in the future
                        assert(nprocd <= nitems_read(0));

                        // Despread signal
                        while (nprocd < ninput && d_payload_ctr < d_payload_len)
                        {
                            // Copy message
                            std::memcpy(d_pmt_buf + d_payload_ctr, in + nprocd, sizeof(float));

                            // std::cout << std::setw(2) << *((float*)d_pmt_buf + d_payload_ctr) << " ";                

                            nprocd++;
                            d_payload_ctr++;
                        }
                        // std::cout << std::endl;

                        if (d_payload_ctr == d_payload_len)
                        {
                            message_port_pub(pmt::mp("out"), pmt::pmt_make_blob(d_pmt_buf, d_payload_len * sizeof(float)));
                            while (d_tags_itr != d_tags.end() && d_tags_itr->offset - nitems_read(0) < nprocd)
                            {
                                d_tags_itr++;
                            }
                            // if (d_tags_itr == d_tags.end())
                            //     std::cout << "end-of-tag-list reached" << std::endl;
                            // else
                            //     std::cout << "new tag offset: " << d_tags_itr->offset - nitems_read(0) << " nprocd: " << nprocd << std::endl;
                            // enter_idle();
                        }
                        else
                        {
                            enter_locked();
                            break; // for
                        }
                    }

                    break;



                case ST_LOCKED:

                    while (d_tags_itr != d_tags.end())
                    {
                        // Despread signal
                        while (nprocd < ninput && d_payload_ctr < d_payload_len)
                        {
                            // Copy message
                            std::memcpy(d_pmt_buf + d_payload_ctr, in + nprocd, sizeof(float));

                            // std::cout << std::setw(2) << *((float*)d_pmt_buf + d_payload_ctr) << " ";                

                            nprocd++;
                            d_payload_ctr++;
                        }
                        // std::cout << std::endl;

                        // std::cout << "L: d_payload_ctr: " << d_payload_ctr << " / " << d_payload_len << std::endl;

                        if (d_payload_ctr == d_payload_len)
                        {
                            message_port_pub(pmt::mp("out"), pmt::pmt_make_blob(d_pmt_buf, d_payload_len * sizeof(float)));
                            while (d_tags_itr != d_tags.end() && d_tags_itr->offset - nitems_read(0) < nprocd)
                            {
                                d_tags_itr++;
                                // std::cout << "tags++" << std::endl;
                            }

                            // if (d_tags_itr == d_tags.end())
                            //     std::cout << "end-of-tag-list reached" << std::endl;
                            // else
                            //     std::cout << "new tag offset: " << d_tags_itr->offset - nitems_read(0) << " nprocd: " << nprocd << std::endl;

                            enter_idle();
                        }
                        else
                        {
                            enter_locked();
                            break;
                        }

                        break;
                    }
            }
        }

        consume_each(nprocd);

        return 0;
    }

  } /* namespace marmote */
} /* namespace gr */

