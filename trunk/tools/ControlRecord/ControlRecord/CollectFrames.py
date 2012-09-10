from optparse import OptionParser

import sys
import tools.DSPConfig as conf
import tools.GenerateData as GD
import tools.FrameConfig as FC


parser = OptionParser()
parser.add_option("-i", "--input", dest="inputfileordir",
                  help="Input binary file or directory containing binary files <FILEORDIRNAME> (default %default)", metavar="FILEORDIRNAME", default="input.bin")


################################################################################
if __name__ == "__main__":
    (options, args) = parser.parse_args()

    DSPconf = conf.DSPconf_t()
    FrameConf = FC.Frameconf_t()

    Display_N = 0
    MF_hist_len = 0


    #####################################
    # Get all the data
    dg = GD.DataGenerator(options.inputfileordir, DSPconf, Display_N, MF_hist_len)
#    dg = GD.DataGenerator("test.bin", DSPconf, Display_N, MF_hist_len)

    while not dg.s.SourceEmpty() :
        dg.GetTHFilteredData()

    if dg.tf.byte_buff_len == 0 :
        sys.exit(1)

    #####################################
    # Write data to file
    f = open('./collect.bin', 'wb')

    frame_starts = dg.tf.frame_starts
    frame_starts.append(dg.tf.byte_buff_len)

    for ii in xrange(len(frame_starts) - 1) :

        FrameConf.START_OF_FRAME.tofile(f)
        FrameConf.DATA_FRAME_ID.tofile(f)

        dg.tf.frame_cnt[ii].newbyteorder('B').tofile(f)

        dg.tf.byte_buff[frame_starts[ii]:frame_starts[ii+1]].tofile(f)
                
    f.close()

    #sys.exit(0)