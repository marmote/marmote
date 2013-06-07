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
    pn_synchronizer::make(bool debug, bool reverse, int mask, int seed, int preamble_len, int spread_factor, float threshold, int oversample_factor)
    {
      return gnuradio::get_initial_sptr (new pn_synchronizer_impl(debug, reverse, mask, seed, preamble_len, spread_factor, threshold, oversample_factor));
    }

    pn_synchronizer_impl::pn_synchronizer_impl(bool debug, bool reverse, int mask, int seed, int preamble_len, int spread_factor, float threshold, int oversample_factor)
      : gr_sync_block("pn_synchronizer",
		      gr_make_io_signature(1, 1, sizeof (gr_complex)),
		      gr_make_io_signature2(2, 2, sizeof (gr_complex), sizeof (float))),
              d_debug(debug),
              d_reverse(reverse),
              d_oversample_factor(oversample_factor),
              d_filter_len(preamble_len * spread_factor)
    {
         // Initialize filter
        d_lfsr = new mseq_lfsr(mask, seed);
        d_filter_coeffs = new float[d_filter_len];

        for (int i = 0; i < d_filter_len; i++)
        {
            d_filter_coeffs[i] = d_lfsr->get_next_bit() ? 1.0 : -1.0;
        }

        set_history(d_filter_len * d_oversample_factor);

        // Set threshold for tagging
        d_threshold = threshold * d_filter_len;

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
        const gr_complex *in = (const gr_complex*) input_items[0];
        gr_complex *out = (gr_complex *) output_items[0];
        float *filt_out = (float *) output_items[1];

        if (d_debug)
            std::cout << "Synchronizing... [" << noutput_items << " chips]" << std::endl;

        // for (int i = 0; i < noutput_items; i++)
        // {
        //     std::cout << std::setw(2) << (in[i] < 0.0 ? 1 : 0) << " ";
        // }
        // std::cout << std::endl;

        float si, sq;

        for (int i = 0; i < noutput_items; i++)
        {
            filt_out[i] = 0;
            si = 0;
            sq = 0;
            if (d_reverse)
            {
                for (int j = 0; j < d_filter_len; j++)
                {
                    si += in[i+j*d_oversample_factor].real() * d_filter_coeffs[j];
                    sq += in[i+j*d_oversample_factor].imag() * d_filter_coeffs[j];
                }
                filt_out[i] = si*si + sq*sq;
            }
            else
            {
                for (int j = 0; j < d_filter_len; j++)
                {
                    si += in[i+j*d_oversample_factor].real() * d_filter_coeffs[d_filter_len-j];
                    sq += in[i+j*d_oversample_factor].imag() * d_filter_coeffs[d_filter_len-j];
                }
                filt_out[i] = si*si + sq*sq;
            }

            if (filt_out[i] > d_threshold)
            {
                // FIXME: currently adding tag to future item
                add_item_tag(0, nitems_written(0) + i + d_filter_len * d_oversample_factor, d_key, d_value, d_srcid);

                if (d_debug)
                {
                    std::cout << "Threshold crossed at " << std::setw(4) << i << " (" << nitems_written(0)+i << ") " << (float)filt_out[i] << " (" << d_threshold << ")" << std::endl;
                    // for (int k = i + d_filter_len * d_oversample_factor; k < noutput_items; k++)
                    // {
                    //     std::cout << in[k] << " ";
                    // }
                    // std::cout << std::endl;
                }
            }

            out[i] = in[i];
        }

        // for (int i = 0; i < noutput_items; i++)
        // {
        //     std::cout << std::setw(2) << (out[i] < 0.0 ? 1 : 0) << " ";
        // }
        // std::cout << std::endl;

        return noutput_items;
    }

  } /* namespace marmote */
} /* namespace gr */

