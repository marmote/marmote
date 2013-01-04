import Onset_AIC as OT

def CalculateTDOA_AIC_method(y, y2, T) :
	AE_start = []
	AE_start2 = []
	TD_meas = []
	
	for ii in xrange(len(y)) :
		print '%.2f%%'%(float(ii)/len(y)*100)

		temp, AIC = OT.Onset_AIC( y[ii], T )
		AE_start.append( temp )
		temp, AIC = OT.Onset_AIC( y2[ii], T )
		AE_start2.append( temp )
		
		TD_meas.append(AE_start2[-1] - AE_start[-1])
		
	return AE_start, AE_start2, TD_meas
