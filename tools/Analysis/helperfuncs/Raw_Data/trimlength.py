import numpy as np

def trimlength(ys):
    for ii in xrange(len(ys)):
        ys[ii] = ys[ii][:1000]
    return ys