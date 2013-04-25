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
#include "mac_framer_b_impl.h"

#include <iostream>
#include <iomanip>

namespace gr {
  namespace marmote {

    mac_framer_b::sptr
    mac_framer_b::make(bool debug)
    {
      return gnuradio::get_initial_sptr (new mac_framer_b_impl(debug));
    }

    mac_framer_b_impl::mac_framer_b_impl(bool debug)
      : gr_block("mac_framer_b",
		      gr_make_io_signature(0, 0, 0),
		      gr_make_io_signature(1, 1, sizeof(uint8_t))),
          d_debug(debug),
          d_ctr(0)
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

    mac_framer_b_impl::~mac_framer_b_impl()
    {
    }

    void
    mac_framer_b_impl::forecast (int noutput_items, gr_vector_int &ninput_items_required)
    {
        /* <+forecast+> e.g. ninput_items_required[0] = noutput_items */
    }

    int
    mac_framer_b_impl::general_work (int noutput_items,
                       gr_vector_int &ninput_items,
                       gr_vector_const_void_star &input_items,
                       gr_vector_void_star &output_items)
    {
        const char *a;

        pmt::pmt_t blob;
        float *out = (float *) output_items[0];

        while (!d_msg_offset)
        {
          pmt::pmt_t msg(delete_head_blocking(pmt::pmt_intern("in")));

          if (pmt::pmt_is_eof_object(msg)) {
            std::cout  << "MAC: exiting" << std::endl;
            return -1;
          }

          // Handle strings only
          if (pmt::pmt_is_symbol(msg))
          {
              std::cout << "MAC: received new message" << std::endl;
              // std::cout << "\"" << pmt::pmt_symbol_to_string(msg).data() << "\"" << std::endl;
              // std::cout << pmt::pmt_symbol_to_string(msg).length() << std::endl;

              // blob = pmt::pmt_make_blob(
              //   pmt::pmt_symbol_to_string(msg).data(),
              //   pmt::pmt_symbol_to_string(msg).length());

              // std::cout << "blob length: " << pmt::pmt_blob_length(blob) << std::endl;
              // std::cout << "blob data:   " << std::endl;

              //   for (int i = 0; i < pmt::pmt_blob_length(blob); i++)
              //   {
              //     std::cout << std::setfill('0') << std::setw(2) << std::hex << (*((const char*)pmt::pmt_blob_data(blob)+i) & 0xFF) << std::dec << " ";
              //     if(i % 16 == 15) {
              //       std::cout << std::endl;
              //     }
              //   }
              //   std::cout << std::endl;

              break;
          }
          else
          {
            assert(false);
          }
        }

        // length
        d_msg[7] = 0x07;

        // Payload
        for (int i = 0; i < 4; i++)
        {
          d_msg[8+i] = d_ctr++;
        }

        // CRC (dummy for now)
        d_msg[8+4] = 0x00;
        d_msg[8+5] = 0x00;

        int nout = std::min(14, noutput_items);
        memcpy(out, d_msg, nout);

        if (d_debug)
        {
          std::cout << "noutput_items: " << noutput_items << std::endl;
        }

        return nout;
    }

  } /* namespace marmote */
} /* namespace gr */

