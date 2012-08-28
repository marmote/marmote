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
    def Full_scale(self, Resolution = None):
        if Resolution is None:
            Resolution = self.Resolution

        return 2**(Resolution - 1)

    def num_pos_fr(self, N = None):
        if N is None:
            N = self.N

        return N/2+1               #positive and zero frequency bins

    def num_neg_fr(self, N = None):
        if N is None:
            N = self.N

        return N - self.num_pos_fr(N) #negative frequency bins


