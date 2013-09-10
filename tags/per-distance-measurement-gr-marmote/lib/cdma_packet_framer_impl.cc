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

#include <gnuradio/io_signature.h>
#include "cdma_packet_framer_impl.h"

namespace gr {
  namespace marmote {

    cdma_packet_framer::sptr
    cdma_packet_framer::make(bool debug, int shr_len)
    {
      return gnuradio::get_initial_sptr (new cdma_packet_framer_impl(debug, shr_len));
    }

    cdma_packet_framer_impl::cdma_packet_framer_impl(bool debug, int shr_len)
      : gr::block("cdma_packet_framer",
		      gr::io_signature::make(0, 0, 0),
		      gr::io_signature::make(1, 1, sizeof(uint8_t))),
      d_debug(debug),
      d_shr_len(shr_len),
      d_bit_offset(0)
    {
        message_port_register_in(pmt::mp("in"));

        d_key = pmt::string_to_symbol("TX_PN_RST_REQ");
        d_value = pmt::PMT_T;
        std::stringstream str;
        str << name() << "_" << unique_id();
        d_srcid  = pmt::string_to_symbol(str.str());
    }


    cdma_packet_framer_impl::~cdma_packet_framer_impl()
    {
    }


    int
    cdma_packet_framer_impl::general_work (int noutput_items,
                       gr_vector_int &ninput_items,
                       gr_vector_const_void_star &input_items,
                       gr_vector_void_star &output_items)
    {
        pmt::pmt_t blob;
        uint8_t *out = (uint8_t *) output_items[0];
        int nout;

        while (d_bit_offset == 0)
        {
            pmt::pmt_t msg(delete_head_blocking(pmt::intern("in")));

            if (pmt::is_eof_object(msg))
            {
                std::cout  << "pn_spreader_f_impl::general_work: Spreader exiting" << std::endl;
                return -1;
            }

            if (pmt::is_blob(msg))
            {
                blob = msg;
            }
            else if (pmt::is_symbol(msg))
            {
                blob = pmt::make_blob(
                    pmt::symbol_to_string(msg).data(),
                    pmt::symbol_to_string(msg).length());
            }
            else
            {
                std::cerr << "@pn_spreader_f_impl::process_packet: Unexpected PMT type" << std::endl;
                assert(false);
            }

            unsigned int pkt_data_len = pmt::blob_length(blob) * 8;
            uint8_t* pkt_data = (uint8_t*)pmt::blob_data(blob);
            int bit_ctr = 0;

            // Set up synchronization header (preamble)
            for (int i = 0; i < d_shr_len; i++)
            {
                d_pkt_buf[bit_ctr++] = 0x00;
            }

            // Set up payload
            for (int i = 0; i < pkt_data_len; i++)
            {
                uint8_t data_bit = (pkt_data[i/8] << (i % 8)) & 0x80 ? 0x01 : 0x00; // Extract MSB
                d_pkt_buf[bit_ctr++] = data_bit;
            }

            d_pkt_len = bit_ctr;
            d_bit_offset = 0;

            break;
        }

        if (d_bit_offset == 0)
        {
            add_item_tag(0, nitems_written(0), d_key, d_value, d_srcid);
        }

        nout = std::min(d_pkt_len - d_bit_offset, noutput_items);
        memcpy(out, d_pkt_buf + d_bit_offset, nout * sizeof(uint8_t));

        d_bit_offset += nout;

        if (d_bit_offset == d_pkt_len) {
          d_bit_offset = 0;
        }

        if (d_debug)
        {
            std::cout << "Framer: ";
            for (int i = 0; i < nout; i++)
            {
                if (i == d_shr_len)
                {
                    std::cout << " ";
                }
              std::cout << (int)d_pkt_buf[i];
            }
            std::cout << std::endl;
        }

        return nout;
    }

  } /* namespace marmote */
} /* namespace gr */

