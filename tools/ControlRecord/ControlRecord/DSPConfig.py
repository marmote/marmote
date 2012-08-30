import numpy as np

class DSPconf_t:
    def __init__(self):
        self.Fs          = 24e6 / 32.    # [Hz] = 750 kHz
        self.F_offset    = 0.            # [Hz]
        self.Resolution  = 16

        self.channels    = 2


########################################
# Calculated variables
    def Full_scale(self, Resolution = None):
        if Resolution is None:
            Resolution = self.Resolution

        return 2**(Resolution - 1)


    def Full_scale_dB(self, Resolution = None):
        if Resolution is None:
            Resolution = self.Resolution

        return 20 * np.log10(2*float(self.Full_scale()))
    

    def num_pos_fr(self, N = None):
        if N is None:
            return None

        #positive and zero frequency bins
        return N/2+1               


    def num_neg_fr(self, N = None):
        if N is None:
            return None

        #negative frequency bins
        return N - self.num_pos_fr(N) 


