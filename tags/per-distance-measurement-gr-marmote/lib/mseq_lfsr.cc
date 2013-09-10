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

 #include <marmote/mseq_lfsr.h>

namespace gr {
  namespace marmote {

  	// 11th order polynomials
  	static int s_polynomial_masks[] = {
		0x000,
		0x402,	 // [11 2 0]
		0x492,	 // [11 8 5 2 0]
		0x446,	 // [11 7 3 2 0]
		0x416,	 // [11 5 3 2 0]
		0x606,	 // [11 10 3 2 0]
		0x431,	 // [11 6 5 1 0]
		0x415,	 // [11 5 3 1 0]
		0x509,	 // [11 9 4 1 0]
		0x4A2,	 // [11 8 6 2 0]
		0x584,	 // [11 9 8 3 0]
		0x785,	 // [11 10 9 8 3 1 0]
  	};

  	mseq_lfsr::mseq_lfsr(int mask, int seed)
	{
		d_seed = seed;
		d_state = seed;
		d_mask = mask;
	}

	mseq_lfsr::~mseq_lfsr()
	{		
	}

	void mseq_lfsr::reset()
	{
		d_state = d_seed;
	};

  } /* namespace marmote */
} /* namespace gr */