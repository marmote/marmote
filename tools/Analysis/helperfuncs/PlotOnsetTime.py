import matplotlib.pyplot as plt
import numpy as np

def PlotOnsetTime(y, curves, T, onset):
	fig, axarr = plt.subplots(len(curves)+1, 1, sharex=True)
	axarr = axarr.flat


	t_y = np.arange(y.size)*T
	axarr[0].plot(t_y, y, 'b', [onset, onset], [np.amin(y), np.amax(y)] , 'r')

	for ii in xrange(len(curves)):
		t = (np.arange(curves[ii][1].size) + curves[ii][2])*T
		axarr[ii+1].plot(t, curves[ii][1], 'b', [onset, onset], [np.amin(curves[ii][1]), np.amax(curves[ii][1])], 'r')
		axarr[ii+1].set_title(curves[ii][0])
