from optparse import OptionParser

import tools.StdinSource            as SS
import tools.GenerateDisplayData    as GDD
import tools.DrawChart              as DC
import tools.DSPConfig              as conf


parser = OptionParser()
parser.add_option("-i", "--input", dest="inputfileordir",
                  help="Input binary file or directory containing binary files <FILEORDIRNAME> (default %default)", metavar="FILEORDIRNAME", default="input.bin")


################################################################################
if __name__ == "__main__":
    (options, args) = parser.parse_args()

#    print 'Opening file... {0}'.format(options.inputfile)
#    print 'Opening file... %s' % (options.inputfile)

    DSPconf = conf.DSPconf_t()

#    with open (file_name, 'rb') as f:
#        pass

    Display_N = 400
    MF_hist_len = 200

    Source = SS.StdinSource()
    dg = GDD.DisplayDataGenerator(Source, DSPconf, Display_N, MF_hist_len)
    fd = DC.FancyDisplay(DSPconf, 5, Display_N, MF_hist_len)
    fd.SetupAnimation(dg.data_gen)

    try:
        fd.ShowFigure()

    except:
        pass

    finally:
        pass