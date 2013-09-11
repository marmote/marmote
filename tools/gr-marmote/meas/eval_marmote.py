#!/usr/bin/env python
##################################################
# Gnuradio Python Flow Graph
# Title: Eval Marmote
# Author: Sandor Szilvasi
# Generated: Tue Sep 10 17:01:32 2013
##################################################

from gnuradio import blocks
from gnuradio import eng_notation
from gnuradio import filter
from gnuradio import gr
from gnuradio.eng_option import eng_option
from gnuradio.filter import firdes
from optparse import OptionParser
import dsss
import marmote
import time

class eval_marmote(gr.top_block):

    def __init__(self, filename="mm_tmp", spread_factor=8, threshold=0.5, rrc_alpha=0.125):
        gr.top_block.__init__(self, "Eval Marmote")

        ##################################################
        # Parameters
        ##################################################
        self.filename = filename
        self.spread_factor = spread_factor
        self.threshold = threshold
        self.rrc_alpha = rrc_alpha

        ##################################################
        # Variables
        ##################################################
        self.total_packets = total_packets = 1000
        self.samp_rate = samp_rate = 10e6
        self.preamble_length = preamble_length = 8*2
        self.payload_length = payload_length = 20
        self.oversample_factor = oversample_factor = 5

        ##################################################
        # Blocks
        ##################################################
        self.root_raised_cosine_filter_0 = filter.fir_filter_ccf(1, firdes.root_raised_cosine(
        	1, samp_rate, samp_rate/5, rrc_alpha, 31))
        self.marmote_cdma_packet_sink_0_0_1_0_0 = marmote.cdma_packet_sink(debug=False, id=5, total_pkt=total_packets)
        self.dsss_pn_despreader_cc_0 = dsss.pn_despreader_cc(
                debug=False,
                mask=0x606,
                seed=0x401,
                spread_factor=spread_factor,
                oversample_factor=oversample_factor,
                preamble_length=preamble_length,
                payload_length=payload_length)

        self.dsss_pn_acquisition_cc_0 = dsss.pn_acquisition_cc(
              debug=False,
              preamble_len=preamble_length,
              spread_factor=spread_factor,
              oversample_factor=oversample_factor,
              pn_mask=0x606,
              pn_seed=0x401,
              threshold=threshold
              )
        self.dsss_packet_deframer_0_0 = dsss.packet_deframer(debug=False)
        self.blocks_throttle_0 = blocks.throttle(gr.sizeof_gr_complex*1, samp_rate)
        self.blocks_null_sink_1_2_1_0_0_0_0 = blocks.null_sink(gr.sizeof_gr_complex*1)
        self.blocks_head_0 = blocks.head(gr.sizeof_gr_complex*1, 1000000000)
        self.blocks_file_source_0 = blocks.file_source(gr.sizeof_gr_complex*1, "" + filename, False)

        ##################################################
        # Connections
        ##################################################
        self.connect((self.dsss_pn_acquisition_cc_0, 0), (self.dsss_pn_despreader_cc_0, 0))
        self.connect((self.dsss_pn_despreader_cc_0, 0), (self.blocks_null_sink_1_2_1_0_0_0_0, 0))
        self.connect((self.blocks_throttle_0, 0), (self.blocks_head_0, 0))
        self.connect((self.blocks_file_source_0, 0), (self.blocks_throttle_0, 0))
        self.connect((self.blocks_head_0, 0), (self.root_raised_cosine_filter_0, 0))
        self.connect((self.root_raised_cosine_filter_0, 0), (self.dsss_pn_acquisition_cc_0, 0))

        ##################################################
        # Asynch Message Connections
        ##################################################
        self.msg_connect(self.dsss_pn_despreader_cc_0, "out", self.dsss_packet_deframer_0_0, "in")
        self.msg_connect(self.dsss_packet_deframer_0_0, "out", self.marmote_cdma_packet_sink_0_0_1_0_0, "in")

# QT sink close method reimplementation

    def get_filename(self):
        return self.filename

    def set_filename(self, filename):
        self.filename = filename
        self.blocks_file_source_0.open("" + self.filename, False)

    def get_spread_factor(self):
        return self.spread_factor

    def set_spread_factor(self, spread_factor):
        self.spread_factor = spread_factor

    def get_threshold(self):
        return self.threshold

    def set_threshold(self, threshold):
        self.threshold = threshold

    def get_rrc_alpha(self):
        return self.rrc_alpha

    def set_rrc_alpha(self, rrc_alpha):
        self.rrc_alpha = rrc_alpha
        self.root_raised_cosine_filter_0.set_taps(firdes.root_raised_cosine(1, self.samp_rate, self.samp_rate/5, self.rrc_alpha, 31))

    def get_total_packets(self):
        return self.total_packets

    def set_total_packets(self, total_packets):
        self.total_packets = total_packets

    def get_samp_rate(self):
        return self.samp_rate

    def set_samp_rate(self, samp_rate):
        self.samp_rate = samp_rate
        self.blocks_throttle_0.set_sample_rate(self.samp_rate)
        self.root_raised_cosine_filter_0.set_taps(firdes.root_raised_cosine(1, self.samp_rate, self.samp_rate/5, self.rrc_alpha, 31))

    def get_preamble_length(self):
        return self.preamble_length

    def set_preamble_length(self, preamble_length):
        self.preamble_length = preamble_length

    def get_payload_length(self):
        return self.payload_length

    def set_payload_length(self, payload_length):
        self.payload_length = payload_length

    def get_oversample_factor(self):
        return self.oversample_factor

    def set_oversample_factor(self, oversample_factor):
        self.oversample_factor = oversample_factor

if __name__ == '__main__':
    parser = OptionParser(option_class=eng_option, usage="%prog: [options]")
    parser.add_option("-f", "--filename", dest="filename", type="string", default="mm_tmp",
        help="Set mm_tmp [default=%default]")
    parser.add_option("-s", "--spread-factor", dest="spread_factor", type="intx", default=8,
        help="Set Spread factor [default=%default]")
    parser.add_option("-t", "--threshold", dest="threshold", type="eng_float", default=eng_notation.num_to_str(0.5),
        help="Set Acquisition threshold [default=%default]")
    parser.add_option("-a", "--rrc-alpha", dest="rrc_alpha", type="eng_float", default=eng_notation.num_to_str(0.125),
        help="Set RRC filter alpha [default=%default]")
    (options, args) = parser.parse_args()
    tb = eval_marmote(filename=options.filename, spread_factor=options.spread_factor, threshold=options.threshold, rrc_alpha=options.rrc_alpha)
    tb.start()
    #raw_input('Press Enter to quit: ')
    time.sleep(options.spread_factor/2)
    tb.stop()
    tb.wait()

