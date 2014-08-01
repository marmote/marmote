import numpy as np

def CalculateQuality(fitnes, qty_len) :
	small_float = 1e-300

	start_idx = np.argmin(fitnes) + 1
	if start_idx >= fitnes.size :
		return small_float
	else:
		stop_idx = min( start_idx + qty_len, fitnes.size )
		return np.mean(fitnes[start_idx:stop_idx] - fitnes[start_idx-1:stop_idx-1])


def CalculateTDOA(y, y2, T, OnsetTimeCalculator, qty_len=40) :
	AE_start = np.zeros(len(y), dtype='float64')
	AE_start2 = np.zeros(len(y), dtype='float64')
	TD_meas = np.zeros(len(y), dtype='float64')
	qty1 = np.zeros(len(y), dtype='float64')
	qty2 = np.zeros(len(y), dtype='float64')
	
	for ii in xrange(len(y)) :
		print '%.2f%%'%(float(ii)/len(y)*100)

		AE_start[ii], qty1[ii], dummy  = OnsetTimeCalculator( y[ii], T )
		AE_start2[ii], qty2[ii], dummy = OnsetTimeCalculator( y2[ii], T )
		
		TD_meas[ii] = AE_start2[ii] - AE_start[ii]

	return AE_start, AE_start2, TD_meas, qty1, qty2
