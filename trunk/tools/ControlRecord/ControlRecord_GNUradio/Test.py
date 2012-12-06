from optparse import OptionParser

from gnuradio import gr
import gnuradio.extras

import tools.FileSource     as FS
import GNUradio_blocks_pure_python.FrameSource   as FrameS
import GNUradio_blocks_pure_python.FrameToFileSink   as FrameTFS
import GNUradio_blocks_pure_python.CustomTwoChannelThreshold as Threshold

import numpy as np


parser = OptionParser()
parser.add_option("-i", "--input", dest="inputfileordir",
                  help="Input binary file or directory containing binary files <FILEORDIRNAME> (default %default)", metavar="FILEORDIRNAME", default="input.bin")


class custom_block(gr.block):
    
    def __init__(self, args):
        gr.block.__init__(self, name="my adder",
        in_sig=[np.int16],
        out_sig=[np.int16])


    def work(self, input_items, output_items):
        #buffer references
        input = np.array(input_items[0], dtype=np.int16)
        output = output_items[0]

        #process data
        output[:] = input + 1

        #return produced
        return len(output)


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
        self.frame_source = FrameS.FrameSource(Source, N=6*1024, complete_buffs_only = False)
        self.frame_sink = FrameTFS.FrameToFileSink()
        self.threshold = Threshold.CustomTwoChannelThreshold()
        self.gr_deinterleave = gr.deinterleave(gr.sizeof_short*1)
        self.gr_interleave = gr.interleave(gr.sizeof_short*1)

        self.sink_queue = gr.msg_queue()
        self.msg_sink = gr.message_sink(gr.sizeof_short, self.sink_queue, True)
        self.testblock = custom_block(None)


        ##################################################
        # Connections
        ##################################################
        self.connect((self.frame_source, 0), (self.gr_deinterleave, 0))

        self.connect((self.gr_deinterleave, 0), (self.threshold, 0))
        self.connect((self.gr_deinterleave, 1), (self.threshold, 1))

        self.connect((self.threshold, 0), (self.gr_interleave, 0))
        self.connect((self.threshold, 1), (self.gr_interleave, 1))

        self.connect((self.gr_interleave, 0), (self.frame_sink, 0))


        self.connect((self.frame_source, 0), (self.testblock, 0))
        self.connect((self.testblock, 0), (self.msg_sink, 0))


    def recv_pkt(self):
        pkt = ""

        #if self.sink_queue.count():
        pkt = self.sink_queue.delete_head().to_string()

        return pkt  


################################################################################
if __name__ == "__main__":
    (options, args) = parser.parse_args()

    s = FS.FileSource(options.inputfileordir)

    tb = Top_Block(s)

    tb.start()

    tempval = tb.recv_pkt()

    tb.wait()