import numpy as np
#import matplotlib
#matplotlib.use('GTKAgg')
import matplotlib.pyplot as plt
import matplotlib.cm as cm
from Proper_Packet_Table_Level_Size import Proper_Packet_Table_Level_Size 


def func(Packets, Levels, N) :
    res = np.zeros( (N, N) )

#    print Packets

    row = 0
    for ii in xrange(len(Packets)) :
        p = Packets[ii]
#        print "Packets[ii].size: %d"%p.size

        div_fact, level_N, start_idx, stop_idx = Proper_Packet_Table_Level_Size(Levels[ii], N, p.size)

#        temp = 1. / 2**Levels[ii]
#        level_N = int(N * temp)
#
#        start_idx = int((p.size - level_N)/2)
#        stop_idx = start_idx + level_N
            
        p = p[start_idx:stop_idx]

        for column in xrange(N) :
#            print "row: %d"%row
#            print "column: %d"%column
#            print "temp: %d"%temp
#            print "column * temp: %d"%(column * temp)
#            print "p.size: %d"%p.size
#            print "---"
            res[row, column] = np.abs(p[column * div_fact])

        row += 1

        if row % 100 == 0 :
            print "Generated row %d"%row

        for jj in xrange(level_N-1) :
            res[row, :] = res[row-1, :]
            row += 1

            if row % 100 == 0 :
                print "Generated row %d"%row
            

    return res
    

def FancyPlotWavelet(Packets, Levels, N, Fs, title=None, perform_log = False) :			
    Fs = float(Fs)
    Z = func(Packets, Levels, N)

    if perform_log:
        min_val = np.min(np.abs(Z))
        Z[Z == 0] = min_val/2
        Z = np.log(np.abs(Z))

    fig, ax = plt.subplots(1, 1)
    im = ax.imshow(Z, origin='lower', cmap=cm.gist_heat, interpolation='nearest', extent=[0., (N+1)/Fs, 0., Fs/2], aspect='auto')
    fig.colorbar(im)
    if title is not None :
        ax.set_title(title)
    ax.set_xlabel('time [sec]')
    ax.set_ylabel('frequency [Hz]')


################################################################################
if __name__ == "__main__":

    Packets = [ np.array([1, 0, 1, 1, 1, 1, 1, 1, 1]),
    np.array([0, 1]),
    np.array([1, 0, 1, 0]),
    np.array([0, 1, 0, 0.3, 0, 1, 0, 1]),
    np.array([1, 0, 1, 0, 1, 0, 1, 0]),
    np.array([1, 0, 0.5, 0]),
    np.array([1, 0]),
    np.array([0, 1]), 
    np.array([0, 1]),
    np.array([0, 1]),
    np.array([1, 0, 1, 0]),
    np.array([0, 1, 0, 0.9, 0, 1, 0, 1]),
    np.array([1, 0, 1, 0, 1, 0, 1, 0]),
    np.array([1, 0, 0.5, 0, 1, 0, 0.3, 1, 0.6, 0, 0.1, 1, 1, 0, 1, 0]),
    np.array([0, 1, 0, 0.9, 0, 1, 0, 1]),
    np.array([1, 0, 1, 0, 1, 0, 1, 0]),
    np.array([1, 0, 0.5, 0]),
    np.array([0, 1]),
    np.array([1, 0]),
    np.array([0, 1]), 
    np.array([0, 1]),
    np.array([1, 0, 1, 0]),
    np.array([0, 1, 0, 0.9, 0, 1, 0, 1]),
    np.array([1, 0, 1, 0, 1, 0, 1, 0]),
    np.array([1, 0, 0.5, 0]),
    np.array([1, 0]),
    np.array([0, 1]) ]

    Levels = [6, 6, 5, 4, 4, 5, 6, 6, 6, 6, 5, 4, 4, 3, 4, 4, 5, 6, 6, 6, 6, 5, 4, 4, 5, 6, 6]

    FancyPlotWavelet(Packets, Levels, N=128, Fs=1)


    import pywt
    import numpy as np
    y = np.array(xrange(64))*0
    y[40] = 1
    Fs = 1

    w = pywt.Wavelet('haar')

    c = pywt.wavedec(y, w, mode='zpd')

    levels = range(len(c)-1,0,-1)
    levels = [levels[0]] + levels

    FancyPlotWavelet(c, levels, y.size, Fs)

    
    plt.show()