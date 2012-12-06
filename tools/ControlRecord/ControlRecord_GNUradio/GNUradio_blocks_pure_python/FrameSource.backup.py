#tools folder
import os
import sys

mpath = os.path.split(__file__)[0]
addpath = os.path.abspath(os.path.join(mpath, '../tools'))

if addpath not in sys.path :
	sys.path.append(addpath)
	print 'Module folder added to system path'
#tools folder


import ExtractFrames as EF
import FrameConfig as FC
#import ExtractNsamples16Bit as ENS16B

#Profiling begin
#import MyProfiler
#import time as ttt
#Profiling end


from gnuradio import gr
import gnuradio.extras

from gruel import pmt as pmt


import numpy as np


################################################################################
class FrameSource(gr.block):

################################################################################
    def __init__(self, Source):
        gr.block.__init__(self, name="Generic Data Source (Two channel, 16 bit)", in_sig=None, out_sig=[np.int16, np.int16])
#        self.set_auto_consume(False)

        FrameConf = FC.Frameconf_t()

        ##########
        self.s      = Source
        self.dfe    = EF.DataFrameExtractor(FrameConf.START_OF_FRAME, FrameConf.DATA_FRAME_ID)
#        self.eNs16b = ENS16B.ExtractNsamples16Bit()

#Profiling begin
#        average_len = 1000
#        self.MyProfiler = MyProfiler.MyProfiler(average_len)
#        self.MyProfiler2 = MyProfiler.MyProfiler(average_len)
#        self.MyProfiler5 = MyProfiler.MyProfiler(average_len)
#        self.previous_time = ttt.time()
#Profiling end

        ##########

#        self.cum = 0
#        self.processed_bytes = 0
        self.total_processed_bytes = 0
        self.total_processed_bytes2 = 0
        self.total_processed_bytes3 = 0


################################################################################
    def __del__( self ) :
        pass


################################################################################
#    def forecast(self, noutput_items, ninput_items_required):
#        #setup size of input_items[i] for work call
#        for i in range(len(ninput_items_required)):
#            ninput_items_required[i] = noutput_items


################################################################################
    def work(self, input_items, output_items):
#        g = open('./work.txt', 'ab')
#        g.write("FrameSource start\n")
#        g.close

#Profiling begin
#        self.MyProfiler2.stop_timer()
#        self.MyProfiler.start_timer()
#Profiling end

        N = min( len(output_items[0]), len(output_items[1]), 1024 )

 #       f = open('./frame_source.txt', 'ab')
 #       f.write("%d "%(N))
 #       f.close()


        if N == 0 :
#            g = open('./work.txt', 'ab')
#            g.write("FrameSource stop\n")
#            g.close
            print 'FrameSource error: No space in output buffers!'
            return 0

        noutput_items = 0


        while 1 :
            # 1. Some minor pre-processing steps

            g = open('./FSS_debug.txt', 'ab')
            g.write("N: %d, N - noutput_items: %d, self.dfe.byte_buff_len: %d\n"%(N, N - noutput_items, self.dfe.byte_buff_len))
            g.close()

#            self.processed_bytes, self.int_buff, self.frame_starts, self.frame_cnt = self.eNs16b.Process( self.dfe.byte_buff, self.dfe.byte_buff_len, self.dfe.frame_starts, self.dfe.frame_cnt, N - noutput_items ) 

#            byte_buff2 = self.dfe.byte_buff
            byte_buff_len2 = self.dfe.byte_buff_len
            frame_starts2 = self.dfe.frame_starts
            frame_cnt2 = self.dfe.frame_cnt
            N2 = N - noutput_items

            channels = 2
            res = 2


#            byte_buff2 = byte_buff2.view(np.uint8)

#            byte_buff_len2 = min( byte_buff_len2, byte_buff2.size )

            nominal_len = N2 * channels * res

            g = open('FSS_debug.txt', 'ab')
            g.write('Extract: N: %d, byte_buff_len: %d, nominal_len: %d\n'%(N2, byte_buff_len2, nominal_len))

            if nominal_len > 0 :
                byte_buff_len2 = min( byte_buff_len2, nominal_len )

#            buff_len2 = byte_buff_len2 - byte_buff_len2 % (channels * res)
            buff_len2 = ( byte_buff_len2 / (channels * res) ) * (channels * res)

            g.write('Extract: byte_buff_len: %d, buff_len: %d\n'%(byte_buff_len2, buff_len2))
            g.close()

            g = open('FSS_copy2.bin', 'ab')
#            byte_buff2[:buff_len2].tofile(g)
            self.dfe.byte_buff[:buff_len2].tofile(g)
            g.close()

#            int_buff = byte_buff2[:buff_len2].view( dtype=np.int16 ).newbyteorder()
            self.int_buff = self.dfe.byte_buff[:buff_len2].view( dtype=np.int16 ).newbyteorder()


            frame_starts_out2 = []
            frame_cnt_out2 = []
            ii = 0
            while ii < len(frame_starts2) and frame_starts2[ii] < buff_len2 :
                frame_starts_out2.append( frame_starts2[ii]/res )
                frame_cnt_out2.append( frame_cnt2[ii] )

                ii += 1

            self.processed_bytes = buff_len2
#            self.int_buff = int_buff
            self.frame_starts = frame_starts_out2
            self.frame_cnt = frame_cnt_out2


            g = open('./FSS_debug.txt', 'ab')
            self.total_processed_bytes3 += self.processed_bytes
            g.write("self.processed_bytes: %d, total: %d\n"%(self.processed_bytes, self.total_processed_bytes3))
            g.close()

            g = open('./FS_copy3.bin', 'ab')
            self.dfe.byte_buff[:self.processed_bytes].tofile(g)
            g.close()

            if self.int_buff.size :
                output_items[0][noutput_items : noutput_items + self.int_buff.size/2] = self.int_buff[0::2]
                output_items[1][noutput_items : noutput_items + self.int_buff.size/2] = self.int_buff[1::2]

                for ii in xrange(len(self.frame_starts)) :
                    offset0 = self.nitems_written(0) + noutput_items + self.frame_starts[ii]/2
                    offset1 = self.nitems_written(1) + noutput_items + self.frame_starts[ii]/2
                    key = pmt.pmt_string_to_symbol( "Frame counter" )
                    value = pmt.pmt_string_to_symbol( "%d"%self.frame_cnt[ii] )

                    self.add_item_tag(0, offset0, key, value)
                    self.add_item_tag(1, offset1, key, value)

                noutput_items += self.int_buff.size/2


                g = open('./FS_copy4.bin', 'ab')
                self.int_buff.tofile(g)
                g.close()

            g = open('./FSS_debug.txt', 'ab')
            g.write("noutput_items: %d\n"%(noutput_items))
            g.close()

            g = open('./FS_copy5.bin', 'ab')
            self.dfe.byte_buff[:self.processed_bytes].tofile(g)
            g.close()

#            self.dfe.ClearFromBeginning( self.processed_bytes ) # Clear any previous data, that was already processed
            self.dfe.byte_buff[:self.dfe.byte_buff_len-self.processed_bytes] = self.dfe.byte_buff[self.processed_bytes:self.dfe.byte_buff_len]
            self.dfe.byte_buff_len -= self.processed_bytes

            g = open('./FSS_debug.txt', 'ab')
            g.write("self.dfe.byte_buff_len: %d\n"%(self.dfe.byte_buff_len))
            g.close()

            # If we have enough data
            if noutput_items >= N :
                g = open('./FSS_debug.txt', 'ab')
                g.write("noutput_items >= N\n\n\n\n\n")
                g.close()
                break

            # Not enough but there's not gonna be any new
            if self.s.SourceEmpty() :
                g = open('./FSS_debug.txt', 'ab')
                g.write("self.s.SourceEmpty()\n\n\n\n\n")
                g.close()
                break

              
            # 2. Get some brand new, raw data
            accum, accum_length = self.s.GetBuffer(10000)

            g = open('./FSS_debug.txt', 'ab')
            self.total_processed_bytes += accum_length
            g.write("\n\nREADING NEW DATA\n\naccum_length: %d, total: %d\n"%(accum_length, self.total_processed_bytes))
            g.close()

            
#Profiling begin
#            self.MyProfiler5.start_timer()
#Profiling end


            g = open('./FSS_debug.txt', 'ab')
            if self.dfe.byte_buff_len :
                g.write("\n\nDFE BUFF NOT EMPTY\n\n")
            g.close()

            # 3. Find data frames (if any) in data
            proc_bytes = self.dfe.ExtractDataFrames(accum, accum_length)

            g = open('./FS_copy.bin', 'ab')
            accum[:proc_bytes].tofile(g)
            g.close()

            g = open('./FSS_debug.txt', 'ab')
            self.total_processed_bytes2 += proc_bytes
            g.write("proc_bytes: %d, total: %d\n"%(proc_bytes, self.total_processed_bytes2))
            g.close()


            self.s.ClearFromBeginning(proc_bytes) 

            g = open('./FS_copy2.bin', 'ab')
            self.dfe.byte_buff[:self.dfe.byte_buff_len].tofile(g)
            g.close()



#Profiling begin
#            self.MyProfiler5.stop_timer()
#Profiling end
            

#        f = open('./frame_source.txt', 'ab')
#        f.write("%d %d\n"%(len(output_items[0]), self.int_buff.size))
#        f.close()

#Profiling begin
#        current_time = ttt.time()
#        if current_time - self.previous_time > 3 :
#            print 'FrameSource average processing time: %.3f ms' % ( self.MyProfiler.get_result() * 1e3 )
#            print 'FrameSource average waiting time: %.3f ms' % ( self.MyProfiler2.get_result() * 1e3 )
#            print 'FrameSource average dfe time: %.3f ms' % ( self.MyProfiler5.get_result() * 1e3  )

#            self.previous_time = current_time

#        self.MyProfiler.stop_timer()
#        self.MyProfiler2.start_timer()
#Profiling end

#        self.cum += self.int_buff.size
#        g = open('./work.txt', 'ab')
#        g.write("FrameSource stop, out: %d, total: %d\n"%(self.int_buff.size, self.cum))
#        g.close

        #return produced
        if noutput_items == 0 and self.s.SourceEmpty() :
            print 'Source empty.'
            return -1
        else :
            return noutput_items
