# Copyright 2011 Free Software Foundation, Inc.
#
# This file is part of GNU Radio
#
# GNU Radio is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3, or (at your option)
# any later version.
#
# GNU Radio is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with GNU Radio; see the file COPYING.  If not, write to
# the Free Software Foundation, Inc., 51 Franklin Street,
# Boston, MA 02110-1301, USA.
install(FILES
    marmote_mac_framer_b.xml
    marmote_gmsk_packet_sink_b.xml
    marmote_mac_deframer.xml
    marmote_traffic_generator.xml
    marmote_cdma_packet_source.xml
    marmote_cdma_packet_sink.xml
    marmote_pn_spreader_f.xml
    marmote_pn_synchronizer.xml
    marmote_pn_despreader.xml
    marmote_message_source.xml
    marmote_message_sink.xml
    marmote_cdma_packet_framer.xml
    marmote_pn_spreader_b.xml
    marmote_pn_despreader_cc.xml
    marmote_pn_synchronizer_cc.xml DESTINATION share/gnuradio/grc/blocks
)
