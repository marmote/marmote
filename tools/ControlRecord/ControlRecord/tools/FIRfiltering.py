import numpy as np
import scipy.signal as sci_sig


################################################################################
class FIRfilter :

################################################################################
    def __init__(self, Fs_Hz, tran_width_Hz, cut_off_Hz, att_dB=80.0):
        self.CreateFilter(Fs_Hz, tran_width_Hz, cut_off_Hz, att_dB)

        self.buff = np.zeros(1)


################################################################################
    def Process(self, x) :
        # Check to see if the buffer is large enough, if not increase size
        worst_case_size = x.size + self.taps.size - 1
        size_diff = worst_case_size - self.buff.size
        if size_diff > 0:
            self.buff = np.append( self.buff, np.zeros(size_diff) )
        elif  size_diff < 0:
            self.buff = self.buff[-worst_case_size:]

        self.buff = np.roll(self.buff, -x.size)

        self.buff[-x.size:] = x

        return sci_sig.convolve(self.buff, self.taps, mode='valid')


################################################################################
    def CreateFilter(self, Fs_Hz, tran_width_Hz, cut_off_Hz, att_dB=80.0) :
        # The Nyquist rate of the signal.
        nyq_rate = Fs_Hz / 2.0

        # The desired width of the transition from pass to stop,
        # relative to the Nyquist rate.  
        width = tran_width_Hz/nyq_rate
 
        # Compute the order and Kaiser parameter for the FIR filter.
        N, beta = sci_sig.kaiserord(att_dB, width)
 
        # Use firwin with a Kaiser window to create a lowpass FIR filter.
        self.taps = sci_sig.firwin(N, cut_off_Hz/nyq_rate, window=('kaiser', beta), pass_zero=False)
