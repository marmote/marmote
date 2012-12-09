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


#ifndef INCLUDED_TWO_CHANNEL_THRESHOLD_TWO_CHANNEL_THRESHOLD_SSSS_H
#define INCLUDED_TWO_CHANNEL_THRESHOLD_TWO_CHANNEL_THRESHOLD_SSSS_H

#include <two_channel_threshold/api.h>
#include <gr_block.h>

namespace gr 
{
namespace two_channel_threshold 
{

	
	
/*!
* \brief <+description of block+>
* \ingroup block
*
*/
		
		
class TWO_CHANNEL_THRESHOLD_API two_channel_threshold_ssss 
	: virtual public gr_block
{
	public:
		typedef boost::shared_ptr<two_channel_threshold_ssss> sptr;

		/*!
		* \brief Return a shared_ptr to a new instance of two_channel_threshold::two_channel_threshold_ssss.
		*
		* To avoid accidental use of raw pointers, two_channel_threshold::two_channel_threshold_ssss's
		* constructor is in a private implementation
		* class. two_channel_threshold::two_channel_threshold_ssss::make is the public interface for
		* creating new instances.
		*/
		static sptr make(short			threshold,
						unsigned short	pre_trig_samples, 
						unsigned short	post_trig_samples);
};



} // namespace two_channel_threshold
} // namespace gr

#endif /* INCLUDED_TWO_CHANNEL_THRESHOLD_TWO_CHANNEL_THRESHOLD_SSSS_H */
