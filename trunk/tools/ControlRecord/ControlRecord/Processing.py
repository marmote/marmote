import numpy as np



################################################################################
def Processing(frame_FIFO, frame_cnt_FIFO, frame_cnt_history, DSPconf):

########################################
# Set variables    
    frame_cnt_FIFO      = frame_cnt_FIFO.view(np.uint32)
    frame_cnt_history   = frame_cnt_history.view(np.uint32)

    channels    = int(DSPconf.channels)
    N           = int(DSPconf.N)
    Full_scale  = int(DSPconf.Full_scale())
    MF_hist_len = int(DSPconf.MF_hist_len)
    num_pos_fr  = int(DSPconf.num_pos_fr())
    num_neg_fr  = int(DSPconf.num_neg_fr())


########################################
# Signal processing
    buff = np.array([], dtype=np.int16)

    frame_starts = []
    missing_frames = np.array([], dtype=np.uint32)

# Take all the frames, and put them in one display buffer
    if len(frame_FIFO) == 0 :
        return frame_FIFO, frame_cnt_FIFO, frame_cnt_history, frame_starts, missing_frames, buff

#    if N == 0:
#        N = frame_FIFO[0].size/channels
#    else:
#        # Do we have enough samples to fill up the display buffer?
#        combined_length = 0
#        for ii in range(len(frame_FIFO)):
#            combined_length += frame_FIFO[ii].size
#
#        if combined_length/channels < N :
#            return frame_FIFO, frame_cnt_FIFO, frame_cnt_history, frame_starts, missing_frames, buff


    # Do we have enough samples to fill up the display buffer?
    combined_length = 0
    for ii in range(len(frame_FIFO)):
        combined_length += frame_FIFO[ii].size


    if N == 0:
        N = combined_length/channels

    if combined_length/channels < N :
        return frame_FIFO, frame_cnt_FIFO, frame_cnt_history, frame_starts, missing_frames, buff


########################################

    buff = np.array([], dtype=np.int16)


    while buff.size/channels < N :
        # If this is the first time we encountered this frame we 
        if (frame_cnt_history.size == 0) or (frame_cnt_history[-1] != frame_cnt_FIFO[0]) :
            # -> save the starting index 
            frame_starts.append(buff.size/channels)

            # -> calculate the missing frames
            if frame_cnt_history.size == 0 :
                missing_frames = np.append(missing_frames, 0)
            else :
                missing_frames = np.append(missing_frames, frame_cnt_FIFO[0] - frame_cnt_history[-1] - 1 )

            # -> copy the frame counter to the history 
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

    return frame_FIFO, frame_cnt_FIFO, frame_cnt_history, frame_starts, missing_frames, buff



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


    (frame_FIFO, frame_cnt_FIFO, frame_cnt_history, frame_starts, missing_frames) = Processing(frame_FIFO, frame_cnt_FIFO, frame_cnt_history, DSPconf)
 
