from optparse import OptionParser

import tools.StdinSource            as SS
import tools.GenerateDisplayData    as GDD
import tools.FancyDisplay           as FD
import tools.DSPConfig              as conf


parser = OptionParser()
parser.add_option("-i", "--input", dest="inputfileordir",
                  help="Input binary file or directory containing binary files <FILEORDIRNAME> (default %default)", metavar="FILEORDIRNAME", default="input.bin")
parser.add_option("-r", "--RF", dest="RF",
                  help="Turns on RF signal processing as opposed to Base-Band processing (default off)", action="store_true", default=False)


################################################################################
if __name__ == "__main__":
    (options, args) = parser.parse_args()

    if options.RF :
        DSPconf = conf.DSPconf_RF_t()
    else :
        DSPconf = conf.DSPconf_t()

    Display_N = 400
    MF_hist_len = 200

    Source = SS.StdinSource()
    dg = GDD.DisplayDataGenerator(Source, DSPconf, Display_N, MF_hist_len, options.RF)
    fd = FD.FancyDisplay(DSPconf, 5, Display_N, MF_hist_len, True, options.RF)
    fd.SetupAnimation(dg.data_gen)

    try:
        fd.ShowFigure()

    except:
        pass

    finally:
        pass