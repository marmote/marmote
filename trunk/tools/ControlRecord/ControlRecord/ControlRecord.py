from optparse import OptionParser
import numpy as np
import matplotlib.pyplot as plt
#import matplotlib.animation as animation

import ExtractFrames as EF
import Processing as P
import DrawChart as DC
import DSPConfig as conf


parser = OptionParser()
parser.add_option("-f", "--inputfile", dest="inputfile",
                  help="Input binary file <FILENAME> (default %default)", metavar="FILENAME", default="input.bin")



################################################################################
def data_gen():
    DSPconf = conf.DSPconf_t()

    accum = np.array([], dtype=np.uint8)

    frame_cnt_history   = np.array([], dtype=np.uint32)
    frame_FIFO          = []
    frame_cnt_FIFO      = np.array([], dtype=np.uint32)

    while True :

        temp = np.fromfile(f, dtype=np.uint8, count=200)
    
        if temp.size == 0 :
            break

        accum = np.append( accum, temp )
    
        ( frames, frame_cnt, accum ) = EF.ExtractFrames(accum, DSPconf)
    
        if len(frames) == 0 :
            continue

        frame_FIFO += frames
        frame_cnt_FIFO = np.append( frame_cnt_FIFO, frame_cnt )
    
        ( frame_FIFO, frame_cnt_FIFO, frame_cnt_history, frame_starts, missing_frames, I_buff, Q_buff, spectrum, I_spectrum, Q_spectrum ) = P.Processing( frame_FIFO, frame_cnt_FIFO, frame_cnt_history, DSPconf )

        if I_buff.size == 0 or Q_buff.size == 0:
            continue

        yield frame_cnt_history, frame_starts, missing_frames, I_buff, Q_buff, spectrum, I_spectrum, Q_spectrum, DSPconf


################################################################################
def ControlRecord(file_name):

    DSPconf = conf.DSPconf_t()


########################################
# Open file.
    global f
 
    f = open(file_name, 'rb')

    fd = DC.FancyDisplay(data_gen, DSPconf)

    try:
        plt.show()

    except:
        pass

    finally:
        f.close() 
 

################################################################################
if __name__ == "__main__":
    (options, args) = parser.parse_args()

    print 'Opening file...', options.inputfile

    ControlRecord(options.inputfile)
