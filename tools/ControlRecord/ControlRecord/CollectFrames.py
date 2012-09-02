from optparse import OptionParser
import numpy as np


import tools.DSPConfig as conf
import tools.ExtractFrames as EF
import tools.FramePreProcessing as FPP
import tools.ThresholdProcessing as TP


parser = OptionParser()
parser.add_option("-i", "--input", dest="inputfileordir",
                  help="Input binary file or directory containing binary files <FILEORDIRNAME> (default %default)", metavar="FILEORDIRNAME", default="input.bin")


################################################################################
if __name__ == "__main__":
    (options, args) = parser.parse_args()

    DSPconf = conf.DSPconf_t()
    mf_hist_len = 2

        
    dfe     = EF.DataFrameExtractor()
    fpp     = FPP.FramePreProcessor(DSPconf.channels, mf_hist_len) # Assumes a resolution of 2 bytes !!!
    tf      = TP.ThresholdFilter(0.2 * Full_scale)


#    s = FS.FileSource(options.inputfileordir)
    s = FS.FileSource('test.bin')
    f = open('./collect.bin', 'wb')

    accum = np.array([], dtype=np.uint8)

    while not s.SourceEmpty() :
        # 1. Find data frames (if any) in data
        processed_bytes, got_one_frame = dfe.ExtractDataFrames(accum)
        accum = accum[processed_bytes:]

        if got_one_frame :

        # 3. Some minor pre-processing steps
            dont_care, int_buff, = fpp.Process( dfe.byte_buff, dfe.byte_buff_len, dfe.frame_starts, dfe.frame_cnt, 0 ) 

            if tf.Process(int_buff) :

                DSPconf.START_OF_FRAME.tofile(f)

                frame_cnt_FIFO[0].newbyteorder('B').tofile(f)

                dfe.byte_buff.tofile(f)

            dfe.ClearFromBeginning(dfe.byte_buff_len)



        # 1. Get some brand new, raw data
        temp = s.GetBuffer()

        accum = np.append( accum, temp )

                
    f.close()