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

#ifndef INCLUDED_MARMOTE_PN_SPREADER_B_IMPL_H
#define INCLUDED_MARMOTE_PN_SPREADER_B_IMPL_H

#include <marmote/pn_spreader_b.h>
#include <marmote/mseq_lfsr.h>

namespace gr {
  namespace marmote {

    class pn_spreader_b_impl : public pn_spreader_b
    {
     private:
      bool d_debug;
      int d_mask;
      int d_seed;
      int d_sf;
      mseq_lfsr d_lfsr;
      std::vector<gr_tag_t> d_tags;
      std::vector<gr_tag_t>::iterator d_tags_itr;

     public:
      pn_spreader_b_impl(bool debug, int mask, int seed, int spread_factor);
      ~pn_spreader_b_impl();

      // Where all the action really happens
      int work(int noutput_items,
	       gr_vector_const_void_star &input_items,
	       gr_vector_void_star &output_items);
    };

  } // namespace marmote
} // namespace gr

#endif /* INCLUDED_MARMOTE_PN_SPREADER_B_IMPL_H */

