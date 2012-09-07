import numpy as np
import FrameBuffer as FB


################################################################################
class ThresholdFilter(FB.FrameBuffer):

################################################################################
    def __init__(self, TH_level):
        FB.FrameBuffer.__init__(self)

        self.TH_level = TH_level
        self.rec_frame_num = 10
        self.TH_cnt = 0
        

################################################################################
    def ThresholdLogic(self, buff):

        if self.TH_cnt > 0 :
            self.TH_cnt -= 1

        buff = buff.view(dtype=np.int16).newbyteorder()

        
        if np.abs(buff).max() >= self.TH_level :
            self.TH_cnt = self.rec_frame_num

###########
# alt 1.
#        for ii in np.abs(buff) :
#            if ii >= self.TH_level :
#                self.TH_cnt = self.rec_frame_num
#                break


        return self.TH_cnt > 0

        
################################################################################
    def Process(self, byte_buff, byte_buff_len, frame_starts, frame_cnt, process_fragments):

        if process_fragments :
            frame_starts = frame_starts + [byte_buff_len]

        processed_bytes = 0

        for ii in xrange( len(frame_starts) - 1 ) :
            processed_bytes = frame_starts[ii+1]            
            
            t_buff = byte_buff[frame_starts[ii]:frame_starts[ii+1]]
            frame_length = frame_starts[ii+1] - frame_starts[ii]

            if not self.ThresholdLogic(t_buff) :            
                continue

            self.frame_starts.append(self.byte_buff_len)
            self.frame_cnt = np.append( self.frame_cnt, frame_cnt[ii] )


            while self.byte_buff.size < self.byte_buff_len + frame_length :
                self.IncreaseBufferSize()
            
            self.byte_buff[self.byte_buff_len : self.byte_buff_len + frame_length] = t_buff
            self.byte_buff_len += frame_length            

        return processed_bytes
