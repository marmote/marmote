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
#include "gmsk_packet_framer_b_impl.h"

#include <iostream>
#include <iomanip>

namespace gr {
  namespace marmote {

    gmsk_packet_framer_b::sptr
    gmsk_packet_framer_b::make(bool debug, bool crc)
    {
      return gnuradio::get_initial_sptr (new gmsk_packet_framer_b_impl(debug, crc));
    }

    gmsk_packet_framer_b_impl::gmsk_packet_framer_b_impl(bool debug, bool crc)
      : gr_block("gmsk_packet_framer_b",
          gr_make_io_signature(0, 0, 0),
          gr_make_io_signature(1, 1, sizeof(uint8_t))),
          d_debug(debug),
          d_crc(crc),
          d_msg_len(0),
          d_msg_offset(0)
    {
        message_port_register_in(pmt::mp("in"));

        // Preamble
        d_msg[0] = 0xFF;
        d_msg[1] = 0xFF;
        d_msg[2] = 0xFF;
        d_msg[3] = 0xFF;

        // Start of frame delimiter
        d_msg[4] = 0x70;
        d_msg[5] = 0xEE;
        d_msg[6] = 0xD2;
    }

    gmsk_packet_framer_b_impl::~gmsk_packet_framer_b_impl()
    {
    }

    void
    gmsk_packet_framer_b_impl::forecast (int noutput_items, gr_vector_int &ninput_items_required)
    {
        /* <+forecast+> e.g. ninput_items_required[0] = noutput_items */
    }

    int
    gmsk_packet_framer_b_impl::general_work (int noutput_items,
                       gr_vector_int &ninput_items,
                       gr_vector_const_void_star &input_items,
                       gr_vector_void_star &output_items)
    {
        pmt::pmt_t blob;
        float *out = (float *) output_items[0];

        while (!d_msg_offset)
        {
          pmt::pmt_t msg(delete_head_blocking(pmt::pmt_intern("in")));

          if (pmt::pmt_is_eof_object(msg)) {
            std::cout  << "MAC: exiting" << std::endl;
            return -1;
          }

          if (pmt::pmt_is_symbol(msg))
          {
            const uint8_t* msg_data = (uint8_t*)pmt::pmt_symbol_to_string(msg).data();
            for (int i = 0; i < pmt::pmt_symbol_to_string(msg).length(); i++)
            {
              d_msg[7+i] = msg_data[i] & 0xFF;
            }

            d_msg_len = 7 + pmt::pmt_symbol_to_string(msg).length();

            if (d_debug)
            {
              std::cout << "MAC: sending packet [7+" << (unsigned int)pmt::pmt_symbol_to_string(msg).length() << "]" << std::endl;

              for (int i = 0; i < 7 + pmt::pmt_symbol_to_string(msg).length(); i++)
              {
                if (i == 7)
                  std::cout << " ";
                std::cout << std::setfill('0') << std::setw(2) << std::hex << (d_msg[i] & 0xFF) << " ";
              }
              std::cout << std::endl;
            }

            break;
          }
          else
          {
            std::cout << "@mac_framer_b_impl::general_work: unexpected PMT type" << std::endl;
            assert(false);
          }
        }

        int nout = std::min(d_msg_len - d_msg_offset, noutput_items);
        memcpy(out, d_msg + d_msg_offset, nout);

        d_msg_offset += nout;

        if(d_msg_offset == d_msg_len) {
          d_msg_offset = 0;
        }

        return nout;
    }

    uint16_t gmsk_packet_framer_b_impl::crc16(unsigned char *buf, int len)
    {
      uint16_t crc = 0;

      for (int i = 0; i < len; i++)
      {
        for (int k = 0; k < 8; k++)
        {
          int input_bit = (!!(buf[i] & (1 << k)) ^ (crc & 1));
          crc = crc >> 1;
          if (input_bit)
          {
            crc ^= (1 << 15);
            crc ^= (1 << 10);
            crc ^= (1 <<  3);
          }
        }
      }

      return crc;
    }

  } /* namespace marmote */
} /* namespace gr */

