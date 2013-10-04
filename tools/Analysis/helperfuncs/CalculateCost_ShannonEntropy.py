import numpy as np

def CalculateCost_ShannonEntropy(cll) :
	cost = []

	for ii in xrange(len(cll)) :
		cost_l = []

		#This should be a constant value on all levels
		E = np.sum(np.power( cll[ii], 2 )) #Total energy on one level

		for jj in xrange(len(cll[ii])) :
#			Ep = np.sum(np.power( cll[ii][jj], 2 )) #Energy of packet
#
#			Epr = Ep / E
#
#			cost_l.append( -Epr * np.log2(Epr) )

			cost_l.append(0)

			a = np.power( cll[ii][jj], 2 )/E

			for kk in xrange(a.size) :
				if a[kk] != 0 :
					cost_l[-1] += -a[kk] * np.log2(a[kk])

		cost.append(cost_l)

	return cost
	
