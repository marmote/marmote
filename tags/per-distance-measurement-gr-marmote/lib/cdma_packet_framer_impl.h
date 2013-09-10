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

#ifndef INCLUDED_MARMOTE_CDMA_PACKET_FRAMER_IMPL_H
#define INCLUDED_MARMOTE_CDMA_PACKET_FRAMER_IMPL_H

#include <marmote/cdma_packet_framer.h>

namespace gr {
  namespace marmote {

    class cdma_packet_framer_impl : public cdma_packet_framer
    {
     private:
      bool d_debug;
      unsigned int d_shr_len;
      int d_pkt_len;
      int d_bit_offset;

      pmt::pmt_t d_srcid;
      pmt::pmt_t d_key;
      pmt::pmt_t d_value;

      static const int MAX_PKT_BUF_LEN = 4096; // FIXME: might be to short
      uint8_t d_pkt_buf[MAX_PKT_BUF_LEN];

     public:
      cdma_packet_framer_impl(bool debug, int shr_len);
      ~cdma_packet_framer_impl();

      // void forecast (int noutput_items, gr_vector_int &ninput_items_required);

      int general_work(int noutput_items,
		       gr_vector_int &ninput_items,
		       gr_vector_const_void_star &input_items,
		       gr_vector_void_star &output_items);
    };

  } // namespace marmote
} // namespace gr

#endif /* INCLUDED_MARMOTE_CDMA_PACKET_FRAMER_IMPL_H */

