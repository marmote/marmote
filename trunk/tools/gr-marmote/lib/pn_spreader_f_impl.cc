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
#include "pn_spreader_f_impl.h"

namespace gr {
  namespace marmote {

    pn_spreader_f::sptr
    pn_spreader_f::make(bool debug, int mask, int seed, int spread_factor, int preamble_len)
    {
      return gnuradio::get_initial_sptr (new pn_spreader_f_impl(debug, mask, seed, spread_factor, preamble_len));
    }

    pn_spreader_f_impl::pn_spreader_f_impl(bool debug, int mask, int seed, int spread_factor, int preamble_len)
      : gr_block("pn_spreader_f",
          gr_make_io_signature(0, 0, 0),
          gr_make_io_signature(1, 1, sizeof (float))),
      d_debug(debug),
      d_mask(mask),
      d_seed(seed),
      d_spread_factor(spread_factor),
      d_preamble_len(preamble_len),
      d_pkt_offset(0),
      d_lfsr(mask, seed)
    {
      message_port_register_in(pmt::mp("in"));
      
      for (int i = 0; i < 16; i++)
      {
        std::cout << (int)d_lfsr.get_next_bit() << " ";
        if (i % 8 == 7)
        {
          std::cout << std::endl;
        }
      }
      std::cout << "------------------" << std::endl;

      d_lfsr.reset();

      for (int i = 0; i < 32; i++)
      {
        std::cout << (int)d_lfsr.get_next_bit() << " ";
        if (i % 8 == 7)
        {
          std::cout << std::endl;
        }
      }
    }

    pn_spreader_f_impl::~pn_spreader_f_impl()
    {
    }

    int
    pn_spreader_f_impl::general_work (int noutput_items,
                       gr_vector_int &ninput_items,
                       gr_vector_const_void_star &input_items,
                       gr_vector_void_star &output_items)
    {
        pmt::pmt_t blob;
        float *out = (float *) output_items[0];

        while (d_pkt_offset == 0)
        {
          pmt::pmt_t pkt(delete_head_blocking(pmt::pmt_intern("in")));

          if (pmt::pmt_is_eof_object(pkt)) {
            std::cout  << "pn_spreader_f_impl::general_work: MAC exiting" << std::endl;
            return -1;
          }


          if (pmt::pmt_is_blob(pkt))
          {
            // std::cout << "@pn_spreader_f_impl::process_packet: Processing packet..." << std::endl;
            std::cout << "Processing packet..." << std::endl;

            unsigned int pkt_len = pmt::pmt_blob_length(pkt) * 8;
            uint8_t* pkt_data = (uint8_t*)pmt::pmt_blob_data(pkt);

            assert(pkt_len > 0 && pkt_len <= MAX_CHIP_LEN / d_spread_factor);
            std::cout << "Preamble length: " << d_preamble_len << " (bits)" << std::endl;
            std::cout << "Payload length: " << pkt_len << " (bits)" << std::endl;

            d_lfsr.reset();

            // // Set up preamble
            int chip_ctr = 0;
            for (int i = 0; i < d_preamble_len; i++)
            {
              d_chip_buf[chip_ctr++] = 1.0;  // elfsr.next()*2.0-1.0;

              for (int j = 0; j < d_spread_factor; j++)
              {
                std::cout << (int)d_chip_buf[chip_ctr-1] << " ";
              }
            }
            std::cout << std::endl;

            // Set up payload
            for (int i = 0; i < pkt_len; i++)
            {
              uint8_t data_bit = (pkt_data[i/8] << (i % 8)) & 0x80 ? 1 : 0; // Extract MSB bit

              for (int j = 0; j < d_spread_factor; j++)
              {
                d_chip_buf[chip_ctr++] = data_bit ? 1.0 : -1.0;
                std::cout << (int)d_chip_buf[chip_ctr-1] << " ";
              }
            }
            std::cout << std::endl;
          }
          else
          {
            std::cerr << "@pn_spreader_f_impl::process_packet: Unexpected PMT type" << std::endl;
            assert(false);
          }
        }

        // int nout = std::min(d_msg_len - d_pkt_offset, noutput_items);
        // memcpy(out, d_msg + d_pkt_offset, nout);

        // d_pkt_offset,+= nout;

        // if(d_pkt_offset,== d_msg_len) {
        //   d_pkt_offset,= 0;
        // }

        // return nout;
        return 0;
    }

  } /* namespace marmote */
} /* namespace gr */

