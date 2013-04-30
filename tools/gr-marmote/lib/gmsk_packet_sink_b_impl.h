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

    static const int MAX_PKT_LEN    = 127;

    class gmsk_packet_sink_b_impl : public gmsk_packet_sink_b
    {
     private:
        enum {STATE_SYNC_SEARCH, STATE_HAVE_SYNC, STATE_HAVE_HEADER} d_state;

        uint32_t              d_sync_vector;            // 0x70eed2 b'011100001110111011010010'
        static const uint8_t  d_sync_vector_len = 24;   // bits
        uint32_t              d_shift_reg;
        uint8_t               d_bit_cnt;
        uint8_t               d_packet_len;
        uint8_t               d_packet[MAX_PKT_LEN];    // without header
        uint8_t               d_pmt_buf[MAX_PKT_LEN];
        uint8_t               d_packet_byte_cnt;
        bool                  d_debug;

        void enter_search(void);
        void enter_have_sync(void);
        void enter_have_header(void);



     public:
        gmsk_packet_sink_b_impl(bool debug);
        ~gmsk_packet_sink_b_impl();

      int general_work(int noutput_items,
		       gr_vector_int &ninput_items,
		       gr_vector_const_void_star &input_items,
		       gr_vector_void_star &output_items);
    };

  } // namespace marmote
} // namespace gr

#endif /* INCLUDED_MARMOTE_GMSK_PACKET_SINK_B_IMPL_H */

