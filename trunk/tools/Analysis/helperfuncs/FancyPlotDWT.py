import numpy as np
import matplotlib.pyplot as plt


def func1(c, Fs) :
    N = 0
    for ii in xrange(len(c)) :
        N += c[ii].size

    Fs = float(Fs)
    t = np.arange(N+1)/Fs

    Fs=Fs/2
    f = [0]
    for ii in xrange(len(c)) :
        f.append(f[-1] + Fs * len(c[ii]) / N)

    return N, f, t


def func(f, t, c) :
    X, Y = np.meshgrid(t, f)

    rows, columns = X.shape
    rows = rows - 1
    columns = columns - 1
    
    res = np.zeros( (rows, columns) )

    for row in xrange(rows) :
        for column in xrange(columns) :
            index = column * len(c[row]) / (len(t)-1)
            res[row, column] = np.abs(c[row][index])
#            temp_val = np.abs(c[row][index])
#            if temp_val == 0 :
#                res[row, column] = -120
#            else :
#                res[row, column] = 20*np.log10(temp_val)

    return X, Y, res


def FancyPlotDWT(c, Fs) :			
    Fs = float(Fs)
    N, f, t = func1(c, Fs)
    X, Y, Z = func(f, t, c)
   
    fig, ax = plt.subplots(1, 1)
    pc = ax.pcolor(X, Y, Z, cmap='spectral')
#	plt.pcolor(X, Y, Z, cmap='spectral')
    ax.axis([t[0], t[-1], f[0], f[-1]])
    fig.colorbar(pc)
    ax.set_title('Discrete Wavelet Transfrom')
    ax.set_xlabel('time [sec]')
    ax.set_ylabel('frequency [Hz]')


################################################################################
if __name__ == "__main__":

    c = [ np.array([1, 0]),
    np.array([0, 1]),
    np.array([1, 0, 1, 0]),
    np.array([0, 1, 0, 0.9, 0, 1, 0, 1]),
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