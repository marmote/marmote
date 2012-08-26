import numpy as np



################################################################################
def ExtractFrames(buff, DSPconf):

########################################
# Set variables    
    buff            = buff.view(np.uint8)  # Make sure it is interpreted as uint8
    START_OF_FRAME  = DSPconf.START_OF_FRAME.view(np.uint8)  # Make sure it is interpreted as uint8


########################################
# Extract frames
    copy_to_frames = 0


    frames = []
    frame_cnt = np.array([], dtype = np.uint32)


    buff_count = START_OF_FRAME.size

    while buff_count < buff.size :
        # We are looking for the start of the frame
        if (buff[buff_count-START_OF_FRAME.size : buff_count] == START_OF_FRAME).all() == False : 
            buff_count = buff_count + 1
            continue

        # Every complete frame is copied to a list
        if copy_to_frames == 1 :
            #First copy frame counter
            frame_cnt = np.append( frame_cnt, buff[ START_OF_FRAME.size : START_OF_FRAME.size+4 ].view(np.uint32).newbyteorder('B') )

            frame_temp = buff[ START_OF_FRAME.size+4 : buff_count - START_OF_FRAME.size ].copy()
            frames.append(frame_temp.view(np.int16).newbyteorder('B'))
    
        copy_to_frames = 1
    
        # Complete frames are removed from buffer
        buff = buff[buff_count - START_OF_FRAME.size :]
        buff_count = START_OF_FRAME.size + 4 + START_OF_FRAME.size


    return frames, frame_cnt, buff



################################################################################
if __name__ == "__main__":

    class DSPconf_t:
        def __init__(self):
            self.START_OF_FRAME = np.array([0xA1, 0xBE, 0xAF, 0x01], dtype = np.uint8)


    DSPconf = DSPconf_t()

    START_OF_FRAME = DSPconf.START_OF_FRAME
    buff = np.array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], dtype = np.uint32)
    buff = buff.view(np.uint8)
    buff[19:23] = START_OF_FRAME
    buff[43:47] = START_OF_FRAME
    buff[59:63] = START_OF_FRAME

    (frames, frame_cnt, buff) = ExtractFrames(buff, DSPconf)
   
    for ii in range(len(frames)):
        print frames[ii]

    print frame_cnt

    print buff 
