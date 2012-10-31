import numpy as np
import pywt

def DWT_recursive(c, flip = False) :
    #init
    cll = []
    cl = []
    
    c = c.astype(np.float64)
    cl.append(c)
    cll.append(cl)
    
    #exit condition
    if c.size <= 1 or c.size % 2 :
        return cll 
    
    #actual data generation for this level
    w = pywt.Wavelet('haar')
    if flip :
        cHigh, cLow = pywt.dwt(c, w)
    else :
        cLow, cHigh = pywt.dwt(c, w)
        
    #recursive levels
    cll_Low = DWT_recursive(cLow)
    cll_High = DWT_recursive(cHigh, flip = True)
    
    for ii in xrange(len(cll_Low)) :
        cll.append(cll_Low[ii] + cll_High[ii])
        
    return cll
        
        
def CompleteDWT(x) :		
	return DWT_recursive(x)