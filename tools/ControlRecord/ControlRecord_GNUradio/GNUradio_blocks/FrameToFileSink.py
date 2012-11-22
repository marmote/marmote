#tools folder
import os
import sys

mpath = os.path.split(__file__)[0]
addpath = os.path.abspath(os.path.join(mpath, '..\\tools'))

if addpath not in sys.path :
	sys.path.append(addpath)
	print 'Module folder added to system path'
#tools folder


import FrameConfig as FC


from gnuradio import gr
import gnuradio.extras

from gruel import pmt as pmt


import numpy as np


################################################################################
class FrameToFileSink(gr.block):

################################################################################
    def __init__(self):
        gr.block.__init__(self, name="Generic Data Source Two channel 16 bit data source", in_sig=[np.int16], out_sig=None)

        self.FrameConf = FC.Frameconf_t()

        self.f = open('./collect_%d.bin'%1234, 'wb')


################################################################################
    def __del__( self ) :
        pass


################################################################################
    def work(self, input_items, output_items):
        nread = self.nitems_read(0) #number of items read on port 0
        ninput_items = len(input_items[0])
        input = np.array(input_items[0], dtype=np.uint16)

        #read all tags associated with port 0 for items in this work function
        tags = self.get_tags_in_range(0, nread, nread+ninput_items)


        frame_starts = []
        frame_cnt = np.array([], dtype=np.uint32)
        for tag in tags:
            key_string = pmt.pmt_symbol_to_string(tag.key)
            if key_string == "Frame counter" :
                frame_starts.append( tag.offset - nread )
                frame_cnt = np.append(frame_cnt, np.uint32(int(pmt.pmt_symbol_to_string(tag.value))) )


        #####################################
        # Write data to file
#        f = open('./collect_%d.bin'%frame_cnt[0], 'wb')

        frame_starts.append(ninput_items)

        for ii in xrange(len(frame_starts) - 1) :

            self.FrameConf.START_OF_FRAME.tofile(self.f)
            self.FrameConf.DATA_FRAME_ID.tofile(self.f)

            frame_cnt[ii].newbyteorder('B').tofile(self.f)

            input[frame_starts[ii]:frame_starts[ii+1]].tofile(self.f)
                
#        f.close()

        return ninput_items