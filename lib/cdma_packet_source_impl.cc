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
#include "cdma_packet_source_impl.h"

#include <iomanip>

namespace gr {
  namespace marmote {

    cdma_packet_source::sptr
    cdma_packet_source::make(bool debug, int id, unsigned int payload_len)
    {
      return gnuradio::get_initial_sptr (new cdma_packet_source_impl(debug, id, payload_len));
    }


    cdma_packet_source_impl::cdma_packet_source_impl(bool debug, int id, unsigned int payload_len)
      : gr::block("cdma_packet_source",
		      gr::io_signature::make(0, 0, 0),
		      gr::io_signature::make(0, 0, 0)),
          d_debug(debug),
          d_payload_len(payload_len),
          d_seq_num(0),
          d_id(id)
    {
      message_port_register_out(pmt::mp("out"));
      message_port_register_in(pmt::mp("in"));
      set_msg_handler(pmt::mp("in"), boost::bind(&cdma_packet_source_impl::make_packet, this, _1));

      d_pkt_buf = new uint8_t[payload_len];
    }


    cdma_packet_source_impl::~cdma_packet_source_impl()
    {
      delete[] d_pkt_buf;
    }


    void cdma_packet_source_impl::make_packet(pmt::pmt_t msg)
    {
      if (pmt::is_eof_object(msg))
      {
        message_port_pub(pmt::mp("out"), pmt::PMT_EOF);
        // detail().get()->set_done(true);
        return;
      }

      if (pmt::is_integer(msg))
      {
        // d_pkt_buf[0] = (uint8_t)pmt::to_long(msg);
        // d_pkt_buf[0] = d_id;

        for (int i = 0; i < d_payload_len; i++)
        {
          d_pkt_buf[i] = (uint8_t)(d_seq_num++);          
        }

        if (d_debug)
        {
          std::cout << "#" << d_id << " -> ";
          for (int i = 0; i < d_payload_len; i++)
          {
            std::cout << std::setw(2) << std::hex << (int)d_pkt_buf[i] << std::dec << " ";
          }
          std::cout << std::endl;
        }

        pmt::pmt_t pkt = pmt::make_blob(d_pkt_buf, sizeof(uint8_t) * d_payload_len);
        message_port_pub(pmt::mp("out"), pkt);
      }
      else if (pmt::is_symbol(msg))
      {
        std::cout << "Generating packet..." << " [" << d_payload_len << " bytes]" << std::endl;

        std::cout << "From packet generator: " << pmt::symbol_to_string(msg) << std::endl;

        for (int i = 0; i < d_payload_len; i++)
        {
          d_pkt_buf[i] = (uint8_t)(d_seq_num++);
          
          std::cout << std::setw(2) << std::hex << (int)d_pkt_buf[i] << std::dec << " ";

          // for (int j = 0; j < 8; j++)
          // {
          //   std::cout << std::setw(2) << (int)(((d_pkt_buf[i] << j) & 0x80) ? 1 : 0) << " ";
          // }
          // std::cout << " ";
        }
        std::cout << std::endl;

        pmt::pmt_t pkt = pmt::make_blob(d_pkt_buf, sizeof(uint8_t) * d_payload_len);
        message_port_pub(pmt::mp("out"), pkt);
      }
      else
      {
        std::cerr << "@cdma_packet_source_impl::make_packet: unexpected PMT type" << std::endl;
        assert(false);
      }
    }


    // int
    // cdma_packet_source_impl::general_work (int noutput_items,
    //                    gr_vector_int &ninput_items,
    //                    gr_vector_const_void_star &input_items,
    //                    gr_vector_void_star &output_items)
    // {
    //     const float *in = (const float *) input_items[0];
    //     float *out = (float *) output_items[0];

    //     // Do <+signal processing+>
    //     // Tell runtime system how many input items we consumed on
    //     // each input stream.
    //     consume_each (noutput_items);

    //     // Tell runtime system how many output items we produced.
    //     return noutput_items;
    // }

  } /* namespace marmote */
} /* namespace gr */

