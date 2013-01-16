import Onset_AIC as OT
import numpy as np

def CalculateTDOA_AIC_method(y, y2, T, qty_len=40) :
	AE_start = np.zeros(len(y), dtype='float64')
	AE_start2 = np.zeros(len(y), dtype='float64')
	TD_meas = np.zeros(len(y), dtype='float64')
	qty = np.zeros(len(y), dtype='float64')
	qtyi = np.zeros(len(y), dtype='float64')
	
	for ii in xrange(len(y)) :
		print '%.2f%%'%(float(ii)/len(y)*100)

		temp, AIC1 = OT.Onset_AIC( y[ii], T )
		AE_start[ii] = temp
		temp, AIC2 = OT.Onset_AIC( y2[ii], T )
		AE_start2[ii] = temp
		
		TD_meas[ii] = AE_start2[ii] - AE_start[ii]
		
		min_idx = np.argmin(AIC1)
		qty1 = np.amax(AIC1[min_idx+1:min_idx+1+qty_len] - AIC1[min_idx:min_idx+qty_len])
		qtyi1 = np.mean(AIC1[min_idx+1:min_idx+1+qty_len] - AIC1[min_idx:min_idx+qty_len])
		min_idx = np.argmin(AIC2)
		qty2 = np.amax(AIC2[min_idx+1:min_idx+1+qty_len] - AIC2[min_idx:min_idx+qty_len])
		qtyi2 = np.mean(AIC2[min_idx+1:min_idx+1+qty_len] - AIC2[min_idx:min_idx+qty_len])
		qty[ii] = min(qty1, qty2)
		qtyi[ii] = min(qtyi1, qtyi2)
	return AE_start, AE_start2, TD_meas, qty, qtyi
