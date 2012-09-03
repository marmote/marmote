import numpy as np


################################################################################
class FrameBuffer:

################################################################################
    def __init__(self):
        self.frame_starts = []
        self.frame_cnt = np.array([], dtype=np.uint32)

        # "allocate memory" for buffer
        self.byte_buff = np.zeros(100, dtype=np.uint8) 

        # indicates the number of valid bytes in buffer
        self.byte_buff_len = 0

		
################################################################################
    def IncreaseBufferSize(self, buff_len = 100) :
        self.byte_buff = np.append( self.byte_buff, np.ones(buff_len, dtype=np.uint8) )


################################################################################
    def ClearFromBeginning(self, buff_len) :

        buff_len = min( buff_len, self.byte_buff_len )

        while len(self.frame_starts) > 0 and self.frame_starts[0] < buff_len :
            self.frame_starts = self.frame_starts[1:]
            self.frame_cnt = self.frame_cnt[1:]

        for ii in xrange(len(self.frame_starts)) :
            self.frame_starts[ii] -= buff_len

        self.byte_buff[:self.byte_buff_len-buff_len] = self.byte_buff[buff_len:self.byte_buff_len]
        self.byte_buff_len -= buff_len