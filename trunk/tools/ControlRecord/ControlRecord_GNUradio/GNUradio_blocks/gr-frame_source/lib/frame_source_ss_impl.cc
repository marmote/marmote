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
	short 		*out1	=	(short *) 		output_items[0];	
	short 		*out2	=	(short *) 		output_items[1];	

	int N = noutput_items;

	if ( N == 0 )
	{
		printf("FrameSource error: No space in output buffers!\n");
		return 0;
	}
    
	int noutput;

	noutput = 0;


	while (1)
	{
		// 1. Some minor pre-processing steps
		eNs16b_ret_t ret_s = eNs16b.Process( dfe.byte_buff_len, dfe.frame_starts, dfe.frame_cnt, N - noutput ); 

		if ( ret_s.buff_len )
		{
			for (unsigned long i=0; i<N; i++)
			{
				out1[i] = *((short*) (&dfe.byte_buff[i*2*2]));
				out2[i] = *((short*) (&dfe.byte_buff[i*2*2+2]));
			}

			while ( !ret_s.frame_starts.empty() )
			{
				uint64_t offset0 = this->nitems_written(0) + noutput + ret_s.frame_starts.front()/2;
				uint64_t offset1 = this->nitems_written(1) + noutput + ret_s.frame_starts.front()/2;
				pmt::pmt_t key		= pmt::pmt_string_to_symbol( "Frame counter" );
				char temp[50];
				sprintf( temp, "%d", ret_s.frame_cnt.front() );
				pmt::pmt_t value	= pmt::pmt_string_to_symbol( temp );

				this->add_item_tag(0, offset0, key, value);
				this->add_item_tag(1, offset1, key, value);

				ret_s.frame_starts.pop();
				ret_s.frame_cnt.pop();
			}

			noutput += ret_s.buff_len/2/2;
		}

		dfe.ClearFromBeginning( ret_s.buff_len ); // Clear any previous data, that was already processed

		// If we have enough data
		if ( noutput >= N ) 
			break;

		// Not enough but there's not gonna be any new
		if ( s.SourceEmpty() )
			break;

              
		// 2. Get some brand new, raw data
		fs_ret_t ret_s2;
		ret_s2 = s.GetBuffer(10000);
            

		// 3. Find data frames (if any) in data
		unsigned long proc_bytes = dfe.ExtractDataFrames(ret_s2.accum, ret_s2.accum_len);
		s.ClearFromBeginning(proc_bytes);
	}


	// Tell runtime system how many output items we produced.
	if ( noutput == 0 && s.SourceEmpty() )
	{
		printf("Source empty.\n");
		return -1;
	}
	else 
		return noutput;
}



} /* namespace frame_source */
} /* namespace gr */

