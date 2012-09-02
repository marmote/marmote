import numpy as np
import FileSource as FS
import ExtractFrames as EF
import FramePreProcessing as FPP

import ThresholdProcessing as TP
import SignalProcessing as SP


################################################################################
class DisplayDataGenerator:

################################################################################
    def __init__(self, FileOrDir, DSPconf, N, mf_hist_len = 100):
        self.DSPconf = DSPconf
        
        self.N      = N
        channels    = DSPconf.channels
        res         = DSPconf.Resolution / 8


        ##########

        self.s      = FS.FileSource(FileOrDir)
        self.dfe    = EF.DataFrameExtractor()
        self.fpp    = FPP.FramePreProcessor(channels, mf_hist_len) # Assumes a resolution of 2 bytes !!!


        ##########

        self.processed_bytes = 0


################################################################################
    def __del__( self ) :
        pass

################################################################################
    def GetPreProcessedBuff(self):

        while True :
            if self.N > 0 or self.s.SourceEmpty() :

                # 1. Some minor pre-processing steps
                self.dfe.ClearFromBeginning( self.processed_bytes ) # Clear any previous data, that was already processed
                self.processed_bytes, self.int_buff, self.frame_starts, self.missing_frames = self.fpp.Process( self.dfe.byte_buff, self.dfe.byte_buff_len, self.dfe.frame_starts, self.dfe.frame_cnt, self.N ) 

                if self.s.SourceEmpty() or self.int_buff.size > 0 :
                    break

            # 2. Get some brand new, raw data
            temp = self.s.GetBuffer()

            # 3. Find data frames (if any) in data
            self.dfe.ExtractDataFrames(temp)
                           

################################################################################
    def data_gen(self):
        DSPconf = self.DSPconf

        while True :
            self.GetPreProcessedBuff()
    
            if self.int_buff.size == 0 :
                break

            frame_starts, I_buff, Q_buff, I_spectrum, Q_spectrum, = SP.SignalProcessing( self.frame_starts, self.int_buff, DSPconf )  # Assumes 2 channels !!!

            yield frame_starts, self.missing_frames, I_buff, Q_buff, I_spectrum, Q_spectrum 

