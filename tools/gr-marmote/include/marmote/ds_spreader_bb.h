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


#ifndef INCLUDED_MARMOTE_DS_SPREADER_BB_H
#define INCLUDED_MARMOTE_DS_SPREADER_BB_H

#include <marmote/api.h>
#include <gr_sync_interpolator.h>

namespace gr {
  namespace marmote {

    /*!
     * \brief <+description of block+>
     * \ingroup marmote
     *
     */
    class MARMOTE_API ds_spreader_bb : virtual public gr_sync_interpolator
    {
     public:
      typedef boost::shared_ptr<ds_spreader_bb> sptr;

      /*!
       * \brief Return a shared_ptr to a new instance of marmote::ds_spreader_bb.
       *
       * To avoid accidental use of raw pointers, marmote::ds_spreader_bb's
       * constructor is in a private implementation
       * class. marmote::ds_spreader_bb::make is the public interface for
       * creating new instances.
       */
      static sptr make(unsigned int sf);
    };

  } // namespace marmote
} // namespace gr

#endif /* INCLUDED_MARMOTE_DS_SPREADER_BB_H */

