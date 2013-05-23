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

#ifndef INCLUDED_MARMOTE_CDMA_PACKET_SOURCE_IMPL_H
#define INCLUDED_MARMOTE_CDMA_PACKET_SOURCE_IMPL_H

#include <marmote/cdma_packet_source.h>

namespace gr {
  namespace marmote {

    class cdma_packet_source_impl : public cdma_packet_source
    {
     private:
      unsigned int d_payload_len;
      unsigned int d_seq_num;

      uint8_t* d_pkt_buf;

      bool d_debug;

     public:
      cdma_packet_source_impl(bool debug, unsigned int payload_len);
      ~cdma_packet_source_impl();

      void make_packet(pmt::pmt_t msg);


      // int general_work(int noutput_items,
		    //    gr_vector_int &ninput_items,
		    //    gr_vector_const_void_star &input_items,
		    //    gr_vector_void_star &output_items);
    };

  } // namespace marmote
} // namespace gr

#endif /* INCLUDED_MARMOTE_CDMA_PACKET_SOURCE_IMPL_H */

