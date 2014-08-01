import numpy as np


def Fitnes_Reciprocal(y, skip_samples=20) :
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
#		fitnes[i-skip_samples] = np.sum(xrange(i+1))*(1 - 1/var1) + np.sum(xrange(N - i+1))*(1- 1/var2)
#		fitnes[i-skip_samples] = -i/(var1**(1.0/3)) + -(N - i)/(var2**(1.0/3))
#		fitnes[i-skip_samples] = -i/(var1**(1.0/2)) + -(N - i)/(var2**(1.0/2))
#		fitnes[i-2] = -1/var1 + -1/var2

	fitnes /= np.amax(np.abs(fitnes))
	return fitnes, skip_samples-0.5
