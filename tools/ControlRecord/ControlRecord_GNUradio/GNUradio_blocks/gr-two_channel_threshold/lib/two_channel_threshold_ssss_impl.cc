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
#include "two_channel_threshold_ssss_impl.h"

#include <stdlib.h>
#include <stdio.h>


namespace gr 
{
namespace two_channel_threshold 
{

	
	
/***************************************************************************************
* Make
***************************************************************************************/		
two_channel_threshold_ssss::sptr
two_channel_threshold_ssss::make(short			threshold,
								unsigned short	pre_trig_samples, 
								unsigned short	post_trig_samples)
{
	return gnuradio::get_initial_sptr ( new two_channel_threshold_ssss_impl(threshold,
																			pre_trig_samples, 
																			post_trig_samples) );
}


/***************************************************************************************
* The private constructor
***************************************************************************************/
two_channel_threshold_ssss_impl::two_channel_threshold_ssss_impl(short			threshold,
																unsigned short	pre_trig_samples,
																unsigned short	post_trig_samples)
	:	gr_block("two_channel_threshold_ssss",
				gr_make_io_signature(2, 2, sizeof (short)),
				gr_make_io_signature(2, 2, sizeof (short)) ),
		d_threshold(threshold),
		d_pre_trig_samples(pre_trig_samples), 
		d_post_trig_samples(post_trig_samples),
		d_wash_out_counter(0)				
{
	set_history(d_pre_trig_samples+1);
	set_tag_propagation_policy(TPP_DONT);
}


/***************************************************************************************
* Our virtual destructor
***************************************************************************************/
two_channel_threshold_ssss_impl::~two_channel_threshold_ssss_impl()
{
}


/***************************************************************************************
* General Work (hoping to get promoted to Admiral Work one day... I'm so funny!)
***************************************************************************************/
int
two_channel_threshold_ssss_impl::general_work (int						noutput_items,
											gr_vector_int				&ninput_items,
											gr_vector_const_void_star	&input_items,
											gr_vector_void_star			&output_items)
{
	short 		*out1	=	(short *) 		output_items[0];	
	short 		*out2	=	(short *) 		output_items[1];	
	
	const short	*input1	=	(const short *)	input_items[0];
	const short	*input2	=	(const short *)	input_items[1];

	// skip in input buffer because of history
	input1 += d_pre_trig_samples; 
	input2 += d_pre_trig_samples;



	int ninput;
	ninput = ninput_items[0] < ninput_items[1] ? ninput_items[0] : ninput_items[1];
	ninput = ninput < noutput_items ? ninput : noutput_items;
		
	int noutput = 0;

		
	for (long i = 0; i < ninput; i++)
	{
		if ( (abs(input1[i]) > d_threshold) || (abs(input2[i]) > d_threshold) )
		{
			if (d_wash_out_counter == 0)
			{
				const uint64_t offset1 = this->nitems_written(0) + noutput;
				const uint64_t offset2 = this->nitems_written(1) + noutput;
				pmt::pmt_t key		= pmt::pmt_string_to_symbol("Threshold event");
				pmt::pmt_t value	= pmt::pmt_string_to_symbol("");

				//write at tag to output with given absolute item offset
				this->add_item_tag(0, offset1, key, value);
				this->add_item_tag(1, offset2, key, value);
			}
				
			d_wash_out_counter = d_pre_trig_samples + 1 + d_post_trig_samples;
		}
			
		if (!d_wash_out_counter)
			continue;

		d_wash_out_counter--;
				
		int nin = i - d_pre_trig_samples;
		out1[noutput] = input1[nin];
		out2[noutput] = input2[nin];

		//Stream tag propagation, all to all
		for (unsigned char ch = 0; ch < 2; ch++)
		{
/*				{
				    char temp[50];
				    sprintf( temp, "Test\r" );

				    FILE* tempfp = fopen("DebugDump1.bin", "ab");
				    fwrite( (void*) temp, sizeof(char), strlen(temp), tempfp );
				    fclose(tempfp);
				}
*/
			std::vector<gr_tag_t> tags;
			this->get_tags_in_range(tags, ch, this->nitems_read(ch)+nin, this->nitems_read(ch)+nin+1);

			for (std::vector<gr_tag_t>::size_type i = 0; i < tags.size(); i++) 
			{
/*				{
				    char temp[50];
				    sprintf( temp, "%s, %d\r", pmt::pmt_symbol_to_string(tags[i].key).c_str(), pmt::pmt_to_long(tags[i].value) );

				    FILE* tempfp = fopen("DebugDump1.bin", "ab");
				    fwrite( (void*) temp, sizeof(char), strlen(temp), tempfp );
				    fclose(tempfp);
				}
*/
				const uint64_t offset1 = this->nitems_written(0) + noutput;
				const uint64_t offset2 = this->nitems_written(1) + noutput;
				this->add_item_tag(0, offset1, tags[i].key, tags[i].value);
				this->add_item_tag(1, offset2, tags[i].key, tags[i].value);
			}
		}

		noutput++;
	} 

	// Tell runtime system how many input items we consumed on
	// each input stream.
	consume_each(ninput);

	// Tell runtime system how many output items we produced.
	return noutput;
}



} /* namespace two_channel_threshold */
} /* namespace gr */
