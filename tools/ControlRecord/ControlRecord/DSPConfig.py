import numpy as np

class DSPconf_t:
    def __init__(self):
        self.START_OF_FRAME = np.array([0xA1, 0xBE, 0xAF, 0x01], dtype = np.uint8)

        self.N           = 400

        self.Fs          = 24e6 / 32.    # [Hz] = 750 kHz
        self.F_offset    = 0.            # [Hz]
        self.Resolution  = 16

        self.channels    = 2

        self.MF_hist_len = 100


########################################
# Calculated variables
        self.Full_scale  = 2**(self.Resolution - 1)
        self.num_pos_fr  = self.N/2+1               #positive and zero frequency bins
        self.num_neg_fr  = self.N - self.num_pos_fr #negative frequency bins    

