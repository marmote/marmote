#import FileSource as FS
import ExtractFrames as EF
import FramePreProcessing as FPP
import ThresholdProcessing as TP
import FrameConfig as FC


################################################################################
class DataGenerator:

################################################################################
    def __init__(self, Source, DSPconf, N, mf_hist_len = 100):
        FrameConf = FC.Frameconf_t()

        self.N      = N
        channels    = DSPconf.channels

        ##########

#        self.s      = FS.FileSource(FileOrDir)
        self.s      = Source
        self.dfe    = EF.DataFrameExtractor(FrameConf.START_OF_FRAME, FrameConf.DATA_FRAME_ID)
        self.fpp    = FPP.FramePreProcessor(channels, mf_hist_len) # Assumes a resolution of 2 bytes !!!

        self.tf     = TP.ThresholdFilter(0.15 * DSPconf.Full_scale())

        ##########

        self.processed_bytes = 0


################################################################################
    def __del__( self ) :
        pass


################################################################################
    def GetPreProcessedBuff(self):

        while 1 :
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
    def GetPreProcessedBuff_th(self):

        while 1 :
            # 1. Let's see if we have enough filtered bytes to display
            if self.N > 0 or self.s.SourceEmpty() :

                self.tf.ClearFromBeginning( self.processed_bytes ) # Clear any previous data, that was already processed
                self.processed_bytes, self.int_buff, self.frame_starts, self.missing_frames = self.fpp.Process( self.tf.byte_buff, self.tf.byte_buff_len, self.tf.frame_starts, self.tf.frame_cnt, self.N ) 

                if self.s.SourceEmpty() or self.int_buff.size > 0 :
                    break

            self.GetTHFilteredData()


################################################################################
    def GetTHFilteredData(self, stop_after_each = False) :
                    
        while 1 :
            # 3. Filter data frames
            prev_size = self.tf.byte_buff_len                
                
            process_fragments = self.s.SourceEmpty()
            processed_bytes2 = self.tf.Process( self.dfe.byte_buff, self.dfe.byte_buff_len, self.dfe.frame_starts, self.dfe.frame_cnt, process_fragments, stop_after_each ) 
            self.dfe.ClearFromBeginning( processed_bytes2 ) # Clear any previous data, that was already processed


            #Question: Do we return with the data we have at this point, or do we read more?
            if self.s.SourceEmpty() :
                break

            if self.tf.byte_buff_len > prev_size :
                if not stop_after_each :
                    break

                if self.tf.TH_cnt == 0 :
                    break

            # 1. Get some brand new, raw data
            temp = self.s.GetBuffer()

            # 2. Find data frames (if any) in data
            self.dfe.ExtractDataFrames(temp)                        
