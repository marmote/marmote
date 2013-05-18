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
#include "gmsk_packet_sink_b_impl.h"

#include <iomanip>


namespace gr {
  namespace marmote {

    gmsk_packet_sink_b::sptr
    gmsk_packet_sink_b::make(bool debug, bool polarity)
    {
      return gnuradio::get_initial_sptr (new gmsk_packet_sink_b_impl(debug, polarity));
    }

    gmsk_packet_sink_b_impl::gmsk_packet_sink_b_impl(bool debug, bool polarity)
      : gr_block("gmsk_packet_sink_b",
		      gr_make_io_signature(1, 1, sizeof(uint8_t)),
		      gr_make_io_signature(0, 0, 0)),
        d_state(STATE_SYNC_SEARCH),
        d_sync_vector(0x70EED2uL),
        d_shift_reg(0x0uL),
        d_debug(debug),
        d_polarity(polarity)
    {
      set_history(d_sync_vector_len);
      enter_search();
      message_port_register_out(pmt::mp("out"));
    }

    gmsk_packet_sink_b_impl::~gmsk_packet_sink_b_impl()
    {
    }

    void gmsk_packet_sink_b_impl::enter_search(void)
    {
        if (d_debug)
            std::cout << "@ enter_search" << std::endl;

        d_state = STATE_SYNC_SEARCH;
        d_shift_reg = 0;
    }

    void gmsk_packet_sink_b_impl::enter_have_sync(void)
    {
        if (d_debug)
            std::cout << "@ enter_have_sync" << std::endl;

        d_state = STATE_HAVE_SYNC;
        d_bit_cnt = 0;
        d_shift_reg = 0;
    }


    void gmsk_packet_sink_b_impl::enter_have_header(void)
    {
        if (d_debug)
            std::cout << "@ enter_have_header" << std::endl;

        d_state = STATE_HAVE_HEADER;
        d_bit_cnt = 0;
        d_shift_reg = 0;
        d_packet_byte_cnt = 0;
    }

    int
    gmsk_packet_sink_b_impl::general_work (int noutput_items,
                       gr_vector_int &ninput_items,
                       gr_vector_const_void_star &input_items,
                       gr_vector_void_star &output_items)
    {
        const uint8_t *in = (const uint8_t*) input_items[0];
        int ninput = ninput_items[0];
        int nprocd = 0; // number of processed input samples

        while (nprocd < ninput)
        {
            // if (d_debug)
            //   std::cout << ">>> Entering state machine (" << nprocd << "/" << ninput << ")" << std::endl;

            switch(d_state) {

              case STATE_SYNC_SEARCH:

                // if (d_debug)
                //     std::cout << ">>> Entering SYNC SEARCH" << std::endl;

                while (nprocd < ninput)
                {
                    // std::cout << (unsigned int)in[nprocd] << " "; // << std::endl;

                    d_shift_reg <<= 1;
                    d_shift_reg &= 0x00FFFFFF;

                    if ( in[nprocd++] != 0 )
                    {
                        // if (d_polarity)
                            d_shift_reg |= 0x1uL;
                        // else
                            // d_shift_reg &= ~0x1uL;
                    }

                    // if (d_debug)
                    //     std::cout << nprocd << ": " << std::setfill('0') << std::setw(6) << std::hex
                    //         << d_shift_reg << " ^ " << d_sync_vector << " = " << std::setw(6)
                    //         << (d_shift_reg ^ d_sync_vector) << std::dec
                    //         << " (" << nprocd << "/" << ninput << ")" << std::endl;

                    if ( (d_shift_reg ^ d_sync_vector) == 0 )
                    {
                        enter_have_sync();
                        break; // while loop
                    }
                }
                break;


              case STATE_HAVE_SYNC:

                // if (d_debug)
                //     std::cout << ">>> Entering HAVE SYNC" << std::endl;

                while (nprocd < ninput)
                {
                    // std::cout << (unsigned int)in[nprocd] << " "; // << std::endl;

                    d_shift_reg <<= 1;
                    d_shift_reg &= 0xFF;

                    if ( in[nprocd++] != 0 )
                    {
                        // if (d_polarity)
                            d_shift_reg |= 0x1uL;
                        // else
                            // d_shift_reg &= ~0x1uL;
                    }

                    d_bit_cnt++;

                    // std::cout << std::setfill('0') << std::setw(6) << std::hex << d_shift_reg << " (" << (unsigned int)d_bit_cnt << " " << nprocd << "/" << ninput << ")" << std::endl;

                    if (d_bit_cnt >= 8)
                    {
                        if ( d_shift_reg == 0x06) // Check header
                        {
                            if (d_debug)
                                std::cout << "Packet length: " << d_shift_reg << " OK" << std::endl;
                            d_packet_len = d_shift_reg;
                            enter_have_header();
                        }
                        else
                        {
                            if (d_debug)
                                std::cout << "Packet length: " << d_shift_reg << " ERROR" << std::endl;
                            enter_search();
                        }
                        break;
                    }
                }
                break;


              case STATE_HAVE_HEADER:

                // if (d_debug)
                //     std::cout << ">>> Entering HAVE HEADER" << std::endl;

                while (nprocd < ninput)
                {
                    // if (d_debug)
                    //     std::cout << (unsigned int)in[nprocd] << " "; // << std::endl;

                    d_shift_reg <<= 1;
                    d_shift_reg &= 0xFF;

                    if ( in[nprocd++] != 0 )
                    {
                        // if (d_polarity)
                            d_shift_reg |= 0x1uL;
                        // else
                            // d_shift_reg &= ~0x1uL;
                    }

                    d_bit_cnt++;

                    // if (d_debug)
                    //     std::cout << std::setfill('0') << std::setw(6) << std::hex << (unsigned int)d_shift_reg
                    //         << " (" << nprocd << "/" << ninput << ")" << std::endl;

                    if (d_bit_cnt >= 8)
                    {
                        // if (d_debug)
                        //     std::cout << "Byte " << (unsigned int)d_packet_byte_cnt << "/" << (unsigned int)(d_packet_len) << std::endl;

                        d_packet[d_packet_byte_cnt++] = (uint8_t)(d_shift_reg & 0xFF);

                        d_bit_cnt = 0;
                        d_shift_reg = 0;

                        if (d_packet_byte_cnt == d_packet_len)
                        {
                            if (d_debug)
                            {
                                std::cout << "Adding packet to the queue..." << std::endl;
                                std::cout << "Packet length: " << (unsigned int)d_packet_len << std::endl;
                                std::cout << "Packet payload: ";
                                for (int ii = 0; ii < d_packet_len ; ii++)
                                {
                                    std::cout << std::setfill('0') << std::setw(2) << std::hex << (unsigned int)d_packet[ii] << " ";
                                }
                                std::cout << std::endl;
                            }

                            std::memcpy(d_pmt_buf, d_packet, d_packet_len);
                            message_port_pub(pmt::mp("out"), pmt::pmt_make_blob(d_pmt_buf, d_packet_len));

                            enter_search();
                            break;
                        }
                    }
                }
                break;


              default:
                if (d_debug)
                    std::cout << ">>> Invalid state" << std::endl;
                assert(false);
                break;
            }
        }

        consume_each(nprocd);

        return 0;
    }

  } /* namespace marmote */
} /* namespace gr */

