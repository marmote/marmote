from optparse import OptionParser

import sys

import tools.GenerateDisplayData as GDD
import tools.SignalProcessing as SP
import tools.DrawChart as DC
import tools.DSPConfig as conf


parser = OptionParser()
parser.add_option("-i", "--input", dest="inputfileordir",
                  help="Input binary file or directory containing binary files <FILEORDIRNAME> (default %default)", metavar="FILEORDIRNAME", default="input.bin")


################################################################################
if __name__ == "__main__":
    (options, args) = parser.parse_args()

    DSPconf = conf.DSPconf_t()

    Display_N = 0
    MF_hist_len = 40


    #####################################
    # Get all the data
#    dg = GDD.FileDataGenerator(options.inputfileordir, DSPconf, Display_N, MF_hist_len)
    dg = GDD.DisplayDataGenerator("collect.bin", DSPconf, Display_N, MF_hist_len)

    dg.GetPreProcessedBuff()

    if dg.int_buff.size == 0 :
        sys.exit(1)

    frame_starts, I_buff, Q_buff, I_spectrum, Q_spectrum, = SP.SignalProcessing( dg.frame_starts, dg.int_buff, DSPconf )  # Assumes 2 channels !!!

    data = ( frame_starts, dg.missing_frames, I_buff, Q_buff, I_spectrum, Q_spectrum )


    #####################################
    # Display 
    fd = DC.FancyDisplay(DSPconf, I_buff.size, MF_hist_len, False)

    fd.InitObj()
    fd.DrawFigure(data)
    fd.ShowFigure()
   


