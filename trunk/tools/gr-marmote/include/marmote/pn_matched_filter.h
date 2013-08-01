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


#ifndef INCLUDED_MARMOTE_PN_MATCHED_FILTER_H
#define INCLUDED_MARMOTE_PN_MATCHED_FILTER_H

#include <marmote/api.h>
#include <gr_sync_interpolator.h>

namespace gr {
  namespace marmote {

    /*!
     * \brief <+description of block+>
     * \ingroup marmote
     *
     */
    class MARMOTE_API pn_matched_filter : virtual public gr_sync_interpolator
    {
     public:
      typedef boost::shared_ptr<pn_matched_filter> sptr;

      /*!
       * \brief Return a shared_ptr to a new instance of marmote::pn_matched_filter.
       *
       * To avoid accidental use of raw pointers, marmote::pn_matched_filter's
       * constructor is in a private implementation
       * class. marmote::pn_matched_filter::make is the public interface for
       * creating new instances.
       */
      static sptr make(bool debug, int mask, int seed, int preamble_len, int spread_factor, int oversample_factor);
    };

  } // namespace marmote
} // namespace gr

#endif /* INCLUDED_MARMOTE_PN_MATCHED_FILTER_H */

