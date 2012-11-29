#tools folder
import os
import sys

mpath = os.path.split(__file__)[0]
addpath = os.path.abspath(os.path.join(mpath, '../tools'))

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
        gr.block.__init__(self, name="File sink for framed data", in_sig=[np.int16], out_sig=None)

        self.FrameConf = FC.Frameconf_t()

        self.file_counter = 0
        self.f = None


################################################################################
    def __del__( self ) :
        pass


################################################################################
    def work(self, input_items, output_items):
#        g = open('./work.txt', 'ab')
#        g.write("FrameToFileSink start\n")
#        g.close

        nread = self.nitems_read(0) #number of items read on port 0
        ninput_items = len(input_items[0])

        input = np.array(input_items[0], dtype=np.int16)
        input.byteswap(True)

        #read all tags associated with port 0 for items in this work function
        tags = self.get_tags_in_range(0, nread, nread+ninput_items)


        frame_starts = []
        frame_cnt = np.array([], dtype=np.uint32)
        threshold_events = []

        for tag in tags:
            key_string = pmt.pmt_symbol_to_string(tag.key)
            if key_string == "Frame counter" :
                frame_start = tag.offset - nread

                if frame_start in frame_starts :
                    continue
            
                frame_starts.append( frame_start )
                frame_cnt = np.append(frame_cnt, np.uint32(int(pmt.pmt_symbol_to_string(tag.value))) )

            elif key_string == "Threshold event" :
                threshold_event = tag.offset - nread

                if threshold_event in threshold_events :
                    continue
            
                threshold_events.append( threshold_event )
                


#        f = open('./frame_temp.txt', 'ab')

#        f.write('BEGINBEGINBEGIN\n')

#        f.write('Threshold event len: %d\n'%len(threshold_events))
#        for ii in xrange(len(threshold_events)):
#            f.write('Threshold event: %d\n'%threshold_events[ii])

#        f.write('Frame start len: %d\n'%len(frame_starts))
#        f.write('Frame cnt len: %d\n'%frame_cnt.size)
#        for ii in xrange(len(frame_starts)):
#            f.write('Frame start: %d, Frame cnt: %d\n'%(frame_starts[ii] , frame_cnt[ii]))

#        f.write('ENDENDENDEND\n\n')
        
#        f.close()


        #####################################
        # Write data to file
        beginning = 0

        while 1 :
            if len(threshold_events) == 0 :
                ending = ninput_items
            else :
                ending = threshold_events[0]
                threshold_events = threshold_events[1:]


            if beginning != ending :

                if self.f == None :
                    self.f = open('./collect_%d.bin'%self.file_counter, 'wb')
                    self.file_counter += 1

                start_idx = beginning

                while 1 :
                    if frame_cnt.size == 0 or frame_starts[0] >= ending :
                        input[start_idx:ending].tofile(self.f)
                        break

                    input[start_idx:frame_starts[0]].tofile(self.f)

                    self.FrameConf.START_OF_FRAME.tofile(self.f)
                    self.FrameConf.DATA_FRAME_ID.tofile(self.f)
            
                    frame_cnt[0].newbyteorder('B').tofile(self.f)


                    start_idx = frame_starts[0]

                    frame_cnt = frame_cnt[1:]
                    frame_starts = frame_starts[1:]


            beginning = ending

            if beginning >= ninput_items :
                break

            if self.f is not None:
                self.f.close()
                self.f = None

#        g = open('./work.txt', 'ab')
#        g.write("FrameToFileSink stop\n")
#        g.close

        return ninput_items