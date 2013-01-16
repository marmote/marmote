import numpy as np

def Onset_Threshold(y, T, th_cross_level = 0.15) :
	max_val = float(np.amax(np.absolute(y)))
	val = 0
	for jj in xrange(y.size) :
		if np.absolute(y[jj]) >= max_val*th_cross_level : 
			val = jj
			break
	return float(val) * T
