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

import pmt
import time
import thread

import numpy
from gnuradio import gr

import struct
import sys


class message_source(gr.basic_block):
    """
    docstring for block message_source
    """
    def __init__(self, debug, msg_interval, msg_len, node_id):

        gr.basic_block.__init__(self,
            name="message_source",
            in_sig = None,
            out_sig = None
        )

        self.debug = debug
        self.node_id = node_id
        self.msg_interval = msg_interval
        self.msg_len = msg_len
        self.msg_ctr = 0x00
        self.message_port_register_out(pmt.pmt_intern('out'))

        self.finished = False
        try:
            self.msg_src_thread = thread.start_new_thread(self.run, (msg_interval,))
        except Exception as inst:
            print "Error: message_source is unable to start thread"
            print type(inst)     # the exception instance
            print inst.args      # arguments stored in .args
            print inst           # __str__ allows args to printed directly


    def __del__(self):

        self.finished = True
        self.msg_src_thread.join()


    def run(self, msg_interval):

        while self.finished == False:
            self.payload = ''
            for i in xrange(0,self.msg_len):
                self.payload = self.payload + chr(self.msg_ctr & 0xFF)
            self.msg_ctr += 1

            if self.debug:
                print "#" + str(self.node_id) + " ->",
                for i in range(0,len(self.payload)):
                    # print hex(ord(self.payload[i])),
                    print "%02x" % ord(self.payload[i]),
                print ""
                sys.stdout.flush()

            time.sleep(msg_interval)
            self.message_port_pub(pmt.pmt_intern('out'), pmt.pmt_intern(self.payload))
