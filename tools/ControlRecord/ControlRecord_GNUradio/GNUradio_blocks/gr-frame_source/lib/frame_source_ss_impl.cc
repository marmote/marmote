/* -*- c++ -*- */
/* 
 * Copyright 2012 <+YOU OR YOUR COMPANY+>.
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
#include "frame_source_ss_impl.h"

namespace gr 
{
namespace frame_source 
{

	
	
/***************************************************************************************
* Make
***************************************************************************************/		
frame_source_ss::sptr
frame_source_ss::make(char* FileOrDir)
{
	return gnuradio::get_initial_sptr ( new frame_source_ss_impl(FileOrDir) );
}



/***************************************************************************************
* The private constructor
***************************************************************************************/
frame_source_ss_impl::frame_source_ss_impl(char* FileOrDir)
	:	gr_sync_block("frame_source_ss",
					gr_make_io_signature(0, 0, 0),
					gr_make_io_signature(2, 2, sizeof (short)) )
{
}


/***************************************************************************************
* Our virtual destructor
***************************************************************************************/
frame_source_ss_impl::~frame_source_ss_impl()
{
}


/***************************************************************************************
* General Work (hoping to get promoted to Admiral Work one day... I'm so funny!)
***************************************************************************************/
int
frame_source_ss_impl::work(int							noutput_items,
							gr_vector_const_void_star	&input_items,
							gr_vector_void_star			&output_items)
{
	int N = noutput_items;

	if (N == 0)
	{
		printf("FrameSource error: No space in output buffers!");
		return 0;
	}

	int noutput = 0;

	while (1)
	{
	
	
	}


	const float *in = (const float *) input_items[0];
	float *out = (float *) output_items[0];

	// Do <+signal processing+>

	// Tell runtime system how many output items we produced.
	return noutput_items;
}



} /* namespace frame_source */
} /* namespace gr */

