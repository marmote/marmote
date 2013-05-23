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
        d_spread_factor(spread_factor)
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

    // TODO: Add state machine for incoming packtes that are too long to be processed by general_work at once
    int
    pn_despreader_impl::general_work (int noutput_items,
                       gr_vector_int &ninput_items,
                       gr_vector_const_void_star &input_items,
                       gr_vector_void_star &output_items)
    {
        const float *in = (const float *) input_items[0];
        int ninput = ninput_items[0];
        int payload_offset;

        // std::cout << "Despreading..." << " [" << nitems_read(0) << ".." << nitems_read(0) + ninput << "]" << std::endl;
        std::cout << "Despreading..." << " [" << ninput << " chips]" << std::endl;

        // Get tags
        d_tags.clear();
        get_tags_in_range(d_tags, 0, nitems_read(0), nitems_read(0) + ninput);

        // std::cout << "dtags size: " << d_tags.size() << std::endl;
        assert(d_tags.size() == 1);

        for (d_tags_itr = d_tags.begin(); d_tags_itr != d_tags.end(); d_tags_itr++)
        {
            payload_offset = d_tags_itr->offset - nitems_read(0);

            assert(d_tags_itr->offset <= nitems_read(0));
            assert(d_payload_len < ninput - payload_offset);

            // std::cout << "Sync tag found at offset: " << payload_offset << " (" << d_tags_itr->offset << ")"
            // << std::setw(10) << "(Source: " << (pmt::pmt_is_symbol(d_tags_itr->srcid) ?  pmt::pmt_symbol_to_string(d_tags_itr->srcid) : "n/a")
            // << std::setw(10) << "Key: " << pmt::pmt_symbol_to_string(d_tags_itr->key)
            // << std::setw(10) << "Value: " << d_tags_itr->value << ")" << std::endl;

            // Despread signal
            


            // Create message
            int chips_to_proc = ninput - payload_offset < d_payload_len ? ninput - payload_offset : d_payload_len;

            std::memcpy(d_pmt_buf, input_items[0] + payload_offset * sizeof(float), chips_to_proc * sizeof(float));

            for (int i = 0; i < d_payload_len; i++)
            {
                std::cout << std::setw(2) << *((float*)d_pmt_buf + i) << " ";                
            }
            std::cout << std::endl;

            message_port_pub(pmt::mp("out"), pmt::pmt_make_blob(d_pmt_buf, chips_to_proc * sizeof(float)));
        }

        consume_each(ninput);

        return 0;
    }

  } /* namespace marmote */
} /* namespace gr */

