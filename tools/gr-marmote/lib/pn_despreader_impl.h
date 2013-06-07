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

#ifndef INCLUDED_MARMOTE_PN_DESPREADER_IMPL_H
#define INCLUDED_MARMOTE_PN_DESPREADER_IMPL_H

#include <marmote/pn_despreader.h>
#include <marmote/mseq_lfsr.h>

namespace gr {
  namespace marmote {

    class pn_despreader_impl : public pn_despreader
    {
     private:
        std::vector<gr_tag_t> d_tags;
        std::vector<gr_tag_t>::iterator d_tags_itr;
        mseq_lfsr* d_lfsr;

        enum state_t { ST_IDLE, ST_LOCKED };

        state_t d_state;

        gr_complex d_chip_sum; // integrator
        static const int MAX_CHIP_LEN = 4096;
        uint8_t d_pmt_buf[MAX_CHIP_LEN];

        int d_chip_ctr;
        int d_payload_ctr; // bits

        int d_seed_offset;
        int d_payload_len; // bits
        int d_spread_factor;

        int d_oversample_factor;

        bool d_debug;
        int d_sample_offset; // for oversampling


        void enter_idle();
        void enter_locked();

     public:
      pn_despreader_impl(bool debug, int mask, int seed, int seed_offset, int payload_len, int spread_factor, int oversample_factor);
      ~pn_despreader_impl();

      void forecast (int noutput_items, gr_vector_int &ninput_items_required);

      int general_work(int noutput_items,
		       gr_vector_int &ninput_items,
		       gr_vector_const_void_star &input_items,
		       gr_vector_void_star &output_items);
    };

  } // namespace marmote
} // namespace gr

#endif /* INCLUDED_MARMOTE_PN_DESPREADER_IMPL_H */

