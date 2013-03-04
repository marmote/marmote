import numpy as np

def CalculateLinearRegression(X, Y):
	N = min(X.size, Y.size)
	X = X[:N]
	Y = Y[:N]

	X_mean = np.mean(X)
	Y_mean = np.mean(Y)

	s_X = np.sqrt(np.var(X))
	s_Y = np.sqrt(np.var(Y))

	R = 0.0
	for ii in xrange(N):
		R += (X[ii] - X_mean)*(Y[ii] - Y_mean)
	R /= s_X*s_Y*N

	a = R*s_Y/s_X
	b = Y_mean - a*X_mean

	return a, b