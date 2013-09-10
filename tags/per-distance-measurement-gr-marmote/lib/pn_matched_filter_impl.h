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

#ifndef INCLUDED_MARMOTE_PN_MATCHED_FILTER_IMPL_H
#define INCLUDED_MARMOTE_PN_MATCHED_FILTER_IMPL_H

#include <marmote/pn_matched_filter.h>
#include <marmote/mseq_lfsr.h>

namespace gr {
  namespace marmote {

    class pn_matched_filter_impl : public pn_matched_filter
    {
     private:
      bool d_debug;

      int d_mask;
      int d_seed;
      int d_preamble_len;
      int d_spread_factor;
      int d_oversample_factor;

      // Filter
      mseq_lfsr* d_lfsr;

      uint32_t* d_filt_coef;
      uint32_t* d_filt_mask;
      uint32_t* d_buf_samp;
      uint32_t* d_buf_xcor;

      int d_coef_len;
      int d_filt_len_oct;
      int d_filt_len_bit;

      void print_input_items(int noutput_items, gr_vector_const_void_star &input_items);
      void print_input_items_binary(int noutput_items, gr_vector_const_void_star &input_items);
      void print_uint32_t_binary(const uint32_t val, const char* msg);
      void print_buffers(const uint32_t* buf, int len);
      void shift_buffers(uint32_t* buf, int len);
      void shift_buffers(uint32_t* buf, int len, int lsb);
      void xcorr_buffers(uint32_t* res, uint32_t* buf1, uint32_t* buf2, int len);

      unsigned int count_bits32(unsigned int x);

     public:
      pn_matched_filter_impl(bool debug, int mask, int seed, int preamble_len, int spread_factor, int oversample_factor);
      ~pn_matched_filter_impl();

      int work(int noutput_items,
	       gr_vector_const_void_star &input_items,
	       gr_vector_void_star &output_items);
    };

  } // namespace marmote
} // namespace gr

#endif /* INCLUDED_MARMOTE_PN_MATCHED_FILTER_IMPL_H */

