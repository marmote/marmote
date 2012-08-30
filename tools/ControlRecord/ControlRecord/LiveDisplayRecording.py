from optparse import OptionParser


import GenerateData as GD
import DrawChart as DC
import DSPConfig as conf


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

    Display_N = 500
    MF_hist_len = 500

    dg = GD.DisplayDataGenerator(options.inputfileordir, Display_N, DSPconf, MF_hist_len)
    fd = DC.FancyDisplay(DSPconf, Display_N, MF_hist_len)
    fd.SetupAnimation(dg.data_gen)
#    fd = DC.FancyDisplay(dg.data_gen_th, DSPconf)

    try:
        fd.ShowFigure()

    except:
        pass

    finally:
        pass