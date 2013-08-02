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
#include "cdma_packet_sink_impl.h"

#include <iomanip>

namespace gr {
	namespace marmote {

		cdma_packet_sink::sptr cdma_packet_sink::make(bool debug, int id)
		{
			return gnuradio::get_initial_sptr (new cdma_packet_sink_impl(debug, id));
		}

		cdma_packet_sink_impl::cdma_packet_sink_impl(bool debug, int id)
			: gr::block("cdma_packet_sink",
					gr::io_signature::make(0, 0, 0),
					gr::io_signature::make(0, 0, 0)),
			d_debug(debug),
			d_id(id),
			d_polynomial(0x1021),
            d_first_pkt_found(false),
            d_start_seq(0),
            d_valid_pkt_ctr(0),
            d_total_pkt(1000) // FIXME
		{
			message_port_register_in(pmt::mp("in"));
			set_msg_handler(pmt::mp("in"), boost::bind(&cdma_packet_sink_impl::process_packet, this, _1));
		}

		cdma_packet_sink_impl::~cdma_packet_sink_impl()
		{
		}

		void cdma_packet_sink_impl::process_packet(pmt::pmt_t pkt)
		{
			if (pmt::is_blob(pkt))
			{
				// std::cout << "Processing packet..." << " [" << (int)(pmt::blob_length(pkt)) << " bits]" << std::endl;

				// if (d_debug)
				{
                    if (d_debug)
    					std::cout << "    #" << d_id << " <- ";

					int k = 0;
					uint8_t octet = 0;
					uint8_t* payload = (uint8_t*)pmt::blob_data(pkt);
					uint16_t crc;

                    // Assemble packet
					for (int i = 0; i < pmt::blob_length(pkt); i++)
					{
						octet = (octet << 1) | payload[i];
						if (i % 8 == 7)
						{
							d_buf[k++] = octet;
                            if (d_debug)
    							std::cout << std::setw(2) << std::setfill('0') << std::hex << (int)octet << std::dec << " ";
						}
					}

                    // Check CRC
					if (k >= 3 && (crc_16(d_buf, k-2) != ((d_buf[k-2] << 8) + d_buf[k-1])))
					{
                        if (d_debug)
    						std::cout << "#" << std::endl;
                        return;
					}

					// std::cout << std::endl;

                    // Process valid packet
                    uint16_t seq;
                    seq = (d_buf[1] & 0xFF) << 8;
                    seq += d_buf[2] & 0xFF;

                    if (d_first_pkt_found == false)
                    {
                        d_start_seq = seq;
                        d_first_pkt_found = true;
                        d_valid_pkt_ctr = 1;
                        // std::cout << "SEQ: " << (int)seq << " <" << std::endl;
                        if (d_debug)
                            std::cout << "<" << std::endl;
                    }
                    else
                    {
                        // std::cout << "SEQ: " << (int)seq;
                        if (seq - d_start_seq > d_total_pkt - 1)
                        {
                            if (d_debug)
                                std::cout << "<" << std::endl;
                            // std::cout << "start_seq: " << d_start_seq << " current_seq: " << seq << " diff_seq: " << (seq - d_start_seq) << std::endl;
                            // std::cout << "valid_pkt: " << d_valid_pkt_ctr << " / total_pkt: " << d_total_pkt <<  " = ";
                            // std::cout << (float)d_valid_pkt_ctr/(float)d_total_pkt << std::endl;

                            std::cout << "#" << d_id << " => PER: " << 1.0 - (float)d_valid_pkt_ctr/(float)d_total_pkt;
                            std::cout << " (" << d_total_pkt-d_valid_pkt_ctr << "/" << d_total_pkt << ")" << std::endl;

                            while(1);
                        }

                        if (d_debug)
                        {
                            std::cout << "(" << d_valid_pkt_ctr << " / " << (unsigned int)(seq - d_start_seq) << " / " << d_total_pkt <<  ")";
                            std::cout << std::endl;
                        }
                        d_valid_pkt_ctr++;
                    }
                    // std::cout << "SEQ: " << (int)seq << std::endl;
				}
			}
			else if (pmt::is_symbol(pkt))
			{

				const char* data = pmt::symbol_to_string(pkt).data();

				for (int j = 0; j < pmt::symbol_to_string(pkt).length(); j++)
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

		uint16_t cdma_packet_sink_impl::crc_16(const uint8_t data[], uint8_t length)
		{
			uint8_t bit;
			uint8_t byte;
			uint16_t crc;

			crc = 0;
			for (byte = 0; byte < length; ++byte)
			{
				crc ^= (data[byte] << 8);

				for (bit = 8; bit > 0; --bit)
				{
					if (crc & (1 << 15))
					{
						crc = (crc << 1) ^ d_polynomial;
					}
					else
					{
						crc = (crc << 1);
					}
				}
			}

			return crc;
		}

	} /* namespace marmote */
} /* namespace gr */

