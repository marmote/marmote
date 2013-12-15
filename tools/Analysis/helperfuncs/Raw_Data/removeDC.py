import numpy as np

def removeDC(ys):
    for ii in xrange(len(ys)):
        ys[ii] -= np.mean(ys[ii])
    return ys
