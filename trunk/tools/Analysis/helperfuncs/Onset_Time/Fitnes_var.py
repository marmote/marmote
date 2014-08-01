import numpy as np


def Fitnes_var(y, skip_samples=20, LeftFromIdx=True, MultiplyWithIdx=False, PowerWithIdx=False, S1=False, S2=False) :
	if skip_samples < 2:
		skip_samples = 2

	skip_samples = int(np.rint(skip_samples))

	N = y.size
	if 2*skip_samples > N:
		return

	fitnes = np.zeros(N - 2*skip_samples + 1)

	for i in xrange( skip_samples, N-skip_samples+1 ):
		if LeftFromIdx:
			var = np.var( y[:i] )
			idx = i
		else:
			var = np.var( y[i:] )
			idx = N - i

		if MultiplyWithIdx:
			fitnes[i-skip_samples] = idx / var
		elif PowerWithIdx:
			fitnes[i-skip_samples] = idx * np.log(var)
		elif S1:
			fitnes[i-skip_samples] = (N/idx - 1) * var
		elif S2:
			fitnes[i-skip_samples] = var ** (idx/(N-idx))
		else:
			fitnes[i-skip_samples] = var

#	fitnes /= np.amax(np.abs(fitnes))
	return fitnes, skip_samples-0.5
