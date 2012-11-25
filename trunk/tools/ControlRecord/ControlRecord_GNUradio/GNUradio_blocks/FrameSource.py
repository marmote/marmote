#tools folder
import os
import sys

mpath = os.path.split(__file__)[0]
addpath = os.path.abspath(os.path.join(mpath, '..\\tools'))

if addpath not in sys.path :
	sys.path.append(addpath)
	print 'Module folder added to system path'
#tools folder


import ExtractFrames as EF
import FrameConfig as FC
import ExtractNsamples16Bit as ENS16B

#Profiling begin
import MyProfiler
import time as ttt
#Profiling end


from gnuradio import gr
import gnuradio.extras

from gruel import pmt as pmt


import numpy as np


################################################################################
class FrameSource(gr.block):

################################################################################
    def __init__(self, Source, N=1024, complete_buffs_only = True):
        gr.block.__init__(self, name="Generic Data Source Two channel 16 bit data source", in_sig=None, out_sig=[np.int16])

        FrameConf = FC.Frameconf_t()

        ##########

        self.N      = N
        self.complete_buffs_only = complete_buffs_only

        self.s      = Source
        self.dfe    = EF.DataFrameExtractor(FrameConf.START_OF_FRAME, FrameConf.DATA_FRAME_ID)
        self.eNs16b = ENS16B.ExtractNsamples16Bit()

#Profiling begin
        average_len = 1000
        self.MyProfiler = MyProfiler.MyProfiler(average_len)
        self.MyProfiler2 = MyProfiler.MyProfiler(average_len)
        self.MyProfiler5 = MyProfiler.MyProfiler(average_len)
        self.previous_time = ttt.time()
#Profiling end

        ##########

        self.processed_bytes = 0


################################################################################
    def __del__( self ) :
        pass


################################################################################
    def work(self, input_items, output_items):

#Profiling begin
        self.MyProfiler2.stop_timer()
        self.MyProfiler.start_timer()
#Profiling end

        N = self.N

        while 1 :
            if N > 0 or self.s.SourceEmpty() :
                # 1. Some minor pre-processing steps
                self.dfe.ClearFromBeginning( self.processed_bytes ) # Clear any previous data, that was already processed

                self.processed_bytes, self.int_buff, self.frame_starts, self.frame_cnt = self.eNs16b.Process( self.dfe.byte_buff, self.dfe.byte_buff_len, self.dfe.frame_starts, self.dfe.frame_cnt, N ) 

                # If we have any new data, return it
                if self.int_buff.size > 0 :
                    break

                # There's no new data
                if self.s.SourceEmpty() :
                    # There's no new data, but the source is already empty, so there is not going to be new data
                    # But there still might be some left in the input buffer (self.dfe.byte_buff)

                    # If we only work with full output buffers (self.int_buff.size == ch_number*N), return now, and call it a day
                    if self.complete_buffs_only :
                        break
                    # We work with partial buffers as well

                    # However N == 0 indicates, that we take any output buffer size, so the fact that int_buff was empty really means
                    # that there's nothing left to work with
                    if N == 0 :
                        break

                    # There's a chance that at this point there's still something left
                    # let's look at it again
                    self.processed_bytes = 0
                    N = 0
                    continue
               
            # 2. Get some brand new, raw data
            accum, accum_length = self.s.GetBuffer(10000)
            
#Profiling begin
            self.MyProfiler5.start_timer()
#Profiling end

            # 3. Find data frames (if any) in data
            proc_bytes = self.dfe.ExtractDataFrames(accum, accum_length)

#Profiling begin
            self.MyProfiler5.stop_timer()
#Profiling end

            self.s.ClearFromBeginning(proc_bytes) 

        #process data
        output_items[0][:self.int_buff.size] = self.int_buff

        for ii in xrange(len(self.frame_starts)) :
            offset = self.nitems_written(0) + self.frame_starts[ii]
            key = pmt.pmt_string_to_symbol( "Frame counter" )
            value = pmt.pmt_string_to_symbol( "%d"%self.frame_cnt[ii] )

            self.add_item_tag(0, offset, key, value)


#Profiling begin
        current_time = ttt.time()
        if current_time - self.previous_time > 3 :
            print 'FrameSource average processing time: %.3f ms' % ( self.MyProfiler.get_result() * 1e3 )
            print 'FrameSource average processing time per sample: %.3f us' % ( self.MyProfiler.get_result() * 1e6/self.N )
            print 'FrameSource average waiting time: %.3f ms' % ( self.MyProfiler2.get_result() * 1e3 )
            print 'FrameSource average dfe time: %.3f ms' % ( self.MyProfiler5.get_result() * 1e3  )

            self.previous_time = current_time

        self.MyProfiler.stop_timer()
        self.MyProfiler2.start_timer()
#Profiling end

        #return produced
        if self.s.SourceEmpty() and self.int_buff.size == 0 :
            print 'Source empty.'
            return -1
        else :
            return self.int_buff.size
