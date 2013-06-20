/* -*- c++ -*- */
/*
 * Copyright 2013 Sandor Szilvasi (sandor.szilvasi@vanderbilt.edu).
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


#ifndef INCLUDED_MARMOTE_MSEQ_LFSR_H
#define INCLUDED_MARMOTE_MSEQ_LFSR_H

#include <marmote/api.h>
#include <gr_block.h>

 // #include <string>
 // #include <iomanip>

namespace gr {
  namespace marmote {

    /*!
     * \brief Maximum-sequence linear-feedback shift register fo PN code generation.
     * \ingroup marmote
     *
     */
    class MARMOTE_API mseq_lfsr
    {
    	private:
    		int d_seed;
  			int d_mask;
  			int d_state;

     	public:
      		mseq_lfsr(int mask, int seed);
      		~mseq_lfsr();

      		void reset();

      		unsigned char get_next_bit()
      		{
            // std::cout << std::hex << std::setw(3) << (int)d_state << " " << (int)d_mask << " " << (int)d_seed << std::dec << std::endl;
	    		unsigned char bit = d_state & 0x01;
	    		d_state >>= 1;
	    		if (bit)
	      			d_state ^= d_mask;
	    		return bit;
  			}
    };

  } // namespace marmote
} // namespace gr

#endif /* INCLUDED_MARMOTE_MSEQ_LFSR_H */