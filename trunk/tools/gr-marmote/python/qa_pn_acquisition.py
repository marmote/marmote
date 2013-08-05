#!/usr/bin/env python
# -*- coding: utf-8 -*-
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

from gnuradio import gr, blocks, gr_unittest
from pn_acquisition import pn_acquisition


class qa_pn_acquisition (gr_unittest.TestCase):

    def setUp(self):
        self.tb = gr.top_block()

    def tearDown(self):
        self.tb = None

    def test_001_t(self):
        # set up fg
        mult_val = 4
        src_data = (1, 2, 3, 4)
        exp_res = tuple([mult_val * x for x in range(1, 5)])

        src = blocks.vector_source_c(src_data)
        op = pn_acquisition(2, 1, 1, 1, 1)
        dst = blocks.vector_sink_c()

        self.tb.connect(src, op, dst)

        self.tb.run()

        # check data
        dst_data = dst.data()

        print 'src_data: ' + str(src_data)
        print 'out_data: ' + str(dst_data)
        print 'exp_res: ' + str(exp_res)

        self.assertEqual(exp_res, dst_data)


if __name__ == '__main__':
    gr_unittest.run(qa_pn_acquisition, "qa_pn_acquisition.xml")
