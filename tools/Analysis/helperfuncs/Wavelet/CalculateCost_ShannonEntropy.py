import numpy as np

def CalculateCost_ShannonEntropy(cll) :
    cost = []

    for ii in xrange(len(cll)) :
        cost_l = []

        #This should be a constant value on all levels
        E = np.sum(np.power( cll[ii], 2 )) #Total energy on one level

        for jj in xrange(len(cll[ii])) :

            a = np.power( cll[ii][jj], 2 )/E

            cost_l.append(0)
            for b in a :
                if b == 0: #to avoid the log2(0) situation
                    continue

                cost_l[-1] += -b * np.log2( b )

        cost.append(cost_l)

    return cost

