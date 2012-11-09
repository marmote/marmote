from optparse import OptionParser

import sys

import tools.FileSource     as FS
import tools.DSPConfig      as conf
import tools.GenerateData   as GD

import wave


parser = OptionParser()
parser.add_option("-i", "--input", dest="inputfileordir",
                  help="Input binary file or directory containing binary files <FILEORDIRNAME> (default %default)", metavar="FILEORDIRNAME", default="input.bin")


################################################################################
if __name__ == "__main__":
    (options, args) = parser.parse_args()

    DSPconf = conf.DSPconf_t()

    Display_N = 1000
    MF_hist_len = 0


    Source = FS.FileSource(options.inputfileordir)
    dg = GD.DataGenerator(Source, DSPconf, Display_N, MF_hist_len)
    

    fp = wave.open(options.inputfileordir + '.wav', 'w') 
    fp.setparams((2, 2, 44100, 0, 'NONE', 'not compressed'))


    while True :
        #####################################
        # Get data
        dg.GetPreProcessedBuff()
    
        if dg.int_buff.size == 0 :
            sys.exit(0)


        #####################################
        # Write data to file
        #value_str = ''.join(dg.int_buff)

#        fp.writeframesraw(value_str)
        fp.writeframesraw(dg.int_buff)

    fp.close()