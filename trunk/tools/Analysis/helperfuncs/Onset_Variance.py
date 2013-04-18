import numpy as np
from Fitnes_var import Fitnes_var


def Onset_Variance(y, T, skip_samples=20) :
	fitnes, sample_shift = Fitnes_var(y, skip_samples=skip_samples, LeftFromIdx=True)
	fitnes2, sample_shift2 = Fitnes_var(y, skip_samples=skip_samples, LeftFromIdx=False)
	fitnes3, sample_shift3 = Fitnes_var(y, skip_samples=skip_samples, LeftFromIdx=True, MultiplyWithIdx=True)
	fitnes4, sample_shift4 = Fitnes_var(y, skip_samples=skip_samples, LeftFromIdx=False, MultiplyWithIdx=True)
	fitnes5, sample_shift5 = Fitnes_var(y, skip_samples=skip_samples, LeftFromIdx=True, PowerWithIdx=True)
	fitnes6, sample_shift6 = Fitnes_var(y, skip_samples=skip_samples, LeftFromIdx=False, PowerWithIdx=True)
	fitnes7, sample_shift7 = Fitnes_var(y, skip_samples=skip_samples, LeftFromIdx=True, S1=True)
	fitnes8, sample_shift8 = Fitnes_var(y, skip_samples=skip_samples, LeftFromIdx=True, S2=True)

	curves = []
	curves.append(('Variance left', fitnes, sample_shift))
	curves.append(('Variance right', fitnes2, sample_shift2))
	curves.append(('(N/n - 1)*Variance left', fitnes7, sample_shift7))
	curves.append(('Variance left ^ (n/(M-n))', fitnes8, sample_shift8))
	curves.append(('1/Variance left', 1/fitnes, sample_shift))
	curves.append(('1/Variance right', 1/fitnes2, sample_shift2))
	curves.append(('n/Variance left', fitnes3, sample_shift3))
	curves.append(('(N-n)/Variance right', fitnes4, sample_shift4))
	curves.append(('n/Variance left + (N-n)/Variance right', fitnes3+fitnes4, sample_shift4))
	curves.append(('ln Variance left', np.log(fitnes), sample_shift))
	curves.append(('ln Variance right', np.log(fitnes2), sample_shift2))
	curves.append(('n * ln Variance left', fitnes5, sample_shift5))
	curves.append(('n * ln Variance left/10', fitnes5/10, sample_shift5))
	curves.append(('n * ln Variance left/20', fitnes5/20, sample_shift5))
	curves.append(('n * ln Variance left/100', fitnes5/100, sample_shift5))
	curves.append(('(N-n) * ln Variance right', fitnes6, sample_shift6))
	curves.append(('n * ln Variance left + (N-n) * ln Variance right', fitnes5 + fitnes6, sample_shift6))

	onset_idx = np.argmin(-fitnes3)

	return (sample_shift3 + onset_idx)*T, 1, curves