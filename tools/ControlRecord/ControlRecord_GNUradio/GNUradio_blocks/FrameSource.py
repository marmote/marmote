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
#        self.MyProfiler3 = MyProfiler.MyProfiler(average_len)
#        self.MyProfiler4 = MyProfiler.MyProfiler(average_len)
        self.MyProfiler5 = MyProfiler.MyProfiler(average_len)
#        self.MyProfiler6 = MyProfiler.MyProfiler(average_len)
#        self.MyProfiler7 = MyProfiler.MyProfiler(average_len)
        self.previous_time = ttt.time()
#Profiling end

        ##########

        self.abcdefg = 0
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
#Profiling begin
#                self.MyProfiler3.start_timer()
#Profiling end

#                f = open('./temp.bin', 'ab')
#                for ii in xrange(len(self.dfe.frame_starts)):
#                    f.write('Frame start: %d, Frame cnt: %d\n'%(self.dfe.frame_starts[ii] , self.dfe.frame_cnt[ii]))
#
#                f.close()

                # 1. Some minor pre-processing steps
                f = open('./temp2.bin', 'ab')
                f.write('Clear from beginning: %d, current size: %d\n'%(self.processed_bytes, self.dfe.byte_buff_len ))
                f.close()

                self.dfe.ClearFromBeginning( self.processed_bytes ) # Clear any previous data, that was already processed

                f = open('./temp2.bin', 'ab')
                f.write('Left after clear from beginning: %d\n'%(self.dfe.byte_buff_len ))
                f.close()

                self.processed_bytes, self.int_buff, self.frame_starts, self.frame_cnt = self.eNs16b.Process( self.dfe.byte_buff, self.dfe.byte_buff_len, self.dfe.frame_starts, self.dfe.frame_cnt, N ) 

                f = open('./temp2.bin', 'ab')
                f.write('N: %d, processed_bytes: %d, int_buff.size: %d\n'%(N, self.processed_bytes , self.int_buff.size))
                f.close()

                if self.processed_bytes:
                    f = open('./temp2.bin', 'ab')
                    for ii in xrange(len(self.dfe.frame_starts)):
                        if self.dfe.frame_starts[ii] > self.processed_bytes :
                            break

                        f.write('Frame start: %d, Frame cnt: %d, diff: %d\n'%(self.dfe.frame_starts[ii] , self.dfe.frame_cnt[ii], self.dfe.frame_cnt[ii] - self.abcdefg))
                        self.abcdefg = self.dfe.frame_cnt[ii]
                    f.close()

#Profiling begin
#                self.MyProfiler3.stop_timer()
#Profiling end

                # If we have any new data, return it
                if self.int_buff.size > 0 :
                    if N == 0 :
                        f = open('./temp2.bin', 'ab')
                        f.write('N==0, DATA\n')
                        f.close()

                    break

                # There's no new data

                if self.s.SourceEmpty() :
                    f = open('./temp2.bin', 'ab')
                    f.write('SOURCE EMPTY\n')
                    f.close()
                    # There's no new data, but the source is already empty, so there is not going to be new data
                    # But there still might be some left in the input buffer (self.dfe.byte_buff)

                    # If we only work with full output buffers (self.int_buff.size == ch_number*N), return now, and call it a day
                    if self.complete_buffs_only :
                        break
                    f = open('./temp2.bin', 'ab')
                    f.write('NON COMPLETE BUFFS\n')
                    f.close()
                    # We work with partial buffers as well

                    # However N == 0 indicates, that we take any output buffer size, so the fact that int_buff was empty really means
                    # that there's nothing left to work with
                    if N == 0 :
                        break
                    f = open('./temp2.bin', 'ab')
                    f.write('N>0\n')
                    f.close()
                    # There's a chance that at this point there's still something left
                    # let's look at it again
                    self.processed_bytes = 0
                    N = 0
                    f = open('./temp2.bin', 'ab')
                    f.write('TRY AGAIN!\n')
                    f.close()
                    continue
               
            f = open('./temp2.bin', 'ab')
            f.write('Get new data from file\n')
            f.close()

#Profiling begin
#            self.MyProfiler7.stop_timer()
#            self.MyProfiler6.start_timer()
#Profiling end

#Profiling begin
#            self.MyProfiler4.start_timer()
#Profiling end
            # 2. Get some brand new, raw data
            accum, accum_length = self.s.GetBuffer(10000)
#Profiling begin
#            self.MyProfiler4.stop_timer()
#Profiling end

            
#Profiling begin
            self.MyProfiler5.start_timer()
#Profiling end

            f = open('./temp2.bin', 'ab')
            f.write('accum_length2: %d\n'%accum_length)
            f.close()
            # 3. Find data frames (if any) in data

            f = open('./temp2.bin', 'ab')
            f.write('self.dfe.byte_buff_len before: %d\n'%(self.dfe.byte_buff_len ))
            f.close()

            proc_bytes = self.dfe.ExtractDataFrames(accum, accum_length)

            f = open('./temp2.bin', 'ab')
            f.write('self.dfe.byte_buff_len after: %d\n'%(self.dfe.byte_buff_len ))
            f.close()
#Profiling begin
            self.MyProfiler5.stop_timer()
#Profiling end

#            f = open('./temp2.bin', 'ab')
#            for ii in xrange(len(self.dfe.frame_starts)):
#                f.write('Frame start: %d, Frame cnt: %d, diff: %d\n'%(self.dfe.frame_starts[ii] , self.dfe.frame_cnt[ii], self.dfe.frame_cnt[ii] - self.abcdefg))
#                self.abcdefg = self.dfe.frame_cnt[ii]
#            f.close()

            #f = open('./temp2.bin', 'wb')
            #accum[:accum_length].tofile(f)
            #f.close()

            self.s.ClearFromBeginning(proc_bytes) 

#Profiling begin
#            self.MyProfiler6.stop_timer()
#            self.MyProfiler7.start_timer()
#Profiling end


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
#            print 'FrameSource average eNs16b time: %.3f ms' % ( self.MyProfiler3.get_result() * 1e3 )
#            print 'FrameSource average source time: %.3f ms' % ( self.MyProfiler4.get_result() * 1e3 )
            print 'FrameSource average dfe time: %.3f ms' % ( self.MyProfiler5.get_result() * 1e3  )
#            print 'FrameSource average combined time: %.3f ms' % ( self.MyProfiler6.get_result() * 1e3  )
#            print 'FrameSource average wait combined time: %.3f ms' % ( self.MyProfiler7.get_result() * 1e3  )
            self.previous_time = current_time
#
        self.MyProfiler.stop_timer()
        self.MyProfiler2.start_timer()
#Profiling end

        #return produced
#        return len(output)
        if self.s.SourceEmpty() and self.int_buff.size == 0 :
            print 'Source empty.'
            return -1
        else :
            return self.int_buff.size
