import numpy as np


################################################################################
class DataFrameExtractor:

################################################################################
    def __init__(self, min_bytes = 0, START_OF_FRAME = np.array([0xA1, 0xBE, 0xAF], dtype = np.uint8), DATA_FRAME_ID = np.array([0x01], dtype = np.uint8)):
        self.START_OF_FRAME         = START_OF_FRAME
        self.DATA_FRAME_ID          = DATA_FRAME_ID
        self.min_bytes              = min_bytes

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

        #################################
        # The results 

        self.frame_starts = []
        self.frame_cnt = np.array([], dtype=np.uint32)

        # "allocate memory" for buffer, little bit more than the minimum required
        if min_bytes > 0 :
            self.byte_buff = np.zeros(min_bytes + 2 * START_OF_FRAME.size, dtype=np.uint8) 
        else :
            self.byte_buff = np.zeros(100, dtype=np.uint8) 

        # indicates the number of valid bytes in buffer
        self.byte_buff_len = 0


################################################################################
    def ClearFromBeginning(self, buff_len) :

        if buff_len > self.byte_buff_len :
            buff_len = self.byte_buff_len

        while len(self.frame_starts) > 0 and self.frame_starts[0] < buff_len :
            self.frame_starts = self.frame_starts[1:]
            self.frame_cnt = self.frame_cnt[1:]

        for ii in xrange(len(self.frame_starts)) :
            self.frame_starts[ii] -= buff_len

        self.byte_buff[:self.byte_buff_len-buff_len] = self.byte_buff[buff_len:self.byte_buff_len]
        self.byte_buff_len -= buff_len


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
        ii = 0

        while ii < input_buff_len :

            # if we have enough bytes exit
            if self.min_bytes > 0 :
                if self.byte_buff_len >= self.min_bytes :
                    break


            # Do something with the sample according to the state we are in

            if self.state == self.WAITING_STATE :

                # if we are storing the bytes
                if self.collect_state == True :

                    # Check to see if the buffer is large enough, if not increase size
                    if self.min_bytes == 0 : 
                        if self.byte_buff_len % 100 == 0 :
                            if self.byte_buff.size < self.byte_buff_len + 1 + 100:
                                self.byte_buff = np.append( self.byte_buff, np.ones(100, dtype=np.uint8) )

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


            elif self.state == self.ID_STATE :

                if input_buff[ii] == ID[0] :
                    self.frame_starts.append(self.byte_buff_len)


            elif self.state == self.COUNTER_STATE :
                
                self.CNT[self.CNT_cnt] = input_buff[ii]

                if self.CNT_cnt == 3 :
                    self.frame_cnt = np.append( self.frame_cnt, self.CNT.view(np.uint32).newbyteorder('B') )



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

                    t = self.collect_state
                    self.collect_state = False

                    if t == True and self.min_bytes == 0:
                        break


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


            ii += 1


        return ii
                   

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
    (ii) = dfe.ExtractDataFrames(buff)
 
    dfe2 = DataFrameExtractor()
    (ii) = dfe2.ExtractDataFrames(buff, 30)
    buff = buff[30:]
    (ii) = dfe2.ExtractDataFrames(buff, 30)
    buff = buff[30:]
    (ii) = dfe2.ExtractDataFrames(buff, 30)

