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

#ifndef INCLUDED_MARMOTE_MAC_DEFRAMER_IMPL_H
#define INCLUDED_MARMOTE_MAC_DEFRAMER_IMPL_H

#include <marmote/mac_deframer.h>

namespace gr {
  namespace marmote {

    static const int MAX_PKT_LEN    = 127;

    class mac_deframer_impl : public mac_deframer
    {
     private:
	 bool d_debug;

     public:
      mac_deframer_impl(bool debug);
      ~mac_deframer_impl();
      void pkt_handler(pmt::pmt_t pkt);
    };

  } // namespace marmote
} // namespace gr

#endif /* INCLUDED_MARMOTE_MAC_DEFRAMER_IMPL_H */

