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

#include <gri_glfsr.h>
#include <gr_io_signature.h>
#include "ds_spreader_bb_impl.h"

namespace gr {
  namespace marmote {

    ds_spreader_bb::sptr
    ds_spreader_bb::make(unsigned int sf)
    {
      return gnuradio::get_initial_sptr (new ds_spreader_bb_impl(sf));
    }

    ds_spreader_bb_impl::ds_spreader_bb_impl(unsigned int sf)
      : gr_sync_interpolator("ds_spreader_bb",
		      gr_make_io_signature(1, 1, sizeof (uint8_t)),
		      gr_make_io_signature(1, 1, sizeof (uint8_t)), sf),
      d_sf(sf)
    {
      // Use pre-calculated short codes for now
      int mask = 0x12;
      int seed = 0x1;
      gri_glfsr glfsr = gri_glfsr(mask, seed);

      d_pn_0 = new uint8_t [sf];
      d_pn_1 = new uint8_t [sf];

      for (int i = 0; i < sf; i++)
      {
        d_pn_0[i] = glfsr.next_bit();
        d_pn_1[i] = d_pn_0[i] ^ 1;
      }

      // Debug print
      for (int i = 0; i < sf; i++)
      {
        std::cout << (int)d_pn_0[i] << " ";
        // std::cout << "[" << (int)d_pn_0[i] << ":" << (int)d_pn_1[i] << "] ";
      }
      std::cout << std::endl;
    }

    ds_spreader_bb_impl::~ds_spreader_bb_impl()
    {
      delete [] d_pn_0;
      delete [] d_pn_1;
    }

    int
    ds_spreader_bb_impl::work(int noutput_items,
			  gr_vector_const_void_star &input_items,
			  gr_vector_void_star &output_items)
    {
        const uint8_t *in = (const uint8_t *) input_items[0];
        uint8_t *out = (uint8_t *) output_items[0];

        // std::cout << std::dec << ">>> Spreader: " << noutput_items << " (" << d_sf << ")" << std::endl;

        for (int i = 0; i < noutput_items/d_sf; i++)
        {
          if (in[i] == 0)
            memcpy(out+i*d_sf*sizeof(uint8_t), d_pn_0, d_sf);
          else
            memcpy(out+i*d_sf*sizeof(uint8_t), d_pn_1, d_sf);
          // memset(out+i*d_sf*sizeof(uint8_t), in[i], d_sf);
        }

        return noutput_items;
    }

  } /* namespace marmote */
} /* namespace gr */

