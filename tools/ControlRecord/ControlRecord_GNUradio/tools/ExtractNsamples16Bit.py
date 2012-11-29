import numpy as np


################################################################################
class ExtractNsamples16Bit:
    
################################################################################
    def __init__(self):
        pass

################################################################################
    def Process(self, byte_buff, byte_buff_len, frame_starts, frame_cnt, N = 0):
    ########################################
    # Fixed values
        channels           = 2
        res                = 2 # resolution in bytes


    ########################################
    # Set variables    
        byte_buff   = byte_buff.view(np.uint8)

        byte_buff_len = min( byte_buff_len, byte_buff.size )

        nominal_len = N * channels * res

        if nominal_len > 0 :
            byte_buff_len = min( byte_buff_len, nominal_len )

        buff_len = byte_buff_len - byte_buff_len % (channels * res)
        int_buff = byte_buff[:buff_len].view( dtype=np.int16 ).newbyteorder()


        frame_starts_out = []
        frame_cnt_out = [] 
        ii = 0
        while ii < len(frame_starts) and frame_starts[ii] < buff_len :
            frame_starts_out.append( frame_starts[ii]/res )
            frame_cnt_out.append( frame_cnt[ii] ) 

            ii += 1

        return buff_len, int_buff, frame_starts_out, frame_cnt_out
