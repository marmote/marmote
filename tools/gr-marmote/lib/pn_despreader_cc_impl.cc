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
#include "pn_despreader_cc_impl.h"

namespace gr {
  namespace marmote {

    pn_despreader_cc::sptr pn_despreader_cc::make(bool debug, int mask, int seed, int spread_factor, int oversample_factor, int preamble_length, int payload_length)
    {
      return gnuradio::get_initial_sptr (new pn_despreader_cc_impl(debug, mask, seed, spread_factor, oversample_factor, preamble_length, payload_length));
    }

    pn_despreader_cc_impl::pn_despreader_cc_impl(bool debug, int mask, int seed, int spread_factor, int oversample_factor, int preamble_length, int payload_length)
      : gr_block("pn_despreader_cc",
		      gr_make_io_signature(1, 1, sizeof (gr_complex)),
		      gr_make_io_signature(1, 1, sizeof (gr_complex))),
        d_debug(debug),
        d_mask(mask),
        d_seed(seed),
        d_spread_factor(spread_factor),
        d_oversample_factor(oversample_factor),
        d_preamble_len(preamble_length),
        d_payload_len(payload_length * 8),
        d_filter_len(preamble_length * spread_factor),
        d_state(ST_SEARCH)
    {
         // Initialize filter
        d_lfsr = new mseq_lfsr(mask, seed);
        d_filter_coeffs = new float[d_filter_len];

        for (int i = 0; i < d_filter_len; i++)
        {
            d_filter_coeffs[i] = d_lfsr->get_next_bit() ? 1.0 : -1.0;
        }

        set_history(d_filter_len * d_oversample_factor);
    }

    pn_despreader_cc_impl::~pn_despreader_cc_impl()
    {
      delete d_lfsr;
      delete[] d_filter_coeffs;
    }

    void pn_despreader_cc_impl::forecast (int noutput_items, gr_vector_int &ninput_items_required)
    {
      ninput_items_required[0] = history() + noutput_items * d_spread_factor; // FIXME: revise this calculation
    }

    void pn_despreader_cc_impl::enter_search()
    {
        d_state = ST_SEARCH;
        d_lfsr->reset();

        if (d_debug)
            std::cout << "pn_despreader_impl::enter_search()" << std::endl;
    }

    void pn_despreader_cc_impl::enter_track()
    {
        d_state = ST_TRACK;

        if (d_debug)
            std::cout << "pn_despreader_impl::enter_track()" << std::endl;
    }

    int pn_despreader_cc_impl::general_work (int noutput_items,
                       gr_vector_int &ninput_items,
                       gr_vector_const_void_star &input_items,
                       gr_vector_void_star &output_items)
    {
        const gr_complex *in = (const gr_complex *) input_items[0];
        gr_complex *out = (gr_complex *) output_items[0];

        int ninput = ninput_items[0];
        int nprocd = 0;

        while (nprocd < noutput_items)
        {
          switch (d_state)
          {
            // PN-matched filter
            case ST_SEARCH:
              // filt_out[nprocd] = 0;
              // for (int j = 0; j < d_filter_len; j++)
              // {
              //   filt_out[i] += in[i+j*d_oversample_factor] * d_filter_coeffs[j];
              // }

              // if (filt_out[i] > d_threshold)
              // {
              //     // FIXME: currently adding tag to future item
              //     add_item_tag(0, nitems_written(0) + i + d_filter_len * d_oversample_factor, d_key, d_value, d_srcid);

              //     if (d_debug)
              //     {
              //         std::cout << "Threshold crossed at " << std::setw(4) << i << " (" << nitems_written(0)+i << ") " << filt_out[i] << " (" << d_threshold << ")" << std::endl;
              //         for (int k = i + d_filter_len * d_oversample_factor; k < noutput_items; k++)
              //         {
              //             // std::cout << std::setw(2) << int(in[k] > 0.0 ? 0 : 1) << " ";
              //             std::cout << int(in[k] > 0.0 ? 0 : 1) << " ";
              //         }
              //         std::cout << std::endl;
              //     }
              // }

              break;

            // DLL
            case ST_TRACK:
              throw std::runtime_error ("state not implemented yet");
              break;

            default:
              throw std::runtime_error ("invalid state");
          }
        }

        consume_each(0); // FIXME

        return nprocd;
    }

  } /* namespace marmote */
} /* namespace gr */

