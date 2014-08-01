import numpy as np


def log_Taylor(x, n):
	result = 0.0
	for i in xrange(n):
		result -= (x**(i+1))/(i+1)
	return result


def Fitnes_lnTaylor(y, skip_samples=20, order=64) :
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

		fitnes[i-skip_samples] = i * log_Taylor(1.0 - var1, order)  + (N - i) * log_Taylor(1.0 - var2, order)

	fitnes /= np.amax(np.abs(fitnes))
	return fitnes, skip_samples-0.5
