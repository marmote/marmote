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

from gnuradio import gr, blocks

class pn_acquisition(gr.hier_block2):
    """
    docstring for block pn_acquisition
    """
    def __init__(self, preamble_len, spread_factor, oversample_factor, pn_mask, pn_seed):
        gr.hier_block2.__init__(self,
                "pn_acquisition",
                gr.io_signature(1, 1, gr.sizeof_float),
                gr.io_signature(1, 1, gr.sizeof_float))

        self.preamble_len = preamble_len;

        # Blocks
        self.blocks_multiply_const_0 = blocks.multiply_const_vff((preamble_len, ))
        self.blocks_multiply_const_1 = blocks.multiply_const_vff((preamble_len, ))

        # Connections
        self.connect(self, self.blocks_multiply_const_0, self.blocks_multiply_const_1, self)

