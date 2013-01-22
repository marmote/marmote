import matplotlib.pyplot as plt
import numpy as np

def PlotAIC(y, AIC, T, onset):
	t_y = np.arange(y.size)*T
	t_AIC = np.arange(AIC.size)*T
	t_dAIC = np.arange(AIC.size-1)*T

	dAIC = []
	for ii in xrange(AIC.size-1):
		dAIC.append(AIC[ii+1] - AIC[ii])

	fig, axarr = plt.subplots(3, 1, sharex=True)
	axarr = axarr.flat
	axarr[0].plot(t_y, y, 'b', [onset, onset], [np.amin(y), np.amax(y)] , 'r')
	axarr[1].plot(t_AIC, AIC, 'b', [onset, onset], [np.amin(AIC), np.amax(AIC)], 'r')
	axarr[2].plot(t_dAIC, dAIC, 'b', [onset, onset], [np.amin(dAIC), np.amax(dAIC)], 'r')
	axarr[2].set_ylim(-10, 10)
	#axarr[2].set_xlim(onset-20, onset+20)