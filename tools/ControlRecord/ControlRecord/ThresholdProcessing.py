import numpy as np


################################################################################
class ThresholdFilter:

################################################################################
    def __init__(self, DSPconf):
        self.TH_level = 0.2 * DSPconf.Full_scale()
        self.rec_frame_num = 10
        self.TH_cnt = 0


################################################################################
    def ThresholdProcessing(self, frame_FIFO, frame_cnt_FIFO, frame_FIFO_out, frame_cnt_FIFO_out):

    ########################################
    # Set variables    
#        frame_cnt_FIFO      = frame_cnt_FIFO.view(np.uint32)


    ########################################
    # Signal processing
#        frame_FIFO_out = []
#        frame_cnt_FIFO_out = np.array([], dtype=np.uint32)

        while len(frame_FIFO) :

            buff = frame_FIFO[0].view(dtype=np.int16).newbyteorder('B')

            if np.abs(buff).max() >= self.TH_level :
                self.TH_cnt = self.rec_frame_num

            if self.TH_cnt > 0 :
                frame_FIFO_out.append(frame_FIFO[0])
                frame_cnt_FIFO_out = np.append(frame_cnt_FIFO_out, frame_cnt_FIFO[0])

                self.TH_cnt -= 1

            frame_FIFO = frame_FIFO[1:]
            frame_cnt_FIFO = frame_cnt_FIFO[1:]

        return frame_FIFO, frame_cnt_FIFO, frame_FIFO_out, frame_cnt_FIFO_out


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
 
