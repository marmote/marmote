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

#ifndef INCLUDED_MARMOTE_PN_SYNCHRONIZER_IMPL_H
#define INCLUDED_MARMOTE_PN_SYNCHRONIZER_IMPL_H

#include <marmote/pn_synchronizer.h>
#include <marmote/mseq_lfsr.h>


namespace gr {
  namespace marmote {

    class pn_synchronizer_impl : public pn_synchronizer
    {
     private:
      bool d_debug;
      int d_oversample_factor;
      int d_filter_len;
      int d_preamble_len;
      int d_spread_factor;
      float* d_filter_coeffs;
      mseq_lfsr* d_lfsr;

      pmt::pmt_t d_srcid;
      pmt::pmt_t d_key;
      pmt::pmt_t d_value;

      float d_threshold;
      int d_look_ahead;
      int d_look_ahead_remaining;
      int d_peak_idx;
      float d_peak_val;
      float d_alpha;
      float d_avg;
      bool d_found;

     public:
      pn_synchronizer_impl(bool debug, int mask, int seed, int preamble_len, int spread_factor, int oversample_factor,
                           float threshold_factor_rise, int look_ahead, float alpha);
      ~pn_synchronizer_impl();

      int work(int noutput_items,
	       gr_vector_const_void_star &input_items,
	       gr_vector_void_star &output_items);
    };

  } // namespace marmote
} // namespace gr

#endif /* INCLUDED_MARMOTE_PN_SYNCHRONIZER_IMPL_H */

