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
#include <gnuradio/block_detail.h>
#include "cdma_packet_sink_impl.h"

#include <iomanip>

namespace gr {
	namespace marmote {

		cdma_packet_sink::sptr cdma_packet_sink::make(bool debug, int id, int total_pkt)
		{
			return gnuradio::get_initial_sptr (new cdma_packet_sink_impl(debug, id, total_pkt));
		}

		cdma_packet_sink_impl::cdma_packet_sink_impl(bool debug, int id, int total_pkt)
			: gr::block("cdma_packet_sink",
					gr::io_signature::make(0, 0, 0),
					gr::io_signature::make(0, 0, 0)),
			d_debug(debug),
			d_id(id),
			d_polynomial(0x1021),
            d_first_pkt_found(false),
            d_start_seq(0),
            d_valid_pkt_ctr(0),
            d_total_pkt(total_pkt)
		{
			message_port_register_in(pmt::mp("in"));
			set_msg_handler(pmt::mp("in"), boost::bind(&cdma_packet_sink_impl::process_packet, this, _1));
		}

		cdma_packet_sink_impl::~cdma_packet_sink_impl()
		{
		}

		void cdma_packet_sink_impl::process_packet(pmt::pmt_t pkt)
		{
            if (pmt::is_pair(pkt) && pmt::is_u8vector(pmt::cdr(pkt)))
            {
                size_t len;
                const uint8_t* buf = pmt::u8vector_elements(pmt::cdr(pkt), len);

                process_packet(buf, len);
            }
            else if (pmt::is_blob(pkt))
			{
				// std::cout << "Processing packet..." << " [" << (int)(pmt::blob_length(pkt)) << " bits]" << std::endl;

                int len = 0;
                uint8_t octet = 0;
                uint8_t* payload = (uint8_t*)pmt::blob_data(pkt);
                uint16_t crc;

                // Assemble packet
                for (int i = 0; i < pmt::blob_length(pkt); i++)
                {
                    octet = (octet << 1) | payload[i];
                    if (i % 8 == 7)
                    {
                        d_buf[len++] = octet;
                        if (d_debug)
                            std::cout << std::setw(2) << std::setfill('0') << std::hex << (int)octet << std::dec << " ";
                    }
                }

                process_packet(d_buf, len);
			}
			else
			{
				std::cerr << "@cdma_packet_sink_impl::process_packet: unexpected PMT type" << std::endl;
				assert(false);
			}
		}

        void cdma_packet_sink_impl::process_packet(const uint8_t buf[], uint8_t len)
        {
            uint16_t seq;
            seq = (buf[1] & 0xFF) << 8;
            seq += buf[2] & 0xFF;

            //std::cout << "    #" << d_id << " <- ";
            
            if (d_debug)
            {
                //std::cout << "SEQ: " << (int)seq << " < ";
                for (int i = 0; i < len; i++)
                {
                    std::cout << std::hex << std::setfill('0') << std::setw(2) << (int)buf[i] << std::dec << " ";
                }
            }

            // Check CRC
            if (len >= 3 && (crc_16(buf, len-2) != ((buf[len-2] << 8) + buf[len-1])))
            {
                //std::cout << "#" << std::endl;
                return;
            }
            
            // Update statistics
            if (d_first_pkt_found == false)
            {
                d_start_seq = seq;
                d_first_pkt_found = true;
                d_valid_pkt_ctr = 0;
            }

            if (seq - d_start_seq + 1 <= d_total_pkt)
            {
                d_valid_pkt_ctr++;
            }

            if (d_debug)
                std::cout << "(" << d_valid_pkt_ctr << " / " << (unsigned int)(seq - d_start_seq + 1) % (1 << 16) << " / " << d_total_pkt <<  ")";

            if ((unsigned int)(seq - d_start_seq + 1) % (1 << 16) >= d_total_pkt)
            {
                //std::cout << " <" << std::endl;

                //std::cout << "start_seq: " << d_start_seq << " current_seq: " << seq << " diff_seq: " << (seq - d_start_seq) << std::endl;
                //std::cout << "valid_pkt: " << d_valid_pkt_ctr << " / total_pkt: " << d_total_pkt <<  " = ";
                //std::cout << (float)d_valid_pkt_ctr/(float)d_total_pkt << std::endl;

                //std::cout << "#" << d_id << " => PRR: " << std::setw(4) << (float)d_valid_pkt_ctr/(float)d_total_pkt;
                //std::cout << "#" << d_id << " => PRR: " << std::fixed << std::setprecision(3) << (float)d_valid_pkt_ctr/(float)d_total_pkt;
                std::cout << std::fixed << std::setprecision(3) << (float)d_valid_pkt_ctr/(float)d_total_pkt << std::endl;
                //std::cout << " (" << d_valid_pkt_ctr << "/" << d_total_pkt << ")" << std::endl;

                detail().get()->set_done(true);
                return;
            }


            //std::cout << std::endl;
        }

		uint16_t cdma_packet_sink_impl::crc_16(const uint8_t data[], uint8_t len)
		{
			uint8_t bit;
			uint8_t byte;
			uint16_t crc;

			crc = 0;
			for (byte = 0; byte < len; ++byte)
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

