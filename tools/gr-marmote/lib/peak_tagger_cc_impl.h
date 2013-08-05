/* -*- c++ -*- */
/* 
 * Copyright 2013 Sandor Szilvasi.
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

#ifndef INCLUDED_MARMOTE_PEAK_TAGGER_CC_IMPL_H
#define INCLUDED_MARMOTE_PEAK_TAGGER_CC_IMPL_H

#include <marmote/peak_tagger_cc.h>

namespace gr {
    namespace marmote {

        class peak_tagger_cc_impl : public peak_tagger_cc
        {
            private:
                int d_threshold;

                pmt::pmt_t d_srcid;
                pmt::pmt_t d_key;
                pmt::pmt_t d_value;

            public:
                peak_tagger_cc_impl(int threshold);
                ~peak_tagger_cc_impl();

                int work(int noutput_items,
                        gr_vector_const_void_star &input_items,
                        gr_vector_void_star &output_items);
        };

    } // namespace marmote
} // namespace gr

#endif /* INCLUDED_MARMOTE_PEAK_TAGGER_CC_IMPL_H */

