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


#ifndef INCLUDED_MARMOTE_PN_SPREADER_B_H
#define INCLUDED_MARMOTE_PN_SPREADER_B_H

#include <marmote/api.h>
#include <gnuradio/sync_interpolator.h>

namespace gr {
  namespace marmote {

    /*!
     * \brief <+description of block+>
     * \ingroup marmote
     *
     */
    class MARMOTE_API pn_spreader_b : virtual public gr::sync_interpolator
    {
     public:
      typedef boost::shared_ptr<pn_spreader_b> sptr;

      /*!
       * \brief Return a shared_ptr to a new instance of marmote::pn_spreader_b.
       *
       * To avoid accidental use of raw pointers, marmote::pn_spreader_b's
       * constructor is in a private implementation
       * class. marmote::pn_spreader_b::make is the public interface for
       * creating new instances.
       */
      static sptr make(bool debug, int mask, int seed, int spread_factor);
    };

  } // namespace marmote
} // namespace gr

#endif /* INCLUDED_MARMOTE_PN_SPREADER_B_H */

