import numpy as np
import os
import sys

mpath = os.path.split(__file__)[0]
addpath = os.path.abspath(os.path.join(mpath, '../../ControlRecord/ControlRecord'))

if addpath not in sys.path :
	sys.path.append(addpath)
	print 'Module folder added to system path: %s'%addpath


import tools.DSPConfig				as conf
import tools.FileSource				as FS
import tools.SignalProcessing		as SP
import tools.GenerateData           as GD
import tools.FancyDisplay           as FD



def FunctionDisplayRecording_total(FileOrDir):
    DSPconf = conf.DSPconf_t()

    Display_N = 0
    MF_hist_len = 40


    #####################################
    # Get all the data
    Source = FS.FileSource(FileOrDir)
    dg = GD.DataGenerator(Source, DSPconf, Display_N, -1)
    spc = SP.SignalProcessingChain(DSPconf, filtering=True)

    dg.GetPreProcessedBuff()

    if dg.int_buff.size == 0 :
        sys.exit(1)

    frame_starts, I_buff, Q_buff, I_spectrum, Q_spectrum, spectrum = spc.SignalProcessing( dg.frame_starts, dg.int_buff )  # Assumes 2 channels !!!

    data = ( frame_starts, dg.missing_frames, I_buff, Q_buff, I_spectrum, Q_spectrum, spectrum )


    #####################################
    # Display 
    fd = FD.FancyDisplay(DSPconf, len(frame_starts), I_buff.size, MF_hist_len, False)
    
    fd.DrawFigure(data)
    fd.ShowFigure()