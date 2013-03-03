import matplotlib.pyplot as plt
import numpy as np

def PlotHistory(qtya, qty_th, qtyb, TD, TD_min, TD_max, start_time, xlim_min=None, xlim_max=None, ylim_min=0, ylim_max=None, title=None):
	fig, ax = plt.subplots(1, 1, sharex=True, sharey=True ) 

	idx = np.intersect1d(np.array(np.where(TD>=TD_min)), np.array(np.where(TD<=TD_max)))
	temp = qtya[idx]
	temp2 = qtyb[idx]
	idx2 = np.where(temp>=qty_th)

	time = np.array((np.array(start_time)[idx])[idx2]) + np.array((TD[idx])[idx2])
	time -= start_time[0]
	#time /= 60
	ax.hold('on')
	ax.plot(time, temp2[idx2], '.g')
	ax.vlines(time, [0], temp2[idx2], color='g')
	ax.plot(time, temp[idx2], '.b')
	ax.vlines(time, [0], temp[idx2], color='b')

#    ax.set_xlabel(xlabel)
#    ax.set_ylabel(ylabel)
	if xlim_min is None:
		xlim_min = ax.get_xlim()[0]
	if xlim_max is None:
		xlim_max = ax.get_xlim()[1]
	if ylim_min is None:
		ylim_min = ax.get_ylim()[0]
	if ylim_max is None:
		ylim_max = ax.get_ylim()[1]

	ax.set_xlim([xlim_min, xlim_max])
	ax.set_ylim([ylim_min, ylim_max])

	ax.set_xlabel('time [sec]')
	ax.set_ylabel('quality idx []')
	
	if title is not None:
		ax.set_title(title)