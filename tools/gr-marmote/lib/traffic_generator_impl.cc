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
#include "traffic_generator_impl.h"

namespace gr {
  namespace marmote {

    traffic_generator::sptr
    traffic_generator::make()
    {
      return gnuradio::get_initial_sptr (new traffic_generator_impl());
    }

    traffic_generator_impl::traffic_generator_impl()
      : gr_block("traffic_generator",
		      gr_make_io_signature(1, 1, sizeof (gr_complex)),
		      gr_make_io_signature(1, 1, sizeof (gr_complex)))
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
        const gr_complex *in = (const gr_complex *) input_items[0];
        gr_complex *out = (gr_complex *) output_items[0];
        uint32_t nconsumed;

        if (ninput_items[0])
        {
          nconsumed = (ninput_items[0] < noutput_items) ? ninput_items[0] : noutput_items;
          consume_each (nconsumed);
          memcpy(out, in, nconsumed * sizeof(gr_complex));
        }
        else
        {
          nconsumed = noutput_items;
          memset(out, 0, nconsumed * sizeof(gr_complex));
        }
        return nconsumed;
    }

  } /* namespace marmote */
} /* namespace gr */

