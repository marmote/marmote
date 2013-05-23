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
#include "pn_synchronizer_impl.h"

#include <iomanip>

namespace gr {
  namespace marmote {

    pn_synchronizer::sptr
    pn_synchronizer::make(bool reverse, int mask, int seed, int preamble_len, int spread_factor)
    {
      return gnuradio::get_initial_sptr (new pn_synchronizer_impl(reverse, mask, seed, preamble_len, spread_factor));
    }

    pn_synchronizer_impl::pn_synchronizer_impl(bool reverse, int mask, int seed, int preamble_len, int spread_factor)
      : gr_sync_block("pn_synchronizer",
		      gr_make_io_signature(1, 1, sizeof (float)),
		      gr_make_io_signature(1, 2, sizeof (float))),
              d_reverse(reverse),
              d_filter_len(preamble_len * spread_factor)
    {
         // Initialize filter
        d_lfsr = new mseq_lfsr(mask, seed);
        d_filter_coeffs = new float[d_filter_len];

        for (int i = 0; i < d_filter_len; i++)
        {
            d_filter_coeffs[i] = d_lfsr->get_next_bit() ? 1.0 : -1.0;        
        }

        set_history(d_filter_len);

        // Set threshold for tagging
        d_threshold = 0.75 * d_filter_len;

        d_key = pmt::pmt_string_to_symbol("PN sync");
        d_value = pmt::PMT_T;
        std::stringstream str;
        str << name() << "_" << unique_id();
        d_srcid  = pmt::pmt_string_to_symbol(str.str());
    }


    pn_synchronizer_impl::~pn_synchronizer_impl()
    {
      delete d_lfsr;
      delete[] d_filter_coeffs;
    }


    int
    pn_synchronizer_impl::work(int noutput_items,
			  gr_vector_const_void_star &input_items,
			  gr_vector_void_star &output_items)
    {
        const float *in = (const float *) input_items[0];
        float *out = (float *) output_items[0];
        float *filt_out = (float *) output_items[1];

        std::cout << "Synchronizing... [" << noutput_items << " chips]" << std::endl;

        for (int i = 0; i < noutput_items; i++)
        {
            filt_out[i] = 0;
            if (d_reverse)
            {
                for (int j = 0; j < d_filter_len; j++)
                {
                    filt_out[i] += in[i+j] * d_filter_coeffs[j];
                }
            }
            else
            {                
                for (int j = 0; j < d_filter_len; j++)
                {
                    filt_out[i] += in[i+j] * d_filter_coeffs[d_filter_len-j];
                }
            }   

            if (filt_out[i] > d_threshold)
            {
                add_item_tag(0, nitems_written(0) + i + d_filter_len, d_key, d_value, d_srcid); // FIXME: currently adding tag to future item
                // std::cout << "Threshold crossed at " << i << " (" << nitems_written(0)+i << ") " << filt_out[i] << " (" << d_threshold << ")" << std::endl;
            }

            out[i] = in[i];
        }

        for (int i = 0; i < noutput_items; i++)
        {
            std::cout << std::setw(2) << out[i] << " ";
        }
        std::cout << std::endl;


        return noutput_items;
    }

  } /* namespace marmote */
} /* namespace gr */

