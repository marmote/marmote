import numpy as np
from Diff import Diff


def CalculateQuality(fitnes, idx, qty_len) :
	small_float = 1e-300

	if idx >= fitnes.size :
		return small_float
	else:
		start_idx = idx
		stop_idx = min( start_idx + qty_len, fitnes.size )
		return np.mean( fitnes[start_idx:stop_idx] )



def Onset_Method1(y, T, Fitnes_Function=None, skip_samples=20) :
	if Fitnes_Function is None:
		from Fitnes_AIC import Fitnes_AIC
		Fitnes_Function = Fitnes_AIC

	fitnes, sample_shift = Fitnes_Function(y, skip_samples=skip_samples)
	fitnes2, sample_shift2 = Diff(fitnes)


	#Calculate onset time and quality
	onset_idx = np.argmin(fitnes)
	quality = CalculateQuality(fitnes2, onset_idx, qty_len=40)



	curves = []
	curves.append(('Fitness function', fitnes, sample_shift))
	curves.append(('Derivative of fitness function', fitnes2, sample_shift+sample_shift2))

	return (sample_shift + onset_idx)*T, quality, curves
