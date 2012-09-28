from optparse import OptionParser

import sys

import tools.FileSource             as FS
import tools.GenerateData           as GD
import tools.SignalProcessing       as SP
import tools.FancyDisplay           as FD
import tools.DSPConfig              as conf


parser = OptionParser()
parser.add_option("-i", "--input", dest="inputfileordir",
                  help="Input binary file or directory containing binary files <FILEORDIRNAME> (default %default)", metavar="FILEORDIRNAME", default="collect.bin")
parser.add_option("-r", "--RF", dest="RF",
                  help="Turns on RF signal processing as opposed to Base-Band processing (default off)", action="store_true", default=False)


################################################################################
if __name__ == "__main__":
    (options, args) = parser.parse_args()

    if options.RF :
        DSPconf = conf.DSPconf_RF_t()
    else :
        DSPconf = conf.DSPconf_t()

    Display_N = 0
    MF_hist_len = 40


    #####################################
    # Get all the data
    Source = FS.FileSource(options.inputfileordir)
    dg = GD.DataGenerator(Source, DSPconf, Display_N, -1)

    dg.GetPreProcessedBuff()

    if dg.int_buff.size == 0 :
        sys.exit(1)

    frame_starts, I_buff, Q_buff, I_spectrum, Q_spectrum, spectrum = SP.SignalProcessing( dg.frame_starts, dg.int_buff, DSPconf, options.RF )  # Assumes 2 channels !!!

    data = ( frame_starts, dg.missing_frames, I_buff, Q_buff, I_spectrum, Q_spectrum, spectrum )


    #####################################
    # Display 
    fd = FD.FancyDisplay(DSPconf, len(frame_starts), I_buff.size, MF_hist_len, False, options.RF)
    
    fd.DrawFigure(data)
    fd.ShowFigure()
   


