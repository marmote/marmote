import numpy as np

def CalculateCost_ShannonEntropy(cll) :
	cost = []

	for ii in xrange(len(cll)) :
		cost_l = []
		for jj in xrange(len(cll[ii])) :
			a = np.abs(cll[ii][jj])**2

			b = np.array([], dtype='float64')
			for kk in xrange(a.size) :
				if a[kk] == 0 :
					b = np.append(b, [0])
				else :
					b = np.append(b, a[kk] * np.log2(a[kk]))

			cost_l.append(-np.sum(b))

#        	cost_l.append(-np.sum(a * np.log2(a)))
		cost.append(cost_l)

	return cost
	
