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

from gruel import pmt

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
        print 'kCRC: ' # + crc16(msg)
        for c in bytearray(pmt.pmt_symbol_to_string(msg)):
            print str(c).rjust(3),

        # bc = bytearray(pmt.pmt_symbol_to_string(msg));
        print 'kCRC: ' # + crc16(msg)

        


    # def crc16(self, pkt):
    #     crc = 0
    #     for c in bytearray(pmt.pmt_symbol_to_string(msg)):
    #         for k in xrange(8):
    #             inbit = (!!(c & (1 << k)) ^ (crc & 0x1))
    #             crc = crc >> 1;

    #             if inbit:
    #                 crc ^= (1 << 15);
    #                 crc ^= (1 << 10);
    #                 crc ^= (1 <<  3);
    #     return crc

# uint16_t crc = 0;
# for (int i = 0; i < len; i++)
# {
#   for (int k = 0; k < 8; k++)
#   {
#     int input_bit = (!!(buf[i] & (1 << k)) ^ (crc & 1));
#     crc = crc >> 1;
#     if (input_bit)
#     {
#       crc ^= (1 << 15);
#       crc ^= (1 << 10);
#       crc ^= (1 <<  3);
#     }
#   }
# }
# return crc;


# # 16-bit CRCs should detect 65535/65536 or 99.998% of all errors in
# # data blocks up to 4096 bytes
# MASK_CCITT = 0x1021 # CRC-CCITT mask (ISO 3309, used in X25, HDLC)
# MASK_CRC16 = 0xA001 # CRC16 mask (used in ARC files)

# #----------------------------------------------------------------------------
# # Calculate and return an incremental CRC value based on the current value
# # and the data bytes passed in as a string.
# #
# def updcrc(crc, data, mask=MASK_CRC16):

# # data_length = len(data)
# # unpackFormat = '%db' % data_length
# # unpackedData = struct.unpack(unpackFormat, data)

# for char in data:
# c = ord(char)
# c = c << 8

# for j in xrange(8):
# if (crc ^ c) & 0x8000:
# crc = (crc << 1) ^ mask
# else:
# crc = crc << 1
# c = c << 1

# return crc & 0xffff

