import numpy as np
import MultivariateNormalPDF as MNPDF


def print_params(alpha, mu, sigma, Gnum):
#	temp_str = 'alpha: '
#	for jj in xrange(Gnum):
#		temp_str += '%.2f, ' % alpha[jj]
#	print temp_str
#
#	temp_str = 'mu: '
#	for jj in xrange(Gnum):
#		temp_str += '%.2f, ' % mu[jj]
#	print temp_str
#
#	temp_str = 'sigma: '
#	for jj in xrange(Gnum):
#		temp_str += '%.2f, ' % sigma[jj]
#	print temp_str
	print 'alpha: '
	print alpha
	print 'mu: '
	print mu
	print 'sigma: '
	print sigma



def likelihood(x, alpha, mu, sigma):
	N = x.shape[0]
	G = alpha.size
	small_float = 1e-300

	l = 0.0
	for n in xrange(N):
		temp = 0.0
		for g in xrange(G):
			temp += alpha[g] * MNPDF.MultivariateNormalPDF(x[n,:], mu[g,:], sigma[:,:,g])
			if temp == 0.0:
				temp = small_float
		l += np.log(temp)
	return l



#def GMM_estimate_EM(x, alpha = None, mu = None, sigma = None, Gnum = None, iterations = 10) :
def GMM_estimate_EM(x, alpha = None, mu = None, sigma = None, iterations = 10) :
#	if x is None or ( (alpha is None or mu is None or sigma is None) and Gnum is None ):
	if x is None or ( alpha is None or mu is None or sigma is None ):
		return

	x = np.array(x, dtype='float64')
	if x.size == 0 :
		return

#	if Gnum is None:
#		if alpha is None or mu is None or sigma is None:
#			return

#		if alpha.size != mu.size or alpha.size != sigma.size :
#			return

#		if alpha.size == 0 :
#			return

#	if Gnum is not None and Gnum == 0:
#		return

#	x = x.astype('float64')

#	if Gnum is not None:
#		alpha = np.ones(Gnum, dtype='float64')
#		mu = np.zeros(Gnum, dtype='float64')
#		sigma = np.zeros(Gnum, dtype='float64')
#
#		step = (np.amax(x) - np.amin(x))/(Gnum-1)
#		for ii in xrange(Gnum):
#			mu[ii] = np.amin(x) + ii*step
#
#		st = np.sqrt( np.var(x, dtype=np.float64) )
#		for ii in xrange(Gnum):
#			sigma[ii] = st

	x = x.astype('float64')
	alpha = alpha.astype('float64')
	mu = mu.astype('float64')
	sigma = sigma.astype('float64')

	x = np.reshape( x, (x.shape[0], -1) )
	mu = np.reshape( mu, (mu.shape[0], -1) )


	alpha /= np.sum(alpha)

	N = x.shape[0]
	D = sigma.shape[0]
	G = alpha.size

	L = likelihood(x, alpha, mu, sigma)

	print 'Iterations left: %d' % (iterations)
#	print 'Starter:'
#	print_params(alpha, mu, sigma, K)
#	print 'Likelihood: %.2f' % (L)

	r = np.zeros((N, G))
	for n in xrange(N):
		for g in xrange(G):
			denom = 0.0
			for j in xrange(G):
				denom += alpha[j] * MNPDF.MultivariateNormalPDF( x[n,:], mu[j,:], sigma[:,:,j] )

			r[n, g] = alpha[g] * MNPDF.MultivariateNormalPDF( x[n,:], mu[g,:], sigma[:,:,g] ) / denom

	Nk = np.zeros(G)
	for g in xrange(G):
		for n in xrange(N):
			Nk[g] += r[n, g]


	alpha_new = np.zeros(G)
	mu_new = np.zeros((G,D))
	sigma_new = np.zeros((D,D,G))
	for g in xrange(G):
		alpha_new[g] = Nk[g] / N

		for n in xrange(N):
			mu_new[g,:] += r[n,g]*x[n,:]
		mu_new[g,:] /= Nk[g]


		for n in xrange(N):
			sigma_new[:,:,g] += r[n,g] * np.outer( x[n,:] - mu_new[g,:],  x[n,:] - mu_new[g,:] )
		sigma_new[:,:,g] /= Nk[g]
#		sigma_new[k] = np.sqrt(sigma_new[k])

#####
	L_new = likelihood(x, alpha_new, mu_new, sigma_new)

#	print 'Result:'
	print_params(alpha_new, mu_new, sigma_new, G)
	print 'Likelihood: %.2f' % (L_new)

	if L_new == 0.0 or np.isnan(L_new):
		if iterations > 1:
			return GMM_estimate_EM(x, alpha_new, mu_new, sigma_new, iterations = iterations-1)
		else:
			return alpha_new, mu_new, sigma_new
	else:
		good_change = 0.01
		change = np.abs(L_new - L)
		change = change/np.abs(L_new)
		print 'change: %.2f%%' % (change*100)
		if change <= good_change:
			return alpha_new, mu_new, sigma_new
		else:
			return GMM_estimate_EM(x, alpha_new, mu_new, sigma_new, iterations = iterations)


################################################################################
if __name__ == "__main__":
	alpha0 = np.array([0.5, 0.5, 0.5])
	mu0 = np.array([[10.0, 10.0], [100.0, 100.0], [50.0, 50.0]])
	sigma0 = np.array( [[[1.0, 8.0, 1.0],[0.0, 0.0, 0.0]], [[0.0, 0.0, 0.0],[1.0, 8.0, 0.3]]] )

	x = np.array([[10.0, 10.4], [10.2, 10.2], [10.3, 10.4], [50.4, 50.9], [103, 97], [110, 100], [96, 90], [49, 54]])

	alpha, mu, sigma = GMM_estimate_EM(x, alpha0, mu0, sigma0)