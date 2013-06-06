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
#include "pn_spreader_b_impl.h"

namespace gr {
  namespace marmote {

    pn_spreader_b::sptr
    pn_spreader_b::make(bool debug, int mask, int seed, int spread_factor)
    {
      return gnuradio::get_initial_sptr (new pn_spreader_b_impl(debug, mask, seed, spread_factor));
    }

    pn_spreader_b_impl::pn_spreader_b_impl(bool debug, int mask, int seed, int spread_factor)
      : gr_sync_interpolator("pn_spreader_b",
		      gr_make_io_signature(1, 1, sizeof (uint8_t)),
		      gr_make_io_signature(1, 1, sizeof (uint8_t)), spread_factor),
      d_debug(debug),
      d_mask(mask),
      d_seed(seed),
      d_sf(spread_factor),
      d_lfsr(mask, seed)
    {
      std::cout << "Spread factor: " << d_sf << std::endl;
    }

    pn_spreader_b_impl::~pn_spreader_b_impl()
    {
    }

    int
    pn_spreader_b_impl::work(int noutput_items,
			  gr_vector_const_void_star &input_items,
			  gr_vector_void_star &output_items)
    {
        const uint8_t *in = (const uint8_t *) input_items[0];
        uint8_t *out = (uint8_t *) output_items[0];
        int nout = 0;

        d_tags.clear();
        get_tags_in_range(d_tags, 0, nitems_read(0), nitems_read(0) + noutput_items/d_sf);

        std::cout << "Found " << d_tags.size() << " tag(s) ";
        std::vector<gr_tag_t>::iterator it = d_tags.begin();
        while (it != d_tags.end())
        {
          std::cout << "@" << it->offset << " ";
          it++;
        }
        std::cout << std::endl;

        std::cout << "Input stream: ";
        for (int j = 0; j < noutput_items/d_sf; j++)
        {
          std::cout << (int)in[j] << " ";
        }
        std::cout << std::endl;


        d_tags_itr = d_tags.begin();
        for (int i = 0; i < noutput_items/d_sf; i++)
        {
          if (d_tags_itr != d_tags.end() && i == d_tags_itr->offset - nitems_read(0))
          {
            if (d_debug)
            {
              d_lfsr.reset();
              std::cout << "PN sequence:  ";
              for (int j = 0; j < noutput_items; j++)
              {
                std::cout << (int)d_lfsr.get_next_bit() << " ";
              }
              std::cout << std::endl;
            }

            d_lfsr.reset();
            d_tags_itr++;
          }

          for (int j = 0; j < d_sf; j++)
          {
            out[nout++] = in[i] ^ d_lfsr.get_next_bit();

            if (d_debug)
              std::cout << (int)out[nout-1] << " ";
          }
        }
        if (d_debug)
        {
          std::cout << std::endl;
        }

        return nout;
    }

  } /* namespace marmote */
} /* namespace gr */

