import numpy as np

def Threshold(y, th_cross_level, FromStart = True) :
	val = 0
	if FromStart:
		for jj in xrange(y.size) :
			if np.absolute(y[jj]) >= th_cross_level : 
				val = jj
				break
	else:
		for jj in xrange(y.size-1, -1, -1) :
			if np.absolute(y[jj]) >= th_cross_level : 
				val = jj
				break

	return val
