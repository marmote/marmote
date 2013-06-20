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

#ifndef INCLUDED_MARMOTE_MAC_FRAMER_B_IMPL_H
#define INCLUDED_MARMOTE_MAC_FRAMER_B_IMPL_H

#include <marmote/mac_framer_b.h>

namespace gr {
  namespace marmote {

    class mac_framer_b_impl : public mac_framer_b
    {
     private:
      bool			d_debug;
      int			d_ctr;
      unsigned char d_msg[128];
      int			d_msg_len;
      int			d_msg_offset;

  	  // MAC header
  	  uint16_t		d_seq_num;
  	  uint16_t		d_dst_addr;

     public:
      mac_framer_b_impl(bool debug);
      ~mac_framer_b_impl();
	  uint16_t crc16(unsigned char *buf, int len);

      int general_work(int noutput_items,
		       gr_vector_int &ninput_items,
		       gr_vector_const_void_star &input_items,
		       gr_vector_void_star &output_items);
    };

  } // namespace marmote
} // namespace gr

#endif /* INCLUDED_MARMOTE_MAC_FRAMER_B_IMPL_H */

