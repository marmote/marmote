#!/usr/bin/env python
#
# Copyright 2013 <+YOU OR YOUR COMPANY+>.
#
# This is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3, or (at your option)
# any later version.
#
# This software is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this software; see the file COPYING.  If not, write to
# the Free Software Foundation, Inc., 51 Franklin Street,
# Boston, MA 02110-1301, USA.
#

from gnuradio import gr, gr_unittest
import marmote_swig as marmote

class qa_pn_spreader_b (gr_unittest.TestCase):

    def setUp (self):
        self.tb = gr.top_block ()

    def tearDown (self):
        self.tb = None

    def test_001_t (self):
        # set up
        # spread_factor = 4

        # src_data = (0, 0, 0, 0)
        # exp_res = ()

        # src = gr.vector_source_f (src_data)
        # sprd = marmote.pn_spreader_b(
        #     debug=False,
        #     mask=0x492,
        #     seed=0x401,
        #     spread_factor=spread_factor)
        # dst = gr.vector_sink_f ()

        # # # connecitons
        # self.tb.connect(src, sprd, dst)

        # self.tb.run ()

        # check data
        # print src
        # print sprd

        # res = dst.data()
        # self.assertFloatTuplesAlmostEqual (exp_res, res, 6)


if __name__ == '__main__':
    gr_unittest.run(qa_pn_spreader_b, "qa_pn_spreader_b.xml")
