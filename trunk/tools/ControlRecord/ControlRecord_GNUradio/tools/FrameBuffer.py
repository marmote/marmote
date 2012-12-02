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
        self.byte_buff = np.append( self.byte_buff, np.zeros(buff_len, dtype=np.uint8) )

###########
# alt 1.
#        self.byte_buff = np.resize(self.byte_buff, ( 1, self.byte_buff.size + buff_len ) )[0]


################################################################################
    def ClearFromBeginning(self, buff_len) :

        buff_len = min( buff_len, self.byte_buff_len )

        while len(self.frame_starts) > 0 and self.frame_starts[0] < buff_len :
            self.frame_starts.pop(0)
            self.frame_cnt = np.delete( self.frame_cnt, [0] )
#LINUX compatibility
#            self.frame_starts = self.frame_starts[1:]
#            self.frame_cnt = self.frame_cnt[1:]

        for ii in xrange(len(self.frame_starts)) :
            self.frame_starts[ii] -= buff_len

        self.byte_buff = np.delete( self.byte_buff, xrange(buff_len) )
#LINUX compatibility
#        self.byte_buff[0:self.byte_buff_len - buff_len] = self.byte_buff[buff_len:self.byte_buff_len]

###########
# alt 1.
#        self.byte_buff[:self.byte_buff_len-buff_len] = self.byte_buff[buff_len:self.byte_buff_len]

        self.byte_buff_len -= buff_len
        

################################################################################
    def AddToEnd(self, in_buff) :
        self.byte_buff[self.byte_buff_len : self.byte_buff_len + in_buff.size] = in_buff
        self.byte_buff_len += in_buff.size  
