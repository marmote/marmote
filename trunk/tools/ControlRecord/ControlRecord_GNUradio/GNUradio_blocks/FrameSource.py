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

import numpy as np


################################################################################
class FrameSource(gr.block):

################################################################################
    def __init__(self, Source, N=1024):
        gr.block.__init__(self, name="Generic Data Source Two channel 16 bit data source", in_sig=None, out_sig=[np.int16])

        FrameConf = FC.Frameconf_t()

        ##########

        self.N      = N

        self.s      = Source
        self.dfe    = EF.DataFrameExtractor(FrameConf.START_OF_FRAME, FrameConf.DATA_FRAME_ID)
        self.eNs16b = ENS16B.ExtractNsamples16Bit()

#Profiling begin
        average_len = 1000
        self.MyProfiler = MyProfiler.MyProfiler(average_len)
        self.MyProfiler2 = MyProfiler.MyProfiler(average_len)
#        self.MyProfiler3 = MyProfiler.MyProfiler(average_len)
#        self.MyProfiler4 = MyProfiler.MyProfiler(average_len)
        self.MyProfiler5 = MyProfiler.MyProfiler(average_len)
#        self.MyProfiler6 = MyProfiler.MyProfiler(average_len)
#        self.MyProfiler7 = MyProfiler.MyProfiler(average_len)
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

        while 1 :
            if self.N > 0 or self.s.SourceEmpty() :
#Profiling begin
#                self.MyProfiler3.start_timer()
#Profiling end

                # 1. Some minor pre-processing steps
                self.dfe.ClearFromBeginning( self.processed_bytes ) # Clear any previous data, that was already processed
                
                self.processed_bytes, self.int_buff, self.frame_starts = self.eNs16b.Process( self.dfe.byte_buff, self.dfe.byte_buff_len, self.dfe.frame_starts, self.dfe.frame_cnt, self.N ) 
#Profiling begin
#                self.MyProfiler3.stop_timer()
#Profiling end

                if self.s.SourceEmpty() or self.int_buff.size > 0 :
                    break

#Profiling begin
#            self.MyProfiler7.stop_timer()
#            self.MyProfiler6.start_timer()
#Profiling end

#Profiling begin
#            self.MyProfiler4.start_timer()
#Profiling end
            # 2. Get some brand new, raw data
            accum, accum_length = self.s.GetBuffer(1000)
#Profiling begin
#            self.MyProfiler4.stop_timer()
#Profiling end

            
#Profiling begin
            self.MyProfiler5.start_timer()
#Profiling end
            # 3. Find data frames (if any) in data
            self.dfe.ExtractDataFrames(accum)
#Profiling begin
            self.MyProfiler5.stop_timer()
#Profiling end
            self.s.ClearFromBeginning(accum_length) 

#Profiling begin
#            self.MyProfiler6.stop_timer()
#            self.MyProfiler7.start_timer()
#Profiling end


        #process data
        output_items[0][:self.int_buff.size] = self.int_buff

#Profiling begin
        current_time = ttt.time()
        if current_time - self.previous_time > 3 :
            print 'GenerateData processing time: %.3f' % ( self.MyProfiler.get_result() * 1e3 )
            print 'GenerateData waiting time: %.3f' % ( self.MyProfiler2.get_result() * 1e3 )
#            print 'GenerateData eNs16b time: %.3f' % ( self.MyProfiler3.get_result() * 1e3 )
#            print 'GenerateData source time: %.3f' % ( self.MyProfiler4.get_result() * 1e3 )
            print 'GenerateData dfe time: %.3f' % ( self.MyProfiler5.get_result() * 1e3  )
#            print 'GenerateData combined time: %.3f' % ( self.MyProfiler6.get_result() * 1e3  )
#            print 'GenerateData wait combined time: %.3f' % ( self.MyProfiler7.get_result() * 1e3  )
            self.previous_time = current_time
#
        self.MyProfiler.stop_timer()
        self.MyProfiler2.start_timer()
#Profiling end

        #return produced
#        return len(output)
        return self.int_buff.size
