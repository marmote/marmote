import numpy as np
from SignalGenerator import SignalGenerator
from Wavelet.FullWPD import FullWPD
from Wavelet.UsablePacketTableLevels import UsablePacketTableLevels
from Wavelet.FancyPlotWavelet_im import FancyPlotWavelet


#############################################################################
if __name__ == "__main__":

    (y, f, fint) = SignalGenerator()
    #y, f, fint = SignalGenerator(N = N, Fs = Fs, f_start = 100, f_stop = 300, f_steps = 3)


    PacketTable = FullWPD(y, wavelet='haar')

    min_div = 16

    N = 2048*2
    Fs = 1e3

    start_level, stop_level = UsablePacketTableLevels(16, PacketTable, N)

    level_of_interest = int((start_level + stop_level)/2)
    Levels = np.ones(len(PacketTable[level_of_interest]))*level_of_interest

    FancyPlotWavelet(PacketTable[level_of_interest], Levels, N, Fs, title='Wavelet Package Decomposition\nFixed resolution', perform_log=True)

    pass
