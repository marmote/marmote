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
#include "peak_tagger_cc_impl.h"

namespace gr {
  namespace marmote {

    peak_tagger_cc::sptr
    peak_tagger_cc::make(int threshold)
    {
      return gnuradio::get_initial_sptr
        (new peak_tagger_cc_impl(threshold));
    }

    peak_tagger_cc_impl::peak_tagger_cc_impl(int threshold)
      : gr::sync_block("peak_tagger_cc",
              gr::io_signature::make2(2, 2, sizeof(gr_complex), sizeof(int)),
              //gr::io_signature::make(1, 1, sizeof(gr_complex)),
              gr::io_signature::make(1, 1, sizeof(gr_complex))),
        d_threshold(threshold)
    {
        //set_history(0); // TODO: update based on 'OS'
        
        std::stringstream str;
        str << name() << "_" << unique_id();
        d_key = pmt::string_to_symbol("PN sync");
        d_value = pmt::PMT_T;
        d_srcid  = pmt::string_to_symbol(str.str());
    }

    peak_tagger_cc_impl::~peak_tagger_cc_impl()
    {
    }

    int
    peak_tagger_cc_impl::work(int noutput_items,
			  gr_vector_const_void_star &input_items,
			  gr_vector_void_star &output_items)
    {
        const gr_complex *in = (const gr_complex *) input_items[0];
        const int *trig = (const int *) input_items[1];
        gr_complex *out = (gr_complex *) output_items[0];

        memcpy(out, in, noutput_items);

        for (int i = 0; i < noutput_items; i++)
        {
            if (trig[i] > d_threshold)
            {
                add_item_tag(0, nitems_read(0) + i, d_key, d_value, d_srcid);
            }
        }

        return noutput_items;
    }

  } /* namespace marmote */
} /* namespace gr */

