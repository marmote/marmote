import numpy as np
import FrameBuffer as FB


################################################################################
class DataFrameExtractor(FB.FrameBuffer):

################################################################################
    def __init__(self, START_OF_FRAME = np.array([0xA1, 0xBE, 0xAF], dtype = np.uint8), DATA_FRAME_ID = np.array([0x01], dtype = np.uint8)):
        FB.FrameBuffer.__init__(self)

        self.START_OF_FRAME         = START_OF_FRAME
        self.DATA_FRAME_ID          = DATA_FRAME_ID

        #################################
        # This class uses a state machine to find frames

        # State variables
        self.WAITING_STATE          = 0 # Waiting for frame start
        self.ID_STATE               = 1
        self.COUNTER_STATE          = 2 # Collecting the frame counter

        self.state              = self.WAITING_STATE
        self.collect_state      = False

        # indicates how much of the START_OF_FRAME pattern was found
        self.SOF_cnt = 0

        # for the frame counter temporary storage
        self.CNT = np.zeros(4, dtype=np.uint8)
        self.CNT_cnt = 0


################################################################################
    def ExtractDataFrames(self, input_buff, input_buff_len = None):

    ########################################
    # Set variables    
        input_buff              = input_buff.view(np.uint8)  # Make sure it is interpreted as uint8
        if input_buff_len is None or input_buff_len <= 0 :
            input_buff_len = input_buff.size
        else :
            input_buff_len = min(input_buff_len, input_buff.size)

        SOF                     = self.START_OF_FRAME
        ID                      = self.DATA_FRAME_ID

    ########################################
    # Extract frames
        for ii in xrange(input_buff_len) :

            ###################
            # Do something with the sample according to the state we are in

            if self.state == self.WAITING_STATE :

                # if we are storing the bytes
                if self.collect_state :

                    # Check to see if the buffer is large enough, if not increase size
                    while self.byte_buff.size < self.byte_buff_len + 2 * SOF.size:
                        self.IncreaseBufferSize()

                    # We are looking for the start of frame sequence and we are storing data
                    # Obvioulsy the start of frame sequence is not stored, but if only parts of it
                    # are encountered that we have to store
                    if input_buff[ii] != SOF[self.SOF_cnt] :
                        for jj in xrange(self.SOF_cnt) :
                            self.byte_buff[self.byte_buff_len] = SOF[jj]
                            self.byte_buff_len += 1

                        if input_buff[ii] != SOF[0] :
                            self.byte_buff[self.byte_buff_len] = input_buff[ii]
                            self.byte_buff_len += 1


#            elif self.state == self.ID_STATE :
#
#                if input_buff[ii] == ID[0] :
#                    self.frame_starts.append(self.byte_buff_len)


            elif self.state == self.COUNTER_STATE :
                
                self.CNT[self.CNT_cnt] = input_buff[ii]

                if self.CNT_cnt == 3 :
                    self.frame_starts.append(self.byte_buff_len)
                    self.frame_cnt = np.append( self.frame_cnt, self.CNT.view(np.uint32).newbyteorder('B') )


            ###################
            # State transitions
            if self.state == self.WAITING_STATE :

                if input_buff[ii] == SOF[0] :
                    self.SOF_cnt = 1
                elif input_buff[ii] == SOF[self.SOF_cnt] :
                    self.SOF_cnt += 1
                else :
                    self.SOF_cnt = 0

                if self.SOF_cnt >= SOF.size :
                    self.SOF_cnt = 0
                    self.state = self.ID_STATE

                    self.collect_state = False


            elif self.state == self.ID_STATE :

                if input_buff[ii] == ID[0] :
                    self.state = self.COUNTER_STATE
                else :
                    self.state = self.WAITING_STATE


            elif self.state == self.COUNTER_STATE :

                self.CNT_cnt += 1                

                if self.CNT_cnt >= 4 :
                    self.CNT_cnt = 0
                    self.state = self.WAITING_STATE
                    self.collect_state = True


################################################################################
if __name__ == "__main__":


    seq = np.append( np.array([0xA1, 0xBE, 0xAF], dtype = np.uint8), np.array([0x01], dtype = np.uint8) )

    buff = np.array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], dtype = np.uint32)
    buff = buff.view(np.uint8)
    buff[5:7] = seq[0:2]
    buff[19:23] = seq
    buff[30:32] = seq[0:2]
    buff[37] = seq[0]
    buff[43:47] = seq
    buff[59:63] = seq


    dfe = DataFrameExtractor()
    (ii,) = dfe.ExtractDataFrames(buff)
 
    dfe2 = DataFrameExtractor()
    (ii,) = dfe2.ExtractDataFrames(buff, 30)
    buff = buff[30:]
    (ii,) = dfe2.ExtractDataFrames(buff, 30)
    buff = buff[30:]
    (ii,) = dfe2.ExtractDataFrames(buff, 30)

