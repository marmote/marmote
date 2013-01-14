import numpy as np


def normal_dist(x, mu, sigma):
	return np.exp((x-mu)**2 / (-2*sigma**2)) / (sigma * np.sqrt(2*np.pi)) 


def GMM_estimate_EM(x, alpha, mu, sigma) :
	if x is None or alpha is None or mu is None or sigma is None :
		return

	if alpha.size != mu.size or alpha.size != sigma.size :
		return

	if x.size == 0 or alpha.size == 0 :
		return

	x = x.astype('float64')
	alpha = alpha.astype('float64')
	mu = mu.astype('float64')
	sigma = sigma.astype('float64')

	alpha /= np.sum(alpha)

	N = x.size
	K = alpha.size


	likelihood = 1.0
	for n in xrange(N):
		temp = 0.0
		for k in xrange(K):
			temp += alpha[k] * normal_dist(x[n], mu[k], sigma[k])
		likelihood *= temp



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
		for n in xrange(N):
			mu_new[k] += r[n,k]*x[n]
		mu_new[k] /= Nk[k]


		for n in xrange(N):
			sigma_new[k] += r[n,k] * ( x[n] - mu_new[k] )**2 
		sigma_new[k] /= Nk[k]

		alpha_new[k] = Nk[k] / N
#####
	likelihood_new = 1.0
	for n in xrange(N):
		temp = 0.0
		for k in xrange(K):
			temp += alpha_new[k] * normal_dist(x[n], mu_new[k], sigma_new[k])
		likelihood_new *= temp


	good_change = 0.0005
	if np.abs((likelihood_new - likelihood) / likelihood_new) < good_change:
		return alpha_new, mu_new, sigma_new
	else:
		return GMM_estimate_EM(x, alpha_new, mu_new, sigma_new)


################################################################################
if __name__ == "__main__":
	alpha0 = np.array([0.5, 0.5])
	mu0 = np.array([10.0, 100.0])
	sigma0 = np.array([1.0, 8.0])

	x = np.array([1, 2, 3, 4, 50, 55, 56, 58])

	alpha, mu, sigma = GMM_estimate_EM(x, alpha0, mu0, sigma0)