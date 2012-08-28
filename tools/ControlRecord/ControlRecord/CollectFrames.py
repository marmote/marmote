from optparse import OptionParser
import numpy as np


import GenerateData as GD
import DSPConfig as conf


parser = OptionParser()
parser.add_option("-i", "--input", dest="inputfileordir",
                  help="Input binary file or directory containing binary files <FILEORDIRNAME> (default %default)", metavar="FILEORDIRNAME", default="input.bin")


################################################################################
if __name__ == "__main__":
    (options, args) = parser.parse_args()

    DSPconf = conf.DSPconf_t()

    dg = GD.FileDataGenerator(options.inputfileordir, DSPconf)
#    dg = GD.FileDataGenerator("test.bin", DSPconf)

    frame_FIFO          = []
    frame_cnt_FIFO      = np.array([], dtype=np.uint32)

    f = open('./collect.bin', 'wb')

    while dg.f != 0 :
        dg.GetFrames()

        (dg.frame_FIFO, dg.frame_cnt_FIFO, frame_FIFO, frame_cnt_FIFO) = dg.tf.ThresholdProcessing( dg.frame_FIFO, dg.frame_cnt_FIFO, frame_FIFO, frame_cnt_FIFO )

        while len(frame_FIFO) :

            DSPconf.START_OF_FRAME.tofile(f)

            frame_cnt_FIFO[0].newbyteorder('B').tofile(f)

            frame_FIFO[0].tofile(f)
                
            frame_FIFO = frame_FIFO[1:]
            frame_cnt_FIFO = frame_cnt_FIFO[1:]

    f.close()