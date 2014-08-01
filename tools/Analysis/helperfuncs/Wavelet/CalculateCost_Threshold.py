import numpy as np

def CalculateCost_Threshold(cll, th_level = 0.25) :
	cost = []

	for ii in xrange(len(cll)) :
		cost_l = []

		a_max = np.max( np.abs(cll[ii]) )

		for jj in xrange(len(cll[ii])) :
			a = np.abs( cll[ii][jj] )

			cost_l.append( np.size( np.nonzero( a > a_max * th_level ) ) )

		cost.append(cost_l)

	return cost
	
