from Onset_Method1 import Onset_Method1


def Onset_AIC(y, T, skip_samples=20) :
	return Onset_Method1(y, T, Fitnes_Function=None, skip_samples=skip_samples)
