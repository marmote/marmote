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
#include "pn_matched_filter_impl.h"
#include <iomanip>
// #include <gnuradio/blocks/count_bits.h>


namespace gr {
  namespace marmote {

    pn_matched_filter::sptr
    pn_matched_filter::make(bool debug, int mask, int seed, int preamble_len, int spread_factor, int oversample_factor)
    {
      return gnuradio::get_initial_sptr (new pn_matched_filter_impl(debug, mask, seed, preamble_len, spread_factor, oversample_factor));
    }

    pn_matched_filter_impl::pn_matched_filter_impl(bool debug, int mask, int seed, int preamble_len, int spread_factor, int oversample_factor)
      : gr::sync_interpolator("pn_matched_filter",
		      gr::io_signature::make(1, 1, sizeof (uint32_t)),
		      gr::io_signature::make(1, 1, sizeof (int)), sizeof(uint32_t) * 8),
          d_debug(debug),
          d_preamble_len(preamble_len),
          d_spread_factor(spread_factor),
          d_oversample_factor(oversample_factor)
    {
      d_lfsr = new mseq_lfsr(mask, seed);

      // Initialize filter
      d_coef_len = preamble_len * spread_factor;
      d_filt_len_bit = d_coef_len * oversample_factor;
      d_filt_len_oct = (d_filt_len_bit + 31) / 32;

      set_history(d_filt_len_bit);

      // Construct filter
      std::cout << "Constructing filter..." << std::endl;

      d_lfsr->reset();
      d_filt_coef = new uint32_t[d_filt_len_oct];
      memset(d_filt_coef, 0, sizeof(uint32_t)*d_filt_len_oct);

      uint32_t lsb;
      std::cout << "filt_coefs = ";
      for (int i = 0; i < d_coef_len; i++)
      {
        lsb = (d_lfsr->get_next_bit() ? 1ul : 0ul);
        for (int j = 0; j < d_oversample_factor; j++)
        {
          shift_buffers(d_filt_coef, d_filt_len_oct);
          d_filt_coef[0] |= lsb;
        }

        std::cout << lsb << ", ";

        // std::cout << std::setw(3) << i << ": ";
        // print_buffers(d_filt_coef, d_filt_len_oct);
      }

      // Construct filter and corresponding mask
      std::cout << "Constructing mask..." << std::endl;

      d_filt_mask = new uint32_t[d_filt_len_oct];
      memset(d_filt_mask, 0, sizeof(uint32_t)*d_filt_len_oct);
      for (int i = 0; i < d_filt_len_bit; i++)
      {
        shift_buffers(d_filt_mask, d_filt_len_oct);
        d_filt_mask[0] |= (i % d_oversample_factor ? 0ul : 1ul);

        // std::cout << std::setw(3) << i << ": ";
        // print_buffers(d_filt_mask, d_filt_len_oct);
      }

      d_buf_samp = new uint32_t[d_filt_len_oct+1];
      memset(d_buf_samp, 0, sizeof(uint32_t)*(d_filt_len_oct+1));

      d_buf_xcor = new uint32_t[d_filt_len_oct];


      // -------------------- DEBUG -------------------
      if (d_debug)
      {
        std::cout << "COEF: " << d_coef_len << " BIN: " << d_filt_len_bit
          << " OS: " << d_oversample_factor << " OCT: " << d_filt_len_oct<< std::endl;

        std::cout << "Filter coeffs: [" << d_coef_len << "]" << std::endl;
        print_buffers(d_filt_coef, d_filt_len_oct);

        std::cout << "Filter mask: [" << d_coef_len << "]" << std::endl;
        print_buffers(d_filt_mask, d_filt_len_oct);
      }
      // -------------------- DEBUG -------------------
      
      //std::cout << "filt_coefs = ";
      //for (int i = 0; i < d_coef_len; i++)
      //{
          //std::cout << std::setw(2) << (int)d_filt_coef[i] << ", ";
      //}
      //std::cout << std::endl;
    }

    pn_matched_filter_impl::~pn_matched_filter_impl()
    {
      delete d_lfsr;
      delete[] d_filt_mask;
      delete[] d_buf_samp;
      delete[] d_buf_xcor;
    }

    int
    pn_matched_filter_impl::work(int noutput_items,
			  gr_vector_const_void_star &input_items,
			  gr_vector_void_star &output_items)
    {
      const uint32_t *in = (const uint32_t *) input_items[0];
      int *out = (int *) output_items[0];
      int nout = 0;

      int num_ones;

      if (d_debug)
      {
        std::cout << "noutput_items: " << noutput_items << std::endl;
      }


      // nout = 22 * 32;
      for (int i = 0; i < noutput_items/interpolation(); i++)
      {
        std::cout << "Processing sample " << i << "... [" << std::setw(8)
          << std::hex << std::setfill('0') << (unsigned int)in[i] << std::dec << std::setfill(' ') << "]" << std::endl;

        d_buf_samp[0] = in[i];

        for (int b = 0; b < sizeof(uint32_t) * 8; b++)
        {
          // Shift bits in place
          shift_buffers(d_buf_samp, d_filt_len_oct+1);
          // print_buffers(d_buf_samp, d_filt_len_oct+1);

          // std::cout << "  ";
          // print_buffers(d_buf_samp+1, d_filt_len_oct);
          // std::cout << "^ ";
          // print_buffers(d_filt_coef, d_filt_len_oct);

          // Correlate
          for (int i = 0; i < d_filt_len_oct; i++)
          {
            d_buf_xcor[i] = (d_buf_samp[i+1] ^ d_filt_coef[i]);
          }
          // std::cout << "= ";
          // print_buffers(d_buf_xcor, d_filt_len_oct);

          // std::cout << "& ";
          // print_buffers(d_filt_mask, d_filt_len_oct);

          // Mask
          for (int i = 0; i < d_filt_len_oct; i++)
          {
            d_buf_xcor[i] &= d_filt_mask[i];
          }

          // std::cout << "= ";
          // print_buffers(d_buf_xcor, d_filt_len_oct);

          // Count bits
          num_ones = 0;
          for (int i = 0; i < d_filt_len_oct; i++)
          {
            num_ones += count_bits32(d_buf_xcor[i]);
          }

          // Update out[]
          out[nout] = (num_ones * 2) - d_coef_len;
          nout++;

          // std::cout << "  " << num_ones << " / " << d_coef_len << " -> " << out[nout-1] << std::endl;
        }
      }

      return nout;
    }


    void
    pn_matched_filter_impl::print_input_items(int noutput_items, gr_vector_const_void_star &input_items)
    {
      const uint32_t *in = (const uint32_t *) input_items[0];
      std::cout << "print_input_items [" << noutput_items/interpolation() << " -> " << noutput_items << " ("
        << noutput_items % interpolation() << ")]:" << std::endl;
      for (int i = 0; i < noutput_items/interpolation(); i++)
      {
        std::cout << std::setw(8) << std::hex << std::setfill('0') << (unsigned int)in[i] << std::dec << "uL, ";
      }
      std::cout << std::endl;
    }

    void
    pn_matched_filter_impl::print_input_items_binary(int noutput_items, gr_vector_const_void_star &input_items)
    {
      const uint32_t *in = (const uint32_t *) input_items[0];
      std::cout << "print_input_items_binary [" << noutput_items/interpolation() << " -> " << noutput_items << " ("
        << noutput_items % interpolation() << ")]:" << std::endl;

      for (int i = 0; i < noutput_items/interpolation(); i++)
      {
        std::cout << std::setw(8) << std::hex << std::setfill('0') << (unsigned int)in[i] << std::dec << ": ";
        for (int j = 0; j < sizeof(uint32_t) * 8; j++)
        {
          std::cout << (unsigned int)((in[i] >> (sizeof(uint32_t)*8-1 - j)) & 1);
        }
        std::cout << " ";
        std::cout << std::endl;
      }
      std::cout << std::endl;
    }

    void
    pn_matched_filter_impl::print_uint32_t_binary(const uint32_t val, const char* msg)
    {
      if (msg)
      {
        // std::cout << msg << ": ";
        // std::cout << std::setw(8) << std::hex << std::setfill('0') << (unsigned int)val << std::dec << std::setfill(' ') << " -> ";
        std::cout << msg << " ";
        for (int j = 0; j < sizeof(uint32_t) * 8; j++)
        {
          std::cout << (unsigned int)((val >> (sizeof(uint32_t)*8-1 - j)) & 1);
        }
        std::cout << std::endl;
      }
      else
      {
        for (int j = 0; j < sizeof(uint32_t) * 8; j++)
        {
          std::cout << (unsigned int)((val >> (sizeof(uint32_t)*8-1 - j)) & 1);
        }
      }
    }

    void pn_matched_filter_impl::print_buffers(const uint32_t* buf, int len)
    {
      for (int i = len-1; i >= 0; i--)
      {
        print_uint32_t_binary(buf[i], NULL);
        std::cout << " ";
      }
      std::cout << std::endl;
    }

    void pn_matched_filter_impl::shift_buffers(uint32_t* buf, int len)
    {
      for (int i = len-1; i > 0; i--)
      {
        buf[i] <<= 1;
        buf[i] |= (buf[i-1] >> 31);
      }
      buf[0] <<= 1;
    }

    void pn_matched_filter_impl::shift_buffers(uint32_t* buf, int len, int lsb)
    {
      for (int i = len-1; i > 0; i--)
      {
        buf[i] <<= 1;
        buf[i] |= (buf[i-1] >> 31);
      }
      buf[0] <<= 1;
      buf[0] <<= (lsb & 1ul);
    }

    void pn_matched_filter_impl::xcorr_buffers(uint32_t* res, uint32_t* buf1, uint32_t* buf2, int len)
    {
      for (int i = 0; i < len; i++)
      {
        res[i] = buf1[i] ^ buf2[i];
      }
    }


    // From GNU Radio count_bits.c
    unsigned int
    pn_matched_filter_impl::count_bits32(unsigned int x)
    {
      unsigned res = (x & 0x55555555) + ((x >> 1) & 0x55555555);
      res = (res & 0x33333333) + ((res >> 2) & 0x33333333);
      res = (res & 0x0F0F0F0F) + ((res >> 4) & 0x0F0F0F0F);
      res = (res & 0x00FF00FF) + ((res >> 8) & 0x00FF00FF);
      return (res & 0x0000FFFF) + ((res >> 16) & 0x0000FFFF);
    }

  } /* namespace marmote */
} /* namespace gr */

          // for (int i = 0; i < len; i++)
          // {
          //   res[i] = d_buf_samp[i+1] ^ d_buf_filt[i];
          // }
