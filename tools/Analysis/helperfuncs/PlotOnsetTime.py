import matplotlib.pyplot as plt
import numpy as np

def PlotOnsetTime(y, OnsetFitnes, T, onset):
	t_y = np.arange(y.size)*T
	skip_samples = int( (y.size - OnsetFitnes.size + 1)/2 )
	t_OnsetFitnes = (np.arange(OnsetFitnes.size) + skip_samples -0.5)*T
	t_dOnsetFitnes = (np.arange(OnsetFitnes.size-1) + skip_samples)*T

	dOnsetFitnes = OnsetFitnes[1:] - OnsetFitnes[:-1]

	fig, axarr = plt.subplots(3, 1, sharex=True)
	axarr = axarr.flat
	axarr[0].plot(t_y, y, 'b', [onset, onset], [np.amin(y), np.amax(y)] , 'r')
	axarr[1].plot(t_OnsetFitnes, OnsetFitnes, 'b', [onset, onset], [np.amin(OnsetFitnes), np.amax(OnsetFitnes)], 'r')
	axarr[2].plot(t_dOnsetFitnes, dOnsetFitnes, 'b', [onset, onset], [np.amin(dOnsetFitnes), np.amax(dOnsetFitnes)], 'r')
#	axarr[2].set_ylim(-10, 10)
	#axarr[2].set_xlim(onset-20, onset+20)