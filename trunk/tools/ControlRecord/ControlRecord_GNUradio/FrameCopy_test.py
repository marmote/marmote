from optparse import OptionParser

from gnuradio import gr
import gnuradio.extras

import tools.FileSource     as FS
import GNUradio_blocks.FrameSource   as FrameS
import GNUradio_blocks.FrameToFileSink   as FrameTFS


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


        ##################################################
        # Blocks
        ##################################################
        self.frame_source = FrameS.FrameSource(Source)
        self.frame_sink = FrameTFS.FrameToFileSink()
        self.gr_interleave = gr.interleave(gr.sizeof_short*1)


        ##################################################
        # Connections
        ##################################################
        self.connect((self.frame_source, 0), (self.gr_interleave, 0))
        self.connect((self.frame_source, 1), (self.gr_interleave, 1))

        self.connect((self.gr_interleave, 0), (self.frame_sink, 0))



################################################################################
if __name__ == "__main__":
    (options, args) = parser.parse_args()

    s = FS.FileSource(options.inputfileordir)

    tb = Top_Block(s)

    tb.run()