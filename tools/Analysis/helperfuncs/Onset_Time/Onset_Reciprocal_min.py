from Onset_Method1 import Onset_Method1
from Fitnes_Reciprocal import Fitnes_Reciprocal


def Onset_Reciprocal(y, T, skip_samples=20) :
	return Onset_Method1(y, T, Fitnes_Function=Fitnes_Reciprocal, skip_samples=skip_samples)
