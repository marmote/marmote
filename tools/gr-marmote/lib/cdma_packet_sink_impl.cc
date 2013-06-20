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

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include <gr_io_signature.h>
#include "cdma_packet_sink_impl.h"

#include <iomanip>

namespace gr {
  namespace marmote {

    cdma_packet_sink::sptr
    cdma_packet_sink::make(bool debug, int id)
    {
      return gnuradio::get_initial_sptr (new cdma_packet_sink_impl(debug, id));
    }

    cdma_packet_sink_impl::cdma_packet_sink_impl(bool debug, int id)
      : gr_block("cdma_packet_sink",
		      gr_make_io_signature(0, 0, 0),
		      gr_make_io_signature(0, 0, 0)),
        d_debug(debug),
        d_id(id)
    {
      message_port_register_in(pmt::mp("in"));
      set_msg_handler(pmt::mp("in"), boost::bind(&cdma_packet_sink_impl::process_packet, this, _1));
    }

    cdma_packet_sink_impl::~cdma_packet_sink_impl()
    {
    }

    void cdma_packet_sink_impl::process_packet(pmt::pmt_t pkt)
    {
      if (pmt::pmt_is_blob(pkt))
      {
        // std::cout << "Processing packet..." << " [" << (int)(pmt::pmt_blob_length(pkt)) << " bits]" << std::endl;

        if (d_debug)
        {
          std::cout << "    #" << d_id << " <- ";

          uint8_t octet = 0;
          uint8_t* payload = (uint8_t*)pmt::pmt_blob_data(pkt);

          for (int i = 0; i < pmt::pmt_blob_length(pkt); i++)
          {
            octet = (octet << 1) | payload[i];
            if (i % 8 == 7)
            {
              std::cout << std::setw(2) << std::setfill('0') << std::hex << (int)octet << std::dec << " ";
            }
          }
          std::cout << std::endl;

          // for (int i = 0; i < pmt::pmt_blob_length(pkt); i++)
          // {
          //   std::cout << std::setw(2) << (int)payload[i] << " ";
          // }
          // std::cout << std::endl;
        }
      }
      else if (pmt::pmt_is_symbol(pkt))
      {

        const char* data = pmt::pmt_symbol_to_string(pkt).data();

        for (int j = 0; j < pmt::pmt_symbol_to_string(pkt).length(); j++)
        {
          std::cout << std::setw(2) << (int)data[j] << " ";
        }
        std::cout << std::endl;
      }
      else
      {
        std::cerr << "@cdma_packet_sink_impl::process_packet: unexpected PMT type" << std::endl;
        assert(false);
      }
    }

  } /* namespace marmote */
} /* namespace gr */

