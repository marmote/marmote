import numpy as np


def power(x,n):
	return -(x**n)


def Onset_Power(y, T, skip_samples=20, exponent=64) :
	if skip_samples < 2:
		skip_samples = 2

	skip_samples = int(np.rint(skip_samples))

	N = y.size
	if 2*skip_samples > N:
		return

	output = np.zeros(N - 2*skip_samples + 1)

	for i in xrange( skip_samples, N-skip_samples+1 ):
		var1 = np.var( y[:i] )
		var2 = np.var( y[i:] )

		output[i-skip_samples] = i * power(1.0 - var1, exponent) + (N - i) * power(1.0 - var2, exponent)

	return float(np.argmin(output)+skip_samples-0.5) * T, output
