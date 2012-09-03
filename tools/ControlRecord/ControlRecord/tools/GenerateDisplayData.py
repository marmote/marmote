import GenerateData as GD
import SignalProcessing as SP


################################################################################
class DisplayDataGenerator(GD.DataGenerator):

################################################################################
    def __init__(self, FileOrDir, DSPconf, N, mf_hist_len = 100):
        GD.DataGenerator.__init__(self, FileOrDir, DSPconf, N, mf_hist_len)

        self.DSPconf = DSPconf
        

################################################################################
    def data_gen(self):
        DSPconf = self.DSPconf

        while True :
            self.GetPreProcessedBuff()
    
            if self.int_buff.size == 0 :
                break

            frame_starts, I_buff, Q_buff, I_spectrum, Q_spectrum, = SP.SignalProcessing( self.frame_starts, self.int_buff, DSPconf )  # Assumes 2 channels !!!

            yield frame_starts, self.missing_frames, I_buff, Q_buff, I_spectrum, Q_spectrum 

