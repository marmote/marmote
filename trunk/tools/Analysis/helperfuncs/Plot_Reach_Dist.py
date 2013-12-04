import matplotlib.pyplot as plt
import numpy as np

def Plot_Reach_Dist(y, xlabel=None):
	fig, axarr = plt.subplots(1, 1, sharex=True)
#	axarr = axarr.flat


	axarr.plot(y, 'b',  lw=2)
	axarr.set_title('Time series')
	axarr.set_ylabel('Sample []')

	if xlabel is not None:
		axarr.set_xlabel(xlabel)
