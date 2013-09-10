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

#ifndef INCLUDED_MARMOTE_GMSK_PACKET_FRAMER_B_IMPL_H
#define INCLUDED_MARMOTE_GMSK_PACKET_FRAMER_B_IMPL_H

#include <marmote/gmsk_packet_framer_b.h>

namespace gr {
  namespace marmote {

    class gmsk_packet_framer_b_impl : public gmsk_packet_framer_b
    {
     private:
      bool          d_debug;
      bool          d_crc;
      unsigned char d_msg[128];
      int           d_msg_len;
      int           d_msg_offset;

      uint16_t crc16(unsigned char *buf, int len);


     public:
      gmsk_packet_framer_b_impl(bool debug, bool crc);
      ~gmsk_packet_framer_b_impl();

      void forecast (int noutput_items, gr_vector_int &ninput_items_required);

      int general_work(int noutput_items,
		       gr_vector_int &ninput_items,
		       gr_vector_const_void_star &input_items,
		       gr_vector_void_star &output_items);
    };

  } // namespace marmote
} // namespace gr

#endif /* INCLUDED_MARMOTE_GMSK_PACKET_FRAMER_B_IMPL_H */

