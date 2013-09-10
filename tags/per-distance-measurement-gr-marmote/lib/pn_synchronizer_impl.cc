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
#include "pn_synchronizer_impl.h"

#include <iomanip>

namespace gr {
  namespace marmote {

    pn_synchronizer::sptr
    pn_synchronizer::make(bool debug, int mask, int seed, int preamble_len, int spread_factor, int oversample_factor,
                          float threshold_factor_rise, int look_ahead, float alpha)
    {
      return gnuradio::get_initial_sptr (new pn_synchronizer_impl(debug, mask, seed, preamble_len, spread_factor, oversample_factor,
                                         threshold_factor_rise, look_ahead, alpha));
    }

    pn_synchronizer_impl::pn_synchronizer_impl(bool debug, int mask, int seed, int preamble_len, int spread_factor, int oversample_factor,
                                               float threshold_factor_rise, int look_ahead, float alpha)
      : gr::sync_block("pn_synchronizer",
		      gr::io_signature::make(1, 1, sizeof (gr_complex)),
		      gr::io_signature::make3(2, 3, sizeof (gr_complex), sizeof (float), sizeof (float))),
              d_debug(debug),
              d_oversample_factor(oversample_factor),
              d_filter_len(preamble_len * spread_factor),
              d_preamble_len(preamble_len),
              d_spread_factor(spread_factor),
              // peak detector
              d_threshold(threshold_factor_rise),
              d_look_ahead(look_ahead),
              d_alpha(alpha),
              d_avg(0.001f),
              d_found(false)
    {
         // Initialize filter
        d_lfsr = new mseq_lfsr(mask, seed);
        d_filter_coeffs = new float[d_filter_len];
        set_history(d_filter_len * d_oversample_factor);

        for (int i = 0; i < d_filter_len; i++)
        {
            d_filter_coeffs[i] = d_lfsr->get_next_bit() ? 1.0 : -1.0;
        }

        // Tag
        d_key = pmt::string_to_symbol("PN sync");
        d_value = pmt::PMT_T;
        std::stringstream str;
        str << name() << "_" << unique_id();
        d_srcid  = pmt::string_to_symbol(str.str());

        std::cout << "Filter length: " << d_filter_len << std::endl;
        std::cout << "Oversample factor: " << d_oversample_factor << std::endl;
        std::cout << "Threshold: " << d_threshold << std::endl;
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
        float *avg_out = (float *)output_items[2];

        // if (d_debug)
        //     std::cout << "Synchronizing... [" << noutput_items << " chips]" << std::endl;

        float si, sq;

        for (int i = 0; i < noutput_items; i++)
        {
            filt_out[i] = 0;
            si = 0;
            sq = 0;

            for (int j = 0; j < d_filter_len; j++)
            {
                si += in[i+j*d_oversample_factor].real() * d_filter_coeffs[j];
                sq += in[i+j*d_oversample_factor].imag() * d_filter_coeffs[j];
            }

            filt_out[i] = si*si + sq*sq;

            if (!d_found)
            {
              // if (filt_out[i] > d_avg * (1.0f + d_threshold))
              if (filt_out[i] > d_threshold)
              {
                d_found = true;
                d_look_ahead_remaining = d_look_ahead;
                // d_peak_val = -(float)INFINITY;
                d_peak_val = filt_out[i];
                d_peak_idx = i;
                if (d_debug)
                {
                  std::cout << "[" << nitems_read(0) << ":" << nitems_read(0) + noutput_items << "] ";
                  std::cout << "Fixed threshold crossed at " << nitems_read(0) + i << " with value " << filt_out[i] << " (" << filt_out[i]/d_avg << ")"  << std::endl;
                }
              }
              else
              {
                d_avg = d_alpha*filt_out[i] + (1.0f - d_alpha)*d_avg;
              }
            }
            else
            {
              if (filt_out[i] > d_peak_val)
              {
                d_peak_val = filt_out[i];
                d_peak_idx = i;
                // std::cout << "Fixed look ahead at " << i  << " with value " << filt_out[i] << std::endl;
              }
              else if (d_look_ahead_remaining <= 0)
              {
                if (d_debug)
                {
                  std::cout << "[" << nitems_read(0) << ":" << nitems_read(0) + noutput_items << "] ";
                  std::cout << "Fixed done at " << nitems_read(0) + d_peak_idx << " with value " << d_peak_val << std::endl;
                }
                // if (d_debug)
                // {
                //     std::cout << "Threshold crossed at " << d_peak_idx - 1 << std::endl;
                //     // std::cout << " (" << nitems_written(0) + d_peak_idx - 1 << ") " <<
                //     // "avg: " << d_avg << " val: " << filt_out[d_peak_idx - 1] << std::endl;
                // }
                // Adds tag to the first payload bit (chip)
                // add_item_tag(0, nitems_written(0) + d_peak_idx-1 + ((d_preamble_len+1)*d_spread_factor)*d_oversample_factor-1, d_key, d_value, d_srcid);
                // out[d_peak_idx + d_filter_len * d_oversample_factor - 1].imag(2.0); // DEBUG: imag part is used for temporary debugging

                // Adds tag one bite before the first payload bit (chip) to aid differential encoding
                // add_item_tag(0, nitems_written(0) + d_peak_idx-1 + ((d_preamble_len)*d_spread_factor)*d_oversample_factor-1, d_key, d_value, d_srcid);
                add_item_tag(0, nitems_written(0) + d_peak_idx - 1 + ((d_preamble_len)*d_spread_factor)*d_oversample_factor-1, d_key, d_value, d_srcid);
                // out[d_peak_idx + (d_preamble_len-1 * d_spread_factor) * d_oversample_factor - 1].imag(2.0); // FIXME

                d_found = false;
              }

              d_look_ahead_remaining--;
            }

            avg_out[i] = d_avg;

            out[i] = in[i];
            // out[i].real(in[i].real()); // DEBUG: imag part is used for temporary debugging
        }

        return noutput_items;
    }

  } /* namespace marmote */
} /* namespace gr */

