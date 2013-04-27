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

#ifndef INCLUDED_MARMOTE_GMSK_PACKET_SINK_B_IMPL_H
#define INCLUDED_MARMOTE_GMSK_PACKET_SINK_B_IMPL_H

#include <marmote/gmsk_packet_sink_b.h>

namespace gr {
  namespace marmote {

    class gmsk_packet_sink_b_impl : public gmsk_packet_sink_b
    {
     private:
        enum {STATE_SYNC_SEARCH, STATE_HAVE_SYNC, STATE_HAVE_HEADER} d_state;

        uint32_t              d_sync_vector;            // 0x70eed2 b'011100001110111011010010'
        static const uint8_t  d_sync_vector_len = 24;   // bits
        uint32_t              d_shift_reg;
        bool                  d_verbose;

        void enter_search(void);
        void enter_have_sync(void);


     public:
        gmsk_packet_sink_b_impl(bool verbose);
        ~gmsk_packet_sink_b_impl();

      int general_work(int noutput_items,
		       gr_vector_int &ninput_items,
		       gr_vector_const_void_star &input_items,
		       gr_vector_void_star &output_items);
    };

  } // namespace marmote
} // namespace gr

#endif /* INCLUDED_MARMOTE_GMSK_PACKET_SINK_B_IMPL_H */

