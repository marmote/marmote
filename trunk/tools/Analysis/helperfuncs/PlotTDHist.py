import numpy as np
import matplotlib.pyplot as plt
import matplotlib.mlab as mlab

def PlotTDHist(x, fitcurve=False, x_lim_min=None, x_lim_max=None):

    fig = plt.figure()
    ax = fig.add_subplot(111)

    # the histogram of the data
    n, bins, patches = ax.hist(x, 25, normed=1, facecolor='green', alpha=0.75)

    if fitcurve:
	# hist uses np.histogram under the hood to create 'n' and 'bins'.
	# np.histogram returns the bin edges, so there will be 50 probability
	# density values in n, 51 bin edges in bins and 50 patches.  To get
	# everything lined up, we'll compute the bin centers
	bincenters = 0.5*(bins[1:]+bins[:-1])
	# add a 'best fit' line for the normal PDF
	mu = np.mean(x, dtype=np.float64)
	sigma = np.sqrt( np.var(x, dtype=np.float64) )
	y = mlab.normpdf( bincenters, mu, sigma)
	l = ax.plot(bincenters, y, 'r--', linewidth=1)

    ax.set_xlabel('Time differences [usec]')
    ax.set_ylabel('Probability')
    if fitcurve:
	ax.set_title(r'$\mathrm{Histogram\ of\ TD:}\ \mu=%.2f,\ \sigma=%.2f$'%(mu, sigma))
    else:
	ax.set_title(r'$\mathrm{Histogram\ of\ TD}$')

    if x_lim_min is not None and x_lim_max is not None:
	ax.set_xlim(x_lim_min, x_lim_max)
    #ax.set_ylim(0, 0.03)
    ax.grid(True)