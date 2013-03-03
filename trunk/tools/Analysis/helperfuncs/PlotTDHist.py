import numpy as np
import matplotlib.pyplot as plt
import matplotlib.mlab as mlab
import GMM_estimate_EM as EM


def PlotTDHist(x, fitcurve=False, xlim_min=None, xlim_max=None, alpha=None, mu=None, sigma=None):

	fig = plt.figure()
	ax = fig.add_subplot(111)

	# the histogram of the data
	n, bins, patches = ax.hist(x, 25, normed=True, facecolor='green', alpha=0.75)

	if xlim_min is None:
		xlim_min = ax.get_xlim()[0]
	if xlim_max is None:
		xlim_max = ax.get_xlim()[1]

	ax.grid(True)

	if fitcurve:
		bincenters = np.linspace( ax.get_xlim()[0], ax.get_xlim()[1], 100 )
		# add a 'best fit' lines for the normal PDF
		ax.hold('on')
		for k in xrange(alpha.size):
			y = mlab.normpdf( bincenters, mu[k], sigma[k] ) * alpha[k]
			l = ax.plot(bincenters, y, 'r--', linewidth=1)
		ax.hold('off')

	ax.set_xlabel('Time differences [msec]')
	ax.set_ylabel('Probability')
	title = r'$\mathrm{Histogram\ of\ TD}$'
	if fitcurve:
		for k in xrange(alpha.size):
			title += '\n' + r'$\alpha_%d=%.4f$,'%(k+1, alpha[k]) + '\t' + r'$\mu_%d=%.4f$,'%(k+1, mu[k]) + '\t' + r'$\sigma_%d=%.4f$'%(k+1, sigma[k])
#	title += r'$'
	ax.set_title(title)

	ax.set_xlim([xlim_min, xlim_max])


################################################################################
if __name__ == "__main__":
	PlotTDHist(np.array([1, 2, 3, 4, 50, 55, 56, 58]), fitcurve=False, x_lim_min=None, x_lim_max=None)