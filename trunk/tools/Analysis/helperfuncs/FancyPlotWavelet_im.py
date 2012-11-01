import numpy as np
#import matplotlib
#matplotlib.use('GTKAgg')
import matplotlib.pyplot as plt
import matplotlib.cm as cm


def func(Packets, Levels, N) :
    res = np.zeros( (N, N) )

    row = 0
    for ii in xrange(len(Packets)) :
        p = Packets[ii]
        #print "Packets[ii].size: %d"%p.size

        temp = 1. / 2**Levels[ii]
        level_N = int(N * temp)

        start_idx = int((p.size - level_N)/2)
        stop_idx = start_idx + level_N
            
        p = p[start_idx:stop_idx]

        for column in xrange(N) :
            #print "row: %d"%row
            #print "column: %d"%column
            #print "temp: %d"%temp
            #print "column * temp: %d"%(column * temp)
            #print "p.size: %d"%p.size
            #print "---"
            res[row, column] = np.abs(p[column * temp])

        row += 1

        if row % 100 == 0 :
            print "Generated row %d"%row

        for jj in xrange(level_N-1) :
            res[row, :] = res[row-1, :]
            row += 1

            if row % 100 == 0 :
                print "Generated row %d"%row
            

    return res
    

def FancyPlotWavelet(Packets, Levels, N, Fs, subtitle=None) :			
    Fs = float(Fs)
    Z = func(Packets, Levels, N)

    fig, ax = plt.subplots(1, 1)
    im = ax.imshow(Z, origin='lower', cmap=cm.gist_heat, interpolation='nearest', extent=[0., (N+1)/Fs, 0., Fs/2], aspect='auto')
    fig.colorbar(im)
    if subtitle is None :
        ax.set_title('Discrete Wavelet Transfrom')
    else:
        ax.set_title('Discrete Wavelet Transfrom\n%s'%(subtitle))
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
    plt.show()