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

#ifndef INCLUDED_MARMOTE_CDMA_PACKET_SINK_IMPL_H
#define INCLUDED_MARMOTE_CDMA_PACKET_SINK_IMPL_H

#include <marmote/cdma_packet_sink.h>

namespace gr {
  namespace marmote {

    class cdma_packet_sink_impl : public cdma_packet_sink
    {
     private:
      bool d_debug;
      int d_id;

     public:
      cdma_packet_sink_impl(bool debug, int id);
      ~cdma_packet_sink_impl();

      void process_packet(pmt::pmt_t pkt);
    };
    
  } // namespace marmote
} // namespace gr

#endif /* INCLUDED_MARMOTE_CDMA_PACKET_SINK_IMPL_H */

