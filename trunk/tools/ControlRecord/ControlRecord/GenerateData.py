import numpy as np
import FileSource as FS
import ExtractFrames as EF
import FramePreProcessing as FPP

import ThresholdProcessing as TP
import SignalProcessing as SP


################################################################################
class DisplayDataGenerator:

################################################################################
    def __init__(self, FileOrDir, N, DSPconf, mf_hist_len = 100):
        self.DSPconf = DSPconf
        
        channels    = DSPconf.channels
        res         = DSPconf.Resolution / 8


        ##########

        self.s      = FS.FileSource(FileOrDir)
        self.dfe    = EF.DataFrameExtractor(N * channels * res)
        self.fpp    = FPP.FramePreProcessor(N, channels, mf_hist_len)


        ##########

        self.accum = np.array([], dtype=np.uint8)
        self.processed_bytes2 = 0


################################################################################
    def __del__( self ) :
        pass

################################################################################
    def GetFrames(self):
#        DSPconf = self.DSPconf

        while not self.s.SourceEmpty() :
            # 1. Get some brand new, raw data
            temp = self.s.GetBuffer()
    
            if temp.size == 0 :
                continue

            self.accum = np.append( self.accum, temp )
    

            # 2. Find data frames (if any) in data
            self.dfe.ClearFromBeginning( self.processed_bytes2 ) # Clear any previous data, that was already processed
            ( processed_bytes1 ) = self.dfe.ExtractDataFrames(self.accum)

            self.accum = self.accum[processed_bytes1:]
    
            # 3. Some minor processing steps before actual signal processing
            ( self.processed_bytes2, self.int_buff, self.frame_starts, self.missing_frames ) = self.fpp.Process( self.dfe.byte_buff, self.dfe.byte_buff_len, self.dfe.frame_starts, self.dfe.frame_cnt ) 

            if self.int_buff.size == 0 :
                continue

            break
    

################################################################################
    def data_gen(self):
        DSPconf = self.DSPconf

        while not self.s.SourceEmpty() :
            self.GetFrames()
    
            if self.int_buff.size == 0 :
                continue

            ( I_buff, Q_buff, I_spectrum, Q_spectrum, ) = SP.SignalProcessing( self.int_buff, DSPconf )

            yield self.missing_frames, self.frame_starts, self.missing_frames, I_buff, Q_buff, I_spectrum, Q_spectrum, 


