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


#ifndef INCLUDED_FRAME_SOURCE_FRAME_SOURCE_SS_H
#define INCLUDED_FRAME_SOURCE_FRAME_SOURCE_SS_H

#include <frame_source/api.h>
#include <gr_sync_block.h>

namespace gr 
{
namespace frame_source 
{



/*!
* \brief <+description of block+>
* \ingroup block
*
*/


class FRAME_SOURCE_API frame_source_ss 
	: virtual public gr_sync_block
{
	public:
		typedef boost::shared_ptr<frame_source_ss> sptr;

		/*!
		* \brief Return a shared_ptr to a new instance of frame_source::frame_source_ss.
        *
        * To avoid accidental use of raw pointers, frame_source::frame_source_ss's
        * constructor is in a private implementation
        * class. frame_source::frame_source_ss::make is the public interface for
        * creating new instances.
        */
		static sptr make(char* FileOrDir);
};



} // namespace frame_source
} // namespace gr

#endif /* INCLUDED_FRAME_SOURCE_FRAME_SOURCE_SS_H */
