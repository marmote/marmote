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

import numpy
from gnuradio import gr

import pmt

class message_sink(gr.basic_block):
    """
    docstring for block message_sink
    """
    def __init__(self, node_id):
        gr.basic_block.__init__(self,
            name="message_sink",
            in_sig = None,
            out_sig = None
        )
        self.node_id = node_id
        self.message_port_register_in(pmt.pmt_intern('in'))
        self.set_msg_handler(pmt.pmt_intern('in'), self.handle_msg)


    def handle_msg(self, msg):
        for c in bytearray(pmt.pmt_symbol_to_string(msg)):
            print str(c).rjust(3),
