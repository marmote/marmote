import numpy as np



def print_params(alpha, mu, sigma, Gnum):
	temp_str = 'alpha: '
	for jj in xrange(Gnum):
		temp_str += '%.2f, ' % alpha[jj]
	print temp_str

	temp_str = 'mu: '
	for jj in xrange(Gnum):
		temp_str += '%.2f, ' % mu[jj]
	print temp_str

	temp_str = 'sigma: '
	for jj in xrange(Gnum):
		temp_str += '%.2f, ' % sigma[jj]
	print temp_str


def normal_dist(x, mu, sigma):
	return np.exp((x-mu)**2 / (-2*sigma**2)) / (sigma * np.sqrt(2*np.pi)) 


def likelihood(x, alpha, mu, sigma):
	N = x.size
	K = alpha.size

	l = 0.0
	for n in xrange(N):
		temp = 0.0
		for k in xrange(K):
			temp += alpha[k] * normal_dist(x[n], mu[k], sigma[k])
		l += np.log(temp)
	return l



def GMM_estimate_EM(x, alpha = None, mu = None, sigma = None, Gnum = None, iterations = 10) :
	if x is None or ( (alpha is None or mu is None or sigma is None) and Gnum is None ):
		return

	x = np.array(x, dtype='float64')
	if x.size == 0 :
		return

	if Gnum is None:
#		if alpha is None or mu is None or sigma is None:
#			return

		if alpha.size != mu.size or alpha.size != sigma.size :
			return

		if alpha.size == 0 :
			return

	if Gnum is not None and Gnum == 0:
		return

#	x = x.astype('float64')

	if Gnum is not None:
		alpha = np.ones(Gnum, dtype='float64')
		mu = np.zeros(Gnum, dtype='float64')
		sigma = np.zeros(Gnum, dtype='float64')

		step = (np.amax(x) - np.amin(x))/(Gnum-1)
		for ii in xrange(Gnum):
			mu[ii] = np.amin(x) + ii*step

		st = np.sqrt( np.var(x, dtype=np.float64) )
		for ii in xrange(Gnum):
			sigma[ii] = st


	alpha = alpha.astype('float64')
	mu = mu.astype('float64')
	sigma = sigma.astype('float64')


	alpha /= np.sum(alpha)

	N = x.size
	K = alpha.size


	L = likelihood(x, alpha, mu, sigma)

	print 'Iterations left: %d' % (iterations)
#	print 'Starter:'
#	print_params(alpha, mu, sigma, K)
#	print 'Likelihood: %.2f' % (L)

	r = np.zeros((N, K))
	for n in xrange(N):
		for k in xrange(K):
			denom = 0.0
			for j in xrange(K):
				denom += alpha[j] * normal_dist(x[n], mu[j], sigma[j])

			r[n, k] = ( alpha[k] * normal_dist(x[n], mu[k], sigma[k]) ) / denom

	Nk = np.zeros(K)
	for k in xrange(K):
		for n in xrange(N):
			Nk[k] += r[n, k]


	mu_new = np.zeros(K)
	alpha_new = np.zeros(K)
	sigma_new = np.zeros(K)
	for k in xrange(K):
		alpha_new[k] = Nk[k] / N

		for n in xrange(N):
			mu_new[k] += r[n,k]*x[n]
		mu_new[k] /= Nk[k]


		for n in xrange(N):
			sigma_new[k] += r[n,k] * ( x[n] - mu_new[k] )**2 
		sigma_new[k] /= Nk[k]
		sigma_new[k] = np.sqrt(sigma_new[k])

#####
	L_new = likelihood(x, alpha_new, mu_new, sigma_new)

#	print 'Result:'
	print_params(alpha_new, mu_new, sigma_new, K)
	print 'Likelihood: %.2f' % (L_new)

	if L_new == 0.0:
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
	alpha0 = np.array([0.5, 0.5])
	mu0 = np.array([10.0, 100.0])
	sigma0 = np.array([1.0, 8.0])

	x = np.array([1, 2, 3, 4, 50, 55, 56, 58])

	alpha, mu, sigma = GMM_estimate_EM(x, alpha0, mu0, sigma0)