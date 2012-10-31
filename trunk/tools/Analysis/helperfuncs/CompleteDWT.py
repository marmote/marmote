import numpy as np
import pywt

def DWT_recursive(c, N=None, flip = False, wavelet='haar') :
    #init
    cll = []
    cl = []
    
    if N is None:
        N = c.size

    start_idx = int((c.size - N)/2)
    stop_idx = start_idx + N

    c = c.astype(np.float64)
    cl.append(c[start_idx:stop_idx])
    cll.append(cl)
    
    #exit condition
    if N <= 1 or N % 2 :
        return cll 
    
    #actual data generation for this level
    w = pywt.Wavelet(wavelet)
    if flip :
        cHigh, cLow = pywt.dwt(c, w)
    else :
        cLow, cHigh = pywt.dwt(c, w)
        
    #recursive levels
    cll_Low = DWT_recursive(cLow, N=N/2, wavelet=wavelet)
    cll_High = DWT_recursive(cHigh, N=N/2, flip = True, wavelet=wavelet)
    
    for ii in xrange(len(cll_Low)) :
        cll.append(cll_Low[ii] + cll_High[ii])
        
    return cll
        
        
def CompleteDWT(x, wavelet='haar') :		
	return DWT_recursive(x, wavelet=wavelet)