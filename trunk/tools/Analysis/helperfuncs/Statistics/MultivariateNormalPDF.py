import numpy as np

def MultivariateNormalPDF(x, mu, sigma):
	D = float(sigma.shape[0])

	return np.exp( -0.5 * np.dot( np.dot( x-mu, np.linalg.inv(sigma) ), x-mu ) ) / ( (2*np.pi)**(D/2) * (np.linalg.det(sigma))**0.5 )