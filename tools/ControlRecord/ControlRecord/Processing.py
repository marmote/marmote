import numpy as np



################################################################################
def Processing(frame_FIFO, frame_cnt_FIFO, frame_cnt_history, DSPconf):

########################################
# Set variables    
    frame_cnt_FIFO      = frame_cnt_FIFO.view(np.uint32)
    frame_cnt_history   = frame_cnt_history.view(np.uint32)

    channels    = int(DSPconf.channels)
    N           = int(DSPconf.N)
    Full_scale  = int(DSPconf.Full_scale)
    MF_hist_len = int(DSPconf.MF_hist_len)
    num_pos_fr  = int(DSPconf.num_pos_fr)
    num_neg_fr  = int(DSPconf.num_neg_fr)


########################################
# Signal processing

    frame_starts = []
    missing_frames = np.array([], dtype=np.uint32)
    I_buff = np.array([], dtype=np.int16)
    Q_buff = np.array([], dtype=np.int16)
    spectrum = np.array([], dtype=np.complex128)
    I_spectrum = np.array([], dtype=np.complex128)
    Q_spectrum = np.array([], dtype=np.complex128)


# Take all the frames, and put them in one display buffer

    # Do we have enough samples to fill up the display buffer?
    combined_length = 0
    for ii in range(len(frame_FIFO)):
        combined_length += frame_FIFO[ii].size

    if combined_length/channels < N :
        return frame_FIFO, frame_cnt_FIFO, frame_cnt_history, frame_starts, missing_frames, I_buff, Q_buff, spectrum, I_spectrum, Q_spectrum


    buff = np.array([], dtype=np.int16)


    while buff.size/channels < N :
        # If this is the first time we encountered this frame we 
        # 1. copy the frame counter to the history 
        # 2. save the starting index 
        # 3. calculate the missing frames
        if (frame_cnt_history.size == 0) or (frame_cnt_history[-1] != frame_cnt_FIFO[0]) :
            frame_starts.append(buff.size/channels)

            if frame_cnt_history.size == 0 :
                missing_frames = np.append(missing_frames, 0)
            else :
                missing_frames = np.append(missing_frames, frame_cnt_FIFO[0] - frame_cnt_history[-1] - 1 )

            frame_cnt_history = np.append( frame_cnt_history, frame_cnt_FIFO[0] )
            while frame_cnt_history.size > MF_hist_len+1 :
                frame_cnt_history = frame_cnt_history[1:]

        # Copy samples from frame to display buffer
        frame = frame_FIFO[0]

        copy_length = min( N*channels - buff.size, frame.size )

        buff = np.append(buff, frame[:copy_length])

        if copy_length == frame.size :
            frame_FIFO = frame_FIFO[1:]
            frame_cnt_FIFO = frame_cnt_FIFO[1:]
        else :
            frame_FIFO[0] = frame_FIFO[0][copy_length:]


# Do actual signal processing on display buffer   
    I_buff = buff[::2]
    Q_buff = buff[1::2]

    I_buff = I_buff.astype(float)
    Q_buff = Q_buff.astype(float)

    I_buff = I_buff/Full_scale
    Q_buff = Q_buff/Full_scale

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


    return frame_FIFO, frame_cnt_FIFO, frame_cnt_history, frame_starts, missing_frames, I_buff, Q_buff, spectrum, I_spectrum, Q_spectrum



################################################################################
if __name__ == "__main__":

    class DSPconf_t:
        def __init__(self):
            self.channels    = 2
            self.N           = 10
            self.Full_scale  = 2**(16 - 1)


    DSPconf = DSPconf_t()

    frame1 = np.array([1, 0, 2, 0, 3, 0, 4, 0], dtype=np.int16)
    frame2 = np.array([5, 0, 6, 0, 7, 0, 8, 0], dtype=np.int16)
    frame3 = np.array([9, 0, 10, 0, 11, 0, 12, 0], dtype=np.int16)
    frame4 = np.array([13, 0, 14, 0, 15, 0, 16, 0], dtype=np.int16)
    frame5 = np.array([17, 0, 18, 0, 19, 0, 20, 0], dtype=np.int16)
    frame6 = np.array([21, 0, 22, 0, 23, 0, 24, 0], dtype=np.int16)

    frame_FIFO = [frame1, frame2, frame3, frame4, frame5, frame6]

    frame_cnt_FIFO = np.array([100, 101, 102, 103, 106, 107], dtype=np.uint32)

    frame_cnt_history = np.array(range(100), dtype=np.uint32)


    (frame_FIFO, frame_cnt_FIFO, frame_cnt_history, frame_starts, missing_frames, I_buff, Q_buff, spectrum, I_spectrum, Q_spectrum) = Processing(frame_FIFO, frame_cnt_FIFO, frame_cnt_history, DSPconf)
   
#    for ii in range(len(frames)):
#        print frames[ii]

#    print frame_cnt

#    print buff 
