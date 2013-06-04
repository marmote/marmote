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

from gruel import pmt
import time
import thread

import numpy
from gnuradio import gr

import struct


class message_source(gr.basic_block):
    """
    docstring for block message_source
    """
    def __init__(self, msg_interval):
        gr.basic_block.__init__(self,
            name="message_source",
            in_sig = None,
            out_sig = None
        )
        self.msg_interval = msg_interval
        self.msg_ctr = 0;
        self.message_port_register_out(pmt.pmt_intern('out'))

        try:
            thread.start_new_thread(self.run, (msg_interval,))
        except Exception as inst:
            print "Error: message_source is unable to start thread"
            print type(inst)     # the exception instance
            print inst.args      # arguments stored in .args
            print inst           # __str__ allows args to printed directly


    def run(self, msg_interval):
        while 1: # FIXME: implement graceful thread exit
            time.sleep(msg_interval)
            self.message_port_pub(pmt.pmt_intern('out'), pmt.pmt_from_long(self.msg_ctr))
            self.msg_ctr += 1
