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

#ifndef INCLUDED_TWO_CHANNEL_THRESHOLD_TWO_CHANNEL_THRESHOLD_SSSS_IMPL_H
#define INCLUDED_TWO_CHANNEL_THRESHOLD_TWO_CHANNEL_THRESHOLD_SSSS_IMPL_H

#include <two_channel_threshold/two_channel_threshold_ssss.h>

namespace gr 
{
namespace two_channel_threshold 
{

	
		
class two_channel_threshold_ssss_impl 
	: public two_channel_threshold_ssss
{
	private:
		short			d_threshold;
		unsigned short	d_pre_trig_samples;
		unsigned short	d_post_trig_samples;
		int				d_wash_out_counter;


	public:
		two_channel_threshold_ssss_impl(short			threshold,
										unsigned short	pre_trig_samples, 
										unsigned short	post_trig_samples);
												
		~two_channel_threshold_ssss_impl();

	// Where all the action really happens
		int general_work(int						noutput_items,
						gr_vector_int				&ninput_items,
						gr_vector_const_void_star	&input_items,
						gr_vector_void_star			&output_items);
};



} // namespace two_channel_threshold
} // namespace gr

#endif /* INCLUDED_TWO_CHANNEL_THRESHOLD_TWO_CHANNEL_THRESHOLD_SSSS_IMPL_H */
