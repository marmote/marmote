import Onset_AIC as OT
import numpy as np

def CalculateQuality(AIC, qty_len) :
	small_float = 1e-300

	start_idx = np.argmin(AIC) + 1
	if start_idx >= AIC.size :
		return small_float
	else:
		stop_idx = min( start_idx + qty_len, AIC.size )
		return np.mean(AIC[start_idx:stop_idx] - AIC[start_idx-1:stop_idx-1])


def CalculateTDOA_AIC_method(y, y2, T, qty_len=40) :
	AE_start = np.zeros(len(y), dtype='float64')
	AE_start2 = np.zeros(len(y), dtype='float64')
	TD_meas = np.zeros(len(y), dtype='float64')
	qty1 = np.zeros(len(y), dtype='float64')
	qty2 = np.zeros(len(y), dtype='float64')
	
	for ii in xrange(len(y)) :
		print '%.2f%%'%(float(ii)/len(y)*100)

		AE_start[ii], AIC1 = OT.Onset_AIC( y[ii], T )
		AE_start2[ii], AIC2 = OT.Onset_AIC( y2[ii], T )
		
		TD_meas[ii] = AE_start2[ii] - AE_start[ii]
		
		qty1[ii] = CalculateQuality(AIC1, qty_len)
		qty2[ii] = CalculateQuality(AIC2, qty_len)

	return AE_start, AE_start2, TD_meas, qty1, qty2
