#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Copyright 2013 Sandor Szilvasi.
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
import marmote_swig as marmote
import pmt

class qa_peak_tagger_cc (gr_unittest.TestCase):

    def setUp (self):
        self.tb = gr.top_block ()

    def tearDown (self):
        self.tb = None

    def test_001_t (self):
        src_data = ( 1,  2,  3,  4,  5,  6,  7,  8,  9,  10)
        trg_data = ( 0,  0,  0,  0, 10,  0,  0,  0,  0,   0)

        # Blocks
        src_data = blocks.vector_source_c(src_data)
        src_trig = blocks.vector_source_i(trg_data)

        op = marmote.peak_tagger_cc(
            threshold = 2,
            lookahead = 3,
            delay = 0
        )

        snk_tag = blocks.tag_debug(gr.sizeof_gr_complex, "peak tagger QA")
        snk_data = blocks.vector_sink_c()

        # Connections
        self.tb.connect(src_data, (op,0))
        self.tb.connect(src_trig, (op,1))
        self.tb.connect(op, snk_tag)
        self.tb.connect(op, snk_data)

        self.tb.run()

        # Check data
        x = snk_tag.current_tags()
        y = snk_data.data()

        self.assertEqual(5, y[x[0].offset])

    def test_002_t (self):
        src_data = ( 1,  2,  3,  4,  5,  6,  7,  8,  9,  10)
        trg_data = ( 0,  0,  0,  0, 10,  0,  0,  0,  0,   0)

        # Blocks
        src_data = blocks.vector_source_c(src_data)
        src_trig = blocks.vector_source_i(trg_data)

        op = marmote.peak_tagger_cc(
            threshold = 2,
            lookahead = 3,
            delay = -1
        )

        snk_tag = blocks.tag_debug(gr.sizeof_gr_complex, "peak tagger QA")
        snk_data = blocks.vector_sink_c()

        # Connections
        self.tb.connect(src_data, (op,0))
        self.tb.connect(src_trig, (op,1))
        self.tb.connect(op, snk_tag)
        self.tb.connect(op, snk_data)

        self.tb.run()

        # Check data
        x = snk_tag.current_tags()
        y = snk_data.data()

        self.assertEqual(4, y[x[0].offset])

    def test_003_t (self):
        src_data = ( 1,  2,  3,  4,  5,  6,  7,  8,  9,  10)
        trg_data = ( 0,  0,  0,  0, 10,  0,  0,  0,  0,   0)

        # Blocks
        src_data = blocks.vector_source_c(src_data)
        src_trig = blocks.vector_source_i(trg_data)

        op = marmote.peak_tagger_cc(
            threshold = 2,
            lookahead = 3,
            delay = 1
        )

        snk_tag = blocks.tag_debug(gr.sizeof_gr_complex, "peak tagger QA")
        snk_data = blocks.vector_sink_c()

        # Connections
        self.tb.connect(src_data, (op,0))
        self.tb.connect(src_trig, (op,1))
        self.tb.connect(op, snk_tag)
        self.tb.connect(op, snk_data)

        self.tb.run()

        # Check data
        x = snk_tag.current_tags()
        y = snk_data.data()

        self.assertEqual(6, y[x[0].offset])

if __name__ == '__main__':
    gr_unittest.run(qa_peak_tagger_cc, "qa_peak_tagger_cc.xml")
