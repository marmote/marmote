/* -*- c++ -*- */
/* 
 * Copyright 2013 Sandor Szilvasi.
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
    peak_tagger_cc::make(int threshold, int lookahead, int delay)
    {
      return gnuradio::get_initial_sptr
        (new peak_tagger_cc_impl(threshold, lookahead, delay));
    }

    peak_tagger_cc_impl::peak_tagger_cc_impl(int threshold, int lookahead, int delay)
      : gr::sync_block("peak_tagger_cc",
              gr::io_signature::make2(2, 2, sizeof(gr_complex), sizeof(int)),
              gr::io_signature::make(1, 1, sizeof(gr_complex))),
        d_threshold(threshold),
        d_found(false),
        d_wait_min(lookahead),
        d_delay(delay),
        d_wait_ctr(0)
    {
        // Prepare for tag insertion in the 'past'
        d_hist_idx = (d_delay < 0) ? -d_delay : 0;
        set_history(1 + (d_delay < 0 ? -d_delay : d_delay));

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

        for (int i = d_hist_idx; i < d_hist_idx + noutput_items; i++)
        {
            if (!d_found)
            {
                if (trig[i] > d_threshold)
                {
                    d_found = true;
                    d_wait_ctr = 0;

                    d_peak_val = trig[i];
                    d_peak_idx = nitems_read(0) + i;
                }
            }
            else
            {
                if (trig[i] > d_peak_val)
                {
                    d_peak_val = trig[i];
                    d_peak_idx = nitems_read(0) + i;
                }
                else if (d_wait_ctr >= d_wait_min)
                {
                    add_item_tag(0, d_peak_idx + d_delay, d_key, d_value, d_srcid);
                    d_found = false;
                }

                d_wait_ctr++;
            }
        }

        memcpy(out, in, sizeof(gr_complex) * noutput_items);

        return noutput_items;
    }

  } /* namespace marmote */
} /* namespace gr */

