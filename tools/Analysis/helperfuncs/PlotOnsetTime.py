import matplotlib.pyplot as plt
import numpy as np

def PlotOnsetTime(y, curves, T, onset, xlabel=None):
	fig, axarr = plt.subplots(len(curves)+1, 1, sharex=True)
	axarr = axarr.flat


	t_y = np.arange(y.size)*T
	axarr[0].plot(t_y, y, 'b', [onset, onset], [np.amin(y), np.amax(y)] , 'r')
	axarr[0].set_title('Time series')
	axarr[0].set_ylabel('Sample []')

	for ii in xrange(len(curves)):
		t = (np.arange(curves[ii][1].size) + curves[ii][2])*T
		axarr[ii+1].plot(t, curves[ii][1], 'b', [onset, onset], [np.amin(curves[ii][1]), np.amax(curves[ii][1])], 'r')
		axarr[ii+1].set_title(curves[ii][0])
		if len(curves[ii]) > 3:
			axarr[ii+1].set_ylim([curves[ii][3][0], curves[ii][3][1]])

	if xlabel is not None:
		axarr[-1].set_xlabel(xlabel)

	height_factor = 2
	if len(curves) >= height_factor:
		w,h = fig.get_size_inches()
		fig.set_size_inches(w,(len(curves)+1)*h/height_factor)