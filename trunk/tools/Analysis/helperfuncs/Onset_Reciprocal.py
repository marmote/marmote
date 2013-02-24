import numpy as np


def Onset_Reciprocal(y, T, skip_samples=20) :
	if skip_samples < 2:
		skip_samples = 2

	skip_samples = int(np.rint(skip_samples))

	N = y.size
	if 2*skip_samples > N:
		return

	fitnes = np.zeros(N - 2*skip_samples + 1)

	for i in xrange( skip_samples, N-skip_samples+1 ):
		var1 = np.var( y[:i] )
		var2 = np.var( y[i:] )
		fitnes[i-skip_samples] = -i/var1 + -(N - i)/var2
#		fitnes[i-2] = -1/var1 + -1/var2

	return float(np.argmin(fitnes)+skip_samples-0.5) * T, fitnes
