from optparse import OptionParser

from gnuradio import gr
import gnuradio.extras

import tools.FileSource     as FS
import GNUradio_blocks_pure_python.FrameSource   as FrameS
import GNUradio_blocks_pure_python.FrameToFileSink   as FrameTFS
import GNUradio_blocks_pure_python.CustomTwoChannelThreshold as Threshold
from gnuradio.gr import firdes


parser = OptionParser()
parser.add_option("-i", "--input", dest="inputfileordir",
                  help="Input binary file or directory containing binary files <FILEORDIRNAME> (default %default)", metavar="FILEORDIRNAME", default="input.bin")


################################################################################
class Top_Block(gr.top_block):

    def __init__(self, Source):
        gr.top_block.__init__(self, "Top Block")

        ##################################################
        # Variables
        ##################################################
        self.samp_rate = samp_rate = 750e3
        self.transition = transition = 100e3
        self.cutoff = cutoff = 100000


        ##################################################
        # Blocks
        ##################################################
        self.frame_source = FrameS.FrameSource(Source)

        self.gr_short_to_float_0 = gr.short_to_float(1, 32768)
        self.gr_short_to_float_1 = gr.short_to_float(1, 32768)

        self.high_pass_filter_0 = gr.fir_filter_fff(1, firdes.high_pass(
			1, samp_rate, cutoff, transition, firdes.WIN_RECTANGULAR, 6.76))
        self.high_pass_filter_1 = gr.fir_filter_fff(1, firdes.high_pass(
			1, samp_rate, cutoff, transition, firdes.WIN_RECTANGULAR, 6.76))

        self.gr_float_to_short_0 = gr.float_to_short(1, 32768)
        self.gr_float_to_short_1 = gr.float_to_short(1, 32768)

        self.threshold = Threshold.CustomTwoChannelThreshold()

        self.gr_interleave = gr.interleave(gr.sizeof_short*1)

        self.frame_sink = FrameTFS.FrameToFileSink()


        ##################################################
        # Connections
        ##################################################
        self.connect((self.frame_source, 0), (self.gr_short_to_float_0, 0))
        self.connect((self.frame_source, 1), (self.gr_short_to_float_1, 0))

        self.connect((self.gr_short_to_float_0, 0), (self.high_pass_filter_0, 0))
        self.connect((self.gr_short_to_float_1, 0), (self.high_pass_filter_1, 0))

        self.connect((self.high_pass_filter_0, 0), (self.gr_float_to_short_0, 0))
        self.connect((self.high_pass_filter_1, 0), (self.gr_float_to_short_1, 0))

        self.connect((self.gr_float_to_short_0, 0), (self.threshold, 0))
        self.connect((self.gr_float_to_short_1, 0), (self.threshold, 1))

        self.connect((self.threshold, 0), (self.gr_interleave, 0))
        self.connect((self.threshold, 1), (self.gr_interleave, 1))

        self.connect((self.gr_interleave, 0), (self.frame_sink, 0))


################################################################################
if __name__ == "__main__":
    (options, args) = parser.parse_args()

    s = FS.FileSource(options.inputfileordir)

    tb = Top_Block(s)

    tb.run()