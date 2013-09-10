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
#include "mac_deframer_impl.h"

#include <iomanip>

namespace gr {
  namespace marmote {

    mac_deframer::sptr
    mac_deframer::make(bool debug)
    {
      return gnuradio::get_initial_sptr (new mac_deframer_impl(debug));
    }

    mac_deframer_impl::mac_deframer_impl(bool debug)
      : gr::block("mac_deframer",
		      gr::io_signature::make(0, 0, 0),
		      gr::io_signature::make(0, 0, 0)),
			  d_debug(debug)
    {
        message_port_register_in(pmt::mp("in"));
        set_msg_handler(pmt::mp("in"), boost::bind(&mac_deframer_impl::pkt_handler, this, _1));
    }

    mac_deframer_impl::~mac_deframer_impl()
    {
    }

    void mac_deframer_impl::pkt_handler(pmt::pmt_t pkt)
    {
        if (pmt::is_blob(pkt))
        {
            unsigned int pkt_len = pmt::blob_length(pkt);
            assert(pkt_len > 0 && pkt_len <= MAX_PKT_LEN);

			if (d_debug)
			{
				std::cout << "MAC: received packet [" << (unsigned int)pkt_len << "]" << std::endl;
				uint8_t* pkt_data = (uint8_t*)pmt::blob_data(pkt);
				for (int ii = 0; ii < pkt_len; ii++)
				{
					if ((ii > 0) && (ii % 8 == 0))
						std::cout << std::endl;
					std::cout << std::setfill('0') << std::setw(2) << std::hex << (unsigned int)pkt_data[ii] << " ";
				}
				std:: cout << std::endl;
			}
        }
        else
        {
			if (d_debug)
				std::cout << "@MAC deframer: unexpected PMT type received" << std::endl;
            assert(false);
        }
    }

  } /* namespace marmote */
} /* namespace gr */

