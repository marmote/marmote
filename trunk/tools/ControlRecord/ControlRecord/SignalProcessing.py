import numpy as np



################################################################################
def SignalProcessing(buff, DSPconf):

########################################
# Set variables
    buff        = buff.view(np.int16)
    
    channels    = int(DSPconf.channels)
    N           = int(buff.size/channels)
    Full_scale  = int(DSPconf.Full_scale())
#    num_pos_fr  = int(DSPconf.num_pos_fr())
#    num_neg_fr  = int(DSPconf.num_neg_fr())


########################################
# Signal processing

    I_buff = np.array([], dtype=np.int16)
    Q_buff = np.array([], dtype=np.int16)
    I_spectrum = np.array([], dtype=np.complex128)
    Q_spectrum = np.array([], dtype=np.complex128)
#    spectrum = np.array([], dtype=np.complex128)

    if buff.size == 0 :
         return I_buff, Q_buff, I_spectrum, Q_spectrum, #spectrum

# Do actual signal processing on display buffer   
    I_buff = buff[::2].newbyteorder()
    Q_buff = buff[1::2].newbyteorder()

    I_buff = I_buff.astype(float)
    Q_buff = Q_buff.astype(float)

    I_buff = I_buff/Full_scale + 0.103
    Q_buff = Q_buff/Full_scale + 0.1265

    I_spectrum = 2*abs(np.fft.rfft(I_buff))
    Q_spectrum = 2*abs(np.fft.rfft(Q_buff))
#    spectrum = 2*abs(np.fft.fft(I_buff + 1j * Q_buff))
#    spectrum = np.concatenate((spectrum[num_pos_fr:], spectrum[:num_pos_fr]))
    
    I_spectrum = I_spectrum / N
    Q_spectrum = Q_spectrum / N
#    spectrum = spectrum / N

    I_spectrum = 20 * np.log10(I_spectrum)
    Q_spectrum = 20 * np.log10(Q_spectrum)
#    spectrum = 20 * np.log10(spectrum)


    return I_buff, Q_buff, I_spectrum, Q_spectrum, #spectrum
