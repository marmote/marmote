import numpy as np


################################################################################
class FramePreProcessor:
    
################################################################################
    def __init__(self, N = 600, channels = 2, mf_hist_len = 100):

        self.N                  = N
        self.channels           = channels
        self.mf_hist_len        = mf_hist_len

        self.frame_cnt_history  = np.array([], dtype=np.uint32)


################################################################################
    def Process(self, byte_buff, byte_buff_len, frame_starts, frame_cnt):

    ########################################
    # Set variables    
        byte_buff   = byte_buff.view(np.uint8)

        nominal_len = self.N * self.channels * 2

        if byte_buff_len < self.N * self.channels * 2 :
            byte_buff_len = 0
        else :
            byte_buff_len = nominal_len


        buff_len = byte_buff_len - byte_buff_len % 4
        int_buff = byte_buff[:buff_len].view( dtype=np.int16 )

        frame_starts_out = []
        ii = 0
        while ii < len(frame_starts) and frame_starts[ii] < buff_len :
            frame_starts_out.append( frame_starts[ii]/2 )
            self.frame_cnt_history = np.append( self.frame_cnt_history, frame_cnt[ii] )
            ii += 1


        while self.frame_cnt_history.size > self.mf_hist_len + 1:
            self.frame_cnt_history = self.frame_cnt_history[1:]


        return buff_len, int_buff, frame_starts_out, self.frame_cnt_history[1:] - self.frame_cnt_history[:-1] - 1



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
#    (frame_FIFO, frame_cnt_FIFO, frame_cnt_history, frame_starts, missing_frames) = Processing(frame_FIFO, frame_cnt_FIFO, frame_cnt_history, DSPconf)
 
