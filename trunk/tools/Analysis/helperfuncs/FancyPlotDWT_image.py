import numpy as np
#import matplotlib
#matplotlib.use('GTKAgg')
import matplotlib.pyplot as plt
import matplotlib.cm as cm


def func(c) :
    N = 0
    for ii in xrange(len(c)) :
        N += c[ii].size


    res = np.zeros( (N, N) )

    row = 0
    for ct in c :
        for column in xrange(N) :
            res[row, column] = np.abs(ct[column * ct.size / N])

        row += 1

        if row % 100 == 0 :
            print "Generated row %d"%row

        for jj in xrange(ct.size-1) :
            res[row, :] = res[row-1, :]
            row += 1

            if row % 100 == 0 :
                print "Generated row %d"%row
            

    return N, res
    

def FancyPlotDWT(c, Fs, subtitle=None) :			
    Fs = float(Fs)
    N, Z = func(c)

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

    c = [ np.array([1, 0]),
    np.array([0, 1]),
    np.array([1, 0, 1, 0]),
    np.array([0, 1, 0, 0.3, 0, 1, 0, 1]),
    np.array([1, 0, 1, 0, 1, 0, 1, 0]),
    np.array([1, 0, 0.5, 0]),
    np.array([1, 0]),
    np.array([0, 1]), 
    np.array([0, 1]),
    np.array([1, 0, 1, 0]),
    np.array([0, 1, 0, 0.9, 0, 1, 0, 1]),
    np.array([1, 0, 1, 0, 1, 0, 1, 0]),
    np.array([1, 0, 0.5, 0, 1, 0, 0.3, 1, 0.6, 0, 0.1, 1, 1, 0, 1, 0]),
    np.array([0, 1, 0, 0.9, 0, 1, 0, 1]),
    np.array([1, 0, 1, 0, 1, 0, 1, 0]),
    np.array([1, 0, 0.5, 0]),
    np.array([1, 0]),
    np.array([0, 1]), 
    np.array([0, 1]),
    np.array([1, 0, 1, 0]),
    np.array([0, 1, 0, 0.9, 0, 1, 0, 1]),
    np.array([1, 0, 1, 0, 1, 0, 1, 0]),
    np.array([1, 0, 0.5, 0]),
    np.array([1, 0]),
    np.array([0, 1]) ]

    FancyPlotDWT(c, 1)
    plt.show()