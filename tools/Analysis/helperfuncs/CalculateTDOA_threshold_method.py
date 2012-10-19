import numpy as np
import matplotlib.pyplot as plt

def CalculateTDOA_threshold_method(y, y2, T, th_cross_level = 0.15) :
	AE_start = []
	AE_start2 = []
	TD_meas = []
	
	for ii in xrange(len(y)) :
		I_buff = y[ii]
		Q_buff = y2[ii]

		#Find AE signal beginnings
		max_val = np.amax(np.absolute(I_buff))
		val = 0
		for jj in xrange(I_buff.size) :
			if I_buff[jj] >= max_val*th_cross_level : 
				val = jj
				break
		AE_start.append(val * T)
    
		max_val2 = np.amax(np.absolute(Q_buff))
		val = 0
		for jj in xrange(Q_buff.size) :
			if Q_buff[jj] >= max_val2*th_cross_level : 
				val = jj
				break
		AE_start2.append(val * T)
		
		TD_meas.append(AE_start2[-1] - AE_start[-1])
		
	return AE_start, AE_start2, TD_meas
