import numpy as np
import matplotlib.pyplot as plt

def func1(N, c, Fs) :
	Fs = float(Fs)
	f = [0]
	for ii in xrange(len(c)) :
		f.append(f[-1] + Fs * len(c[ii]) / N)

	t = np.arange(N+1)/Fs
	return f, t


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
            
	return X, Y, res

	
def FancyPlotDWT(N, c, Fs) :			
	Fs = float(Fs)
	f, t = func1(N, c, Fs)
	X, Y, Z = func(f, t, c)

	plt.figure()
	plt.pcolor(X, Y, Z, cmap='spectral')
	plt.colorbar()
	plt.axis([t[0], t[-1], f[0], f[-1]])
	plt.show()