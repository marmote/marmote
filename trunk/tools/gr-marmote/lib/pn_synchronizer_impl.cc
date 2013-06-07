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
    pn_synchronizer::make(bool debug, int mask, int seed, int preamble_len, int spread_factor, int oversample_factor,
                          float threshold_factor_rise, int look_ahead, float alpha)
    {
      return gnuradio::get_initial_sptr (new pn_synchronizer_impl(debug, mask, seed, preamble_len, spread_factor, oversample_factor,
                                         threshold_factor_rise, look_ahead, alpha));
    }

    pn_synchronizer_impl::pn_synchronizer_impl(bool debug, int mask, int seed, int preamble_len, int spread_factor, int oversample_factor,
                                               float threshold_factor_rise, int look_ahead, float alpha)
      : gr_sync_block("pn_synchronizer",
		      gr_make_io_signature(1, 1, sizeof (gr_complex)),
		      gr_make_io_signature3(2, 3, sizeof (gr_complex), sizeof (float), sizeof (float))),
              d_debug(debug),
              d_oversample_factor(oversample_factor),
              d_filter_len(preamble_len * spread_factor),
              // peak detector
              d_threshold_factor_rise(threshold_factor_rise),
              d_look_ahead(look_ahead),
              d_alpha(alpha)
              // d_avg(0.0f),
              // d_found(false)
    {
         // Initialize filter
        d_lfsr = new mseq_lfsr(mask, seed);
        d_filter_coeffs = new float[d_filter_len];
        set_history(d_filter_len * d_oversample_factor);

        for (int i = 0; i < d_filter_len; i++)
        {
            d_filter_coeffs[i] = d_lfsr->get_next_bit() ? 1.0 : -1.0;
        }

        // peak detector
        // d_threshold_factor_rise = 100.0; // (threshold_factor_rise),
        // d_look_ahead = 1*oversample_factor; // (look_ahead),
        // d_alpha = 0.01; // (alpha),
        d_avg = 0.0f,
        d_found = false;

        // Tag
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

            for (int j = 0; j < d_filter_len; j++)
            {
                si += in[i+j*d_oversample_factor].real() * d_filter_coeffs[j];
                sq += in[i+j*d_oversample_factor].imag() * d_filter_coeffs[j];
            }

            filt_out[i] = si*si + sq*sq;

            if (!d_found)
            {
              // Have not yet detected presence of peak
              if (filt_out[i] > d_avg * (1.0f + d_threshold_factor_rise))
              {
                d_found = true;
                d_look_ahead_remaining = d_look_ahead;
                d_peak_val = -(float)INFINITY;
              }
              else
              {
                d_avg = d_alpha*filt_out[i] + (1.0f - d_alpha)*d_avg;
              }
            }
            else
            {
              // Detected presence of peak
              if (filt_out[i] > d_peak_val)
              {
                d_peak_val = filt_out[i];
                d_peak_ind = i;
              }
              else if (d_look_ahead_remaining <= 0)
              {
                if (d_debug)
                {
                    std::cout << "Threshold crossed at " << std::setw(4) << d_peak_ind << " (" << nitems_written(0)+d_peak_ind << ") " << (float)filt_out[i] << " (" << d_threshold << ")" << std::endl;
                }
                add_item_tag(0, nitems_written(0) + d_peak_ind + d_filter_len * d_oversample_factor, d_key, d_value, d_srcid);
                d_found = false;
                d_avg = filt_out[i];
              }

              // Have not yet located peak, loop and keep searching.
              d_look_ahead_remaining--;
            }

            // Every iteration of the loop, write debugging signal out if connected.
            if(output_items.size() == 3) {
              float *avg = (float *)output_items[2];
              avg[i] = d_avg;
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

