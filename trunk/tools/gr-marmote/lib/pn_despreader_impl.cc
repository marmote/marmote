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
		      gr_make_io_signature(0, 0, 0))
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

    int
    pn_despreader_impl::general_work (int noutput_items,
                       gr_vector_int &ninput_items,
                       gr_vector_const_void_star &input_items,
                       gr_vector_void_star &output_items)
    {
        const float *in = (const float *) input_items[0];
        int ninput = ninput_items[0];

        std::cout << "pn_despreader_impl::general_work: [INVOKED] " << std::endl;
        std::cout << "start: " << nitems_read(0) << " end: " << nitems_read(0) + ninput << std::endl;

        // Get tags
        d_tags.clear();
        get_tags_in_range(d_tags, 0, nitems_read(0), nitems_read(0) + ninput);
        std::cout << "dtags size: " << d_tags.size() << std::endl;

        for (d_tags_itr = d_tags.begin(); d_tags_itr != d_tags.end(); d_tags_itr++)
        {
            std::cout << "Sync tag found:";

            std::cout << std::setw(10) << "Offset: " << d_tags_itr->offset
            << std::setw(10) << "Source: " << (pmt::pmt_is_symbol(d_tags_itr->srcid) ?  pmt::pmt_symbol_to_string(d_tags_itr->srcid) : "n/a")
            << std::setw(10) << "Key: " << pmt::pmt_symbol_to_string(d_tags_itr->key)
            << std::setw(10) << "Value: ";
            std::cout << d_tags_itr->value << std::endl;

            // TODO: Despread signal

            // TODO: Create message
            // std::memcpy(d_pmt_buf, d_packet, d_packet_len);
            // message_port_pub(pmt::mp("out"), pmt::pmt_make_blob(d_pmt_buf, d_packet_len));
            message_port_pub(pmt::mp("out"), pmt::pmt_string_to_symbol("Hello-bello"));
        }

        consume_each(ninput);

        return 0;
    }

  } /* namespace marmote */
} /* namespace gr */

