import numpy as np
import matplotlib.pyplot as plt
import matplotlib.mlab as mlab
import GMM_estimate_EM as EM


def PlotTDHist(x, fitcurve=False, x_lim_min=None, x_lim_max=None, qty=None, pickbest=20, Gauss_num=1):

	fig = plt.figure()
	ax = fig.add_subplot(111)

	if pickbest is not None and qty is not None:
		x = (np.array(x)[np.argsort(qty)])[-pickbest:]

	# the histogram of the data
	n, bins, patches = ax.hist(x, 25, normed=1, facecolor='green', alpha=0.75)

	if fitcurve:
	# hist uses np.histogram under the hood to create 'n' and 'bins'.
	# np.histogram returns the bin edges, so there will be 50 probability
	# density values in n, 51 bin edges in bins and 50 patches.  To get
	# everything lined up, we'll compute the bin centers
		bincenters = 0.5*(bins[1:]+bins[:-1])

		ax.hold('on')

		alpha0 = np.ones(Gauss_num)
		mu0 = np.ones(Gauss_num)
		mu0[0] = 10
		mu0[1] = 100
		sigma0 = np.ones(Gauss_num)*100
		sigma0[0] = 1.0
		sigma0[1] = 8.0

		alpha, mu, sigma = EM.GMM_estimate_EM(x, alpha0, mu0, sigma0)
		# add a 'best fit' lines for the normal PDF
		for k in xrange(Gauss_num):
			y = mlab.normpdf( bincenters, mu[k], sigma[k] ) * alpha[k]
			l = ax.plot(bincenters, y, 'r--', linewidth=1)

	ax.set_xlabel('Time differences [usec]')
	ax.set_ylabel('Probability')
	title = r'$\mathrm{Histogram\ of\ TD}'
	if fitcurve:
		for k in xrange(Gauss_num):
			title += r'\\ \mu_%d=%.2f,\ \sigma_%d=%.2f'%(k+1, mu[k], k+1, sigma[k])
	title += r'$'
	ax.set_title(title)

	if x_lim_min is not None and x_lim_max is not None:
		ax.set_xlim(x_lim_min, x_lim_max)
		#ax.set_ylim(0, 0.03)
		ax.grid(True)



################################################################################
if __name__ == "__main__":
	PlotTDHist(np.array([1, 2, 3, 4, 50, 55, 56, 58]), fitcurve=True, x_lim_min=None, x_lim_max=None, qty=None, pickbest=20, Gauss_num=2)