import matplotlib.pyplot as plt
import numpy as np

def PlotHistory(qty, TD, qty_th, TD_min, TD_max, start_time, xlim_min, xlim_max, ylim_min, ylim_max):
	fig, ax = plt.subplots(1, 1, sharex=True, sharey=True ) 

	idx = np.intersect1d(np.array(np.where(TD>=TD_min)), np.array(np.where(TD<=TD_max)))
	temp = qty[idx]
	idx2 = np.where(temp>=qty_th)

	time = np.array((np.array(start_time)[idx])[idx2]) + np.array((TD[idx])[idx2])
	time -= start_time[0]
	#time /= 60
	ax.plot(time, temp[idx2], '.')
	ax.vlines(time, [0], temp[idx2])

#    ax.set_xlabel(xlabel)
#    ax.set_ylabel(ylabel)
	ax.set_xlim(xlim_min, xlim_max)
	ax.set_ylim(ylim_min, ylim_max) 

	ax.set_xlabel('time [sec]')
	ax.set_ylabel('quality idx []') 