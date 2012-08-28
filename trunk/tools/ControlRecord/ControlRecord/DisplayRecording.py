from optparse import OptionParser

import sys

import GenerateData as GD
import SignalProcessing as SP
import DrawChart as DC
import Processing as P
import DSPConfig as conf


parser = OptionParser()
parser.add_option("-i", "--input", dest="inputfileordir",
                  help="Input binary file or directory containing binary files <FILEORDIRNAME> (default %default)", metavar="FILEORDIRNAME", default="input.bin")


################################################################################
if __name__ == "__main__":
    (options, args) = parser.parse_args()

    DSPconf = conf.DSPconf_t()

    DSPconf.N = 0

#    dg = GD.FileDataGenerator(options.inputfileordir, DSPconf)
    dg = GD.FileDataGenerator("collect.bin", DSPconf)

    while dg.f != 0 :
        dg.GetFrames()

    ( frame_FIFO, frame_cnt_FIFO, frame_cnt_history, frame_starts, missing_frames, buff ) = P.Processing( dg.frame_FIFO, dg.frame_cnt_FIFO, dg.frame_cnt_history, DSPconf )

    if buff.size == 0 :
        sys.exit(1)

    ( I_buff, Q_buff, spectrum, I_spectrum, Q_spectrum ) = SP.SignalProcessing( buff, DSPconf )

    if I_buff.size == 0 or Q_buff.size == 0:
        sys.exit(2)

    data = (frame_cnt_history, frame_starts, missing_frames, I_buff, Q_buff, spectrum, I_spectrum, Q_spectrum)

    DSPconf.N = I_buff.size
    fd = DC.FancyDisplay(DSPconf, False)

#    fd.InitFigure()
    fd.InitObj()
    fd.DrawFigure(data)
    fd.ShowFigure()



    


