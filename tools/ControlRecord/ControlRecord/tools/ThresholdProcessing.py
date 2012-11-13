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


        return self.TH_cnt

        
################################################################################
    def Process(self, byte_buff, byte_buff_len, frame_starts, frame_cnt, process_fragments, stop_after_each = False):

        if process_fragments :
            frame_starts = frame_starts + [byte_buff_len]

        processed_bytes = 0



        # Check to see if the buffer is large enough, if not increase size
        worst_case_size = self.byte_buff_len + byte_buff_len
        size_diff = worst_case_size - self.byte_buff.size
        if size_diff > 0:
            self.IncreaseBufferSize(size_diff)



        len_tmp = len(frame_starts) - 1
        for ii in xrange( len_tmp ) :
            processed_bytes = frame_starts[ii+1]            
            
            t_buff = byte_buff[frame_starts[ii]:frame_starts[ii+1]]
#            frame_length = frame_starts[ii+1] - frame_starts[ii]

            prev_TH_cnt = self.TH_cnt
            self.ThresholdLogic(t_buff)
            if not self.TH_cnt :            
                if stop_after_each and prev_TH_cnt :
                    return processed_bytes

                continue


            self.frame_starts.append(self.byte_buff_len)
            self.frame_cnt = np.append( self.frame_cnt, frame_cnt[ii] )


#            while self.byte_buff.size < self.byte_buff_len + frame_length :
#                self.IncreaseBufferSize()

            self.AddToEnd(t_buff)

###########
# alt            
#            self.byte_buff[self.byte_buff_len : self.byte_buff_len + frame_length] = t_buff
#            self.byte_buff_len += frame_length            

        return processed_bytes

        #Return if done with the input buffer
        #OR
        #return if stop_after_each is True AND a signal end was detected
