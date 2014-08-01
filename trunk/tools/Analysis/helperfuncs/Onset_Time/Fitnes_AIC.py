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


def Fitnes_AIC(y, skip_samples=20) :
	if skip_samples < 2:
		skip_samples = 2

	skip_samples = int(np.rint(skip_samples))

	N = y.size
	if 2*skip_samples > N:
		return

#	Nminus1 = N - 1

	fitnes = np.zeros(N - 2*skip_samples + 1)
#	y_mean = np.mean(y)

	for i in xrange( skip_samples, N-skip_samples+1 ):
#		fitnes[i] = (i+1) * np.log( costum_var( np.array(y[:i+1]), y_mean, N ) ) + (N - i+1 - 1) * np.log( costum_var( np.array(y[i+1:]), y_mean, N ) )
#		fitnes[i] = (i+1) * np.log( costum_var( y[:i+1], y_mean, Nminus1 ) ) + (N - i+1 - 1) * np.log( costum_var( y[i+1:], y_mean, Nminus1 ) )
		fitnes[i-skip_samples] = i * np.log( np.cov( y[:i] ) + 1e-300 ) + (N - i) * np.log( np.cov( y[i:] ) + 1e-300 )

	fitnes /= np.amax(np.abs(fitnes))
	return fitnes, skip_samples-0.5
