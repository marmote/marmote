from optparse import OptionParser


import GenerateData as GD
import DrawChart as DC
import DSPConfig as conf


parser = OptionParser()
parser.add_option("-i", "--input", dest="inputfileordir",
                  help="Input binary file or directory containing binary files <FILEORDIRNAME> (default %default)", metavar="FILEORDIRNAME", default="input.bin")



################################################################################
def ControlRecord(fileordir):
    """Doc string"""

    DSPconf = conf.DSPconf_t()

#    with open (file_name, 'rb') as f:
#        pass

    dg = GD.FileDataGenerator(fileordir, DSPconf)
    fd = DC.FancyDisplay(dg.data_gen, DSPconf)

    try:
        fd.ShowFigure()

    except:
        pass

    finally:
        dg.CloseCurrentFile()

 

################################################################################
if __name__ == "__main__":
    (options, args) = parser.parse_args()

#    print 'Opening file...', options.inputfileordir
#    print 'Opening file... {0}'.format(options.inputfile)
#    print 'Opening file... %s' % (options.inputfile)

    ControlRecord(options.inputfileordir)
