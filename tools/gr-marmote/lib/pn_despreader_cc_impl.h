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

#ifndef INCLUDED_MARMOTE_PN_DESPREADER_CC_IMPL_H
#define INCLUDED_MARMOTE_PN_DESPREADER_CC_IMPL_H

#include <marmote/pn_despreader_cc.h>
#include <marmote/mseq_lfsr.h>

namespace gr {
  namespace marmote {

    class pn_despreader_cc_impl : public pn_despreader_cc
    {
     private:
      bool d_debug;
      int d_mask;
      int d_seed;
      int d_spread_factor;
      int d_oversample_factor;
      int d_preamble_len; // bits
      int d_payload_len; // bits

      enum state_t { ST_SEARCH, ST_TRACK };
      state_t d_state;

      mseq_lfsr* d_lfsr;
      int d_filter_len;
      float* d_filter_coeffs;


      void enter_search();
      void enter_track();


     public:
      pn_despreader_cc_impl(bool debug, int mask, int seed, int spread_factor, int oversample_factor, int preamble_length, int payload_length);
      ~pn_despreader_cc_impl();

      void forecast (int noutput_items, gr_vector_int &ninput_items_required);

      int general_work(int noutput_items,
           gr_vector_int &ninput_items,
           gr_vector_const_void_star &input_items,
           gr_vector_void_star &output_items);
    };

  } // namespace marmote
} // namespace gr

#endif /* INCLUDED_MARMOTE_PN_DESPREADER_CC_IMPL_H */

