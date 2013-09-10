/* -*- c++ -*- */
/*
 * Copyright 2013 Sandor Szilvasi.
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
#include "binary_slicer_fi_impl.h"
 #include <gnuradio/math.h>

namespace gr {
  namespace marmote {

    binary_slicer_fi::sptr
    binary_slicer_fi::make()
    {
      return gnuradio::get_initial_sptr
        (new binary_slicer_fi_impl());
    }

    binary_slicer_fi_impl::binary_slicer_fi_impl()
      : gr::sync_block("binary_slicer_fi",
              gr::io_signature::make(1, 1, sizeof(float)),
              gr::io_signature::make(1, 1, sizeof(int)))
    {
    }

    binary_slicer_fi_impl::~binary_slicer_fi_impl()
    {
    }

    int
    binary_slicer_fi_impl::work(int noutput_items,
        gr_vector_const_void_star &input_items,
        gr_vector_void_star &output_items)
    {
        const float *in = (const float *)input_items[0];
        unsigned int *out = (unsigned int*)output_items[0];

        for(int i = 0; i < noutput_items; i++) {
            out[i] = gr::binary_slicer(in[i]);
        }

        return noutput_items;
    }

  } /* namespace marmote */
} /* namespace gr */

