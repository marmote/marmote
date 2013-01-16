import numpy as np

def costum_var(R, R_mean, N):
	if N == 1:
	    print 'Error: N==1'

	Acc = 0.0
	for i in xrange(R.size):
		Acc += (R[i] - R_mean)**2

	return Acc / (N - 1)


def Onset_AIC(y, T) :
	N = y.size

	AIC = np.zeros(N-1)
	y_mean = np.mean(y)

	for i in xrange(AIC.size):
		AIC[i] = (i+1) * np.log( costum_var( np.array(y[:i+1]), y_mean, N ) ) + (N - i+1 - 1) * np.log( costum_var( np.array(y[i+1:]), y_mean, N ) )

	return float(np.argmin(AIC)) * T, AIC
