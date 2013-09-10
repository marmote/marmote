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
#include "traffic_generator_impl.h"

namespace gr {
  namespace marmote {

    traffic_generator::sptr
    traffic_generator::make(size_t item_size)
    {
      return gnuradio::get_initial_sptr (new traffic_generator_impl(item_size));
    }

    traffic_generator_impl::traffic_generator_impl(size_t item_size)
      : gr::block("traffic_generator",
		      gr::io_signature::make(1, 1, item_size),
		      gr::io_signature::make(1, 1, item_size)),
      d_item_size(item_size)
    {}

    traffic_generator_impl::~traffic_generator_impl()
    {
    }

    void
    traffic_generator_impl::forecast (int noutput_items, gr_vector_int &ninput_items_required)
    {
      ninput_items_required[0] = 0;
    }

    int
    traffic_generator_impl::general_work (int noutput_items,
                       gr_vector_int &ninput_items,
                       gr_vector_const_void_star &input_items,
                       gr_vector_void_star &output_items)
    {
        const char *in = (const char *) input_items[0];
        char *out = (char *) output_items[0];
        uint32_t nconsumed;

        if (ninput_items[0])
        {
          nconsumed = (ninput_items[0] < noutput_items) ? ninput_items[0] : noutput_items;
          consume_each (nconsumed);
          memcpy(out, in, nconsumed * d_item_size);
        }
        else
        {
          nconsumed = noutput_items;
          memset(out, 0, nconsumed * d_item_size);
        }
        return nconsumed;
    }

  } /* namespace marmote */
} /* namespace gr */

