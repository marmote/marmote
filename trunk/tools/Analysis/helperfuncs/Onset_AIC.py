import numpy as np

def costum_var(R, R_mean, Nminus1):
	if N == 0:
	    print 'Error: N==1'

#	Acc = 0.0
#Implementation 1
#	for i in xrange(R.size):
#		Acc += (R[i] - R_mean)**2
#Implementation 2
#	for Ri in R:
#		Acc += (Ri - R_mean)**2
#	Acc = np.sum((R-R_mean)**2)

#	return Acc / (N - 1)
	return np.sum((R-R_mean)**2) / Nminus1


def Onset_AIC(y, T) :
	N = y.size
#	Nminus1 = N - 1

	AIC = np.zeros(N-3)
#	y_mean = np.mean(y)

	for i in xrange(2,N-1):
#		AIC[i] = (i+1) * np.log( costum_var( np.array(y[:i+1]), y_mean, N ) ) + (N - i+1 - 1) * np.log( costum_var( np.array(y[i+1:]), y_mean, N ) )
#		AIC[i] = (i+1) * np.log( costum_var( y[:i+1], y_mean, Nminus1 ) ) + (N - i+1 - 1) * np.log( costum_var( y[i+1:], y_mean, Nminus1 ) )
		AIC[i-2] = i * np.log( np.cov( y[:i] ) + 1e-300 ) + (N - i) * np.log( np.cov( y[i:] ) + 1e-300 )

	return float(np.argmin(AIC)+2-0.5) * T, AIC
