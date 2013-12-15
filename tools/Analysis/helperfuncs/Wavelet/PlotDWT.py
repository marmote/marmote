import numpy as np
import matplotlib.pyplot as plt
import matplotlib.widgets as widgets

def PlotDWT(Ts, x, c, xlim_min=0, xlim_max=1000) :
	fig, axarr = plt.subplots(len(c)+1, 1, sharex=True, sharey=False )

	time = np.arange(0, x.size)*Ts  
	axarr[0].step(time, x, where='post')

	for ii in xrange(len(c)) :
		#start_t = w.dec_len * Ts / 2
		if ii < len(c)-1 :
			Ts = Ts*2
		time = (np.arange(0, c[-ii-1].size))*Ts #- start_t      
		axarr[ii+1].step(time, c[-ii-1], '.-', where='post')
	
	if xlim_min is not None and xlim_max is not None :
		axarr[0].set_xlim(xlim_min, xlim_max)

	multi = widgets.MultiCursor(fig.canvas, axarr, color='red', lw=2)  