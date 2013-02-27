import numpy as np
from Threshold import Threshold

def Onset_Threshold(y, T, th_cross_level = 0.15) :
	max_val = float(np.amax(np.absolute(y)))

	onset_idx = Threshold(y, max_val*th_cross_level)
	quality = 1

	curves = []

	return onset_idx*T, quality, curves
