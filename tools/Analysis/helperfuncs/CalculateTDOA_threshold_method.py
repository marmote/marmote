import Onset_Threshold as OT
import numpy as np

def CalculateTDOA_threshold_method(y, y2, T, th_cross_level = 0.15) :
	AE_start = np.zeros(len(y), dtype='float64')
	AE_start2 = np.zeros(len(y), dtype='float64')
	TD_meas = np.zeros(len(y), dtype='float64')
	
	for ii in xrange(len(y)) :
		AE_start[ii] = OT.Onset_Threshold(y[ii], T, th_cross_level ) 
		AE_start2[ii] = OT.Onset_Threshold(y2[ii], T, th_cross_level ) 
		
		TD_meas[ii] = AE_start2[ii] - AE_start[ii]
		
	return AE_start, AE_start2, TD_meas
