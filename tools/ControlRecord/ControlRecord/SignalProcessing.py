import numpy as np



################################################################################
def SignalProcessing(buff, DSPconf):

########################################
# Set variables
    buff        = buff.view(np.int16)
    
    channels    = int(DSPconf.channels)
    N           = int(buff.size/channels)
    Full_scale  = int(DSPconf.Full_scale())
    num_pos_fr  = int(DSPconf.num_pos_fr())
    num_neg_fr  = int(DSPconf.num_neg_fr())


########################################
# Signal processing

    I_buff = np.array([], dtype=np.int16)
    Q_buff = np.array([], dtype=np.int16)
    spectrum = np.array([], dtype=np.complex128)
    I_spectrum = np.array([], dtype=np.complex128)
    Q_spectrum = np.array([], dtype=np.complex128)

    if buff.size == 0 :
         return I_buff, Q_buff, spectrum, I_spectrum, Q_spectrum

# Do actual signal processing on display buffer   
    I_buff = buff[::2]
    Q_buff = buff[1::2]

    I_buff = I_buff.astype(float)
    Q_buff = Q_buff.astype(float)

    I_buff = I_buff/Full_scale + 0.103
    Q_buff = Q_buff/Full_scale + 0.1265

    spectrum = 2*abs(np.fft.fft(I_buff + 1j * Q_buff))
    I_spectrum = 2*abs(np.fft.rfft(I_buff))
    Q_spectrum = 2*abs(np.fft.rfft(Q_buff))

    spectrum = np.concatenate((spectrum[num_pos_fr:], spectrum[:num_pos_fr]))
    
    spectrum = spectrum / N
    I_spectrum = I_spectrum / N
    Q_spectrum = Q_spectrum / N

    spectrum = 20 * np.log10(spectrum)
    I_spectrum = 20 * np.log10(I_spectrum)
    Q_spectrum = 20 * np.log10(Q_spectrum)


    return I_buff, Q_buff, spectrum, I_spectrum, Q_spectrum



################################################################################
#if __name__ == "__main__":
#
#    class DSPconf_t:
#        def __init__(self):
#            self.channels    = 2
#            self.N           = 10
#            self.Full_scale  = 2**(16 - 1)
#
#
#    DSPconf = DSPconf_t()
#
#    frame1 = np.array([1, 0, 2, 0, 3, 0, 4, 0], dtype=np.int16)
#    frame2 = np.array([5, 0, 6, 0, 7, 0, 8, 0], dtype=np.int16)
#    frame3 = np.array([9, 0, 10, 0, 11, 0, 12, 0], dtype=np.int16)
#    frame4 = np.array([13, 0, 14, 0, 15, 0, 16, 0], dtype=np.int16)
#    frame5 = np.array([17, 0, 18, 0, 19, 0, 20, 0], dtype=np.int16)
#    frame6 = np.array([21, 0, 22, 0, 23, 0, 24, 0], dtype=np.int16)
#
#    frame_FIFO = [frame1, frame2, frame3, frame4, frame5, frame6]
#
#    frame_cnt_FIFO = np.array([100, 101, 102, 103, 106, 107], dtype=np.uint32)
#
#    frame_cnt_history = np.array(range(100), dtype=np.uint32)
#
#
#    (frame_FIFO, frame_cnt_FIFO, frame_cnt_history, frame_starts, missing_frames, I_buff, Q_buff, spectrum, I_spectrum, Q_spectrum) = Processing(frame_FIFO, frame_cnt_FIFO, frame_cnt_history, DSPconf)
