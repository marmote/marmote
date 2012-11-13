import numpy as np
import FIRfiltering as FF


################################################################################
class SignalProcessingChain :

################################################################################
    def __init__(self, DSPconf, filtering=False):
        Fs              = DSPconf.Fs
        self.channels   = int(DSPconf.channels)
        self.Full_scale = int(DSPconf.Full_scale())

        tran_width_Hz   = 100e3
        cut_off_Hz      = 100e3
        att_dB          = 30

        if filtering :
            self.I_HPF = FF.FIRfilter(Fs, tran_width_Hz, cut_off_Hz, att_dB)
            self.Q_HPF = FF.FIRfilter(Fs, tran_width_Hz, cut_off_Hz, att_dB)
        else :
            self.I_HPF = None
            self.Q_HPF = None


################################################################################
    def SignalProcessing(self, frame_starts, buff, RF=False):

    ########################################
    # Set variables
        buff        = buff.view(np.int16)

        N           = int(buff.size/self.channels)


    ########################################
    # Signal processing

        for ii in xrange(len(frame_starts)) :
            frame_starts[ii] /= self.channels

        I_buff = np.array([], dtype=np.int16)
        Q_buff = np.array([], dtype=np.int16)
        I_spectrum = np.array([], dtype=np.complex128)
        Q_spectrum = np.array([], dtype=np.complex128)
        spectrum = np.array([], dtype=np.complex128)

        if buff.size == 0 :
            return frame_starts, I_buff, Q_buff, I_spectrum, Q_spectrum, spectrum

    # Do actual signal processing on display buffer   
        I_buff = buff[::2].newbyteorder()
        Q_buff = buff[1::2].newbyteorder()

        I_buff = I_buff.astype(float)
        Q_buff = Q_buff.astype(float)

        I_buff = I_buff/self.Full_scale + 0.001 #+ 0.103
        Q_buff = Q_buff/self.Full_scale + 0.026 #+ 0.1265

        if self.I_HPF is not None:
            I_buff = self.I_HPF.Process(I_buff)
            Q_buff = self.Q_HPF.Process(Q_buff)

        I_spectrum = 2*abs(np.fft.rfft(I_buff))
        Q_spectrum = 2*abs(np.fft.rfft(Q_buff))
    
        I_spectrum = I_spectrum / N
        Q_spectrum = Q_spectrum / N

        I_spectrum = 20 * np.log10(I_spectrum)
        Q_spectrum = 20 * np.log10(Q_spectrum)

        if RF:
            num_pos_fr  = int(DSPconf.num_pos_fr(N))
            num_neg_fr  = int(DSPconf.num_neg_fr(N))
            spectrum = 2*abs(np.fft.fft(I_buff + 1j * Q_buff))
            spectrum = np.concatenate((spectrum[num_pos_fr:], spectrum[:num_pos_fr]))
            spectrum = spectrum / N
            spectrum = 20 * np.log10(spectrum)

        return frame_starts, I_buff, Q_buff, I_spectrum, Q_spectrum, spectrum
