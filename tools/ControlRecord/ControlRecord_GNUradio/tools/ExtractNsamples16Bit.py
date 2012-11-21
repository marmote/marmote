import numpy as np


################################################################################
class ExtractNsamples16Bit:
    
################################################################################
    def __init__(self):
        pass

################################################################################
    def Process(self, byte_buff, byte_buff_len, frame_starts, frame_cnt, N):
    ########################################
    # Fixed values
        channels           = 2
        res                = 2 # resolution in bytes


    ########################################
    # Set variables    
#        byte_buff   = byte_buff.view(np.uint8)

        byte_buff_len = min( byte_buff_len, byte_buff.size )

        nominal_len = N * channels * res

        if nominal_len > 0 :
            if byte_buff_len < nominal_len :
                byte_buff_len = 0
            else :
                byte_buff_len = nominal_len

        buff_len = byte_buff_len - byte_buff_len % (channels * res)
        int_buff = byte_buff[:buff_len].view( dtype=np.int16 )


        frame_starts_out = []
        ii = 0
        while ii < len(frame_starts) and frame_starts[ii] < buff_len :
            frame_starts_out.append( frame_starts[ii]/res )

#            if self.mf_hist_len :
#                if self.mf_hist_len < 0 or self.frame_cnt_history.size < self.mf_hist_len + 1 :
#                    self.frame_cnt_history = np.append( self.frame_cnt_history, frame_cnt[ii] )
#                else :
#                    self.frame_cnt_history = np.roll( self.frame_cnt_history, -1 )
#                    self.frame_cnt_history[-1] = frame_cnt[ii] 

            ii += 1

        return buff_len, int_buff, frame_starts_out
