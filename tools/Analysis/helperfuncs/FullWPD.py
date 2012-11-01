import numpy as np
import pywt


def WDP_rec(c, N=None, flip = False, wavelet='haar') :
#init
    PacketTable = []
    PacketTableLevel = []
    
    if N is None:
        N = c.size

#    start_idx = int((c.size - N)/2)
#    stop_idx = start_idx + N

    c = c.astype(np.float64)
#    PacketTableLevel.append(c[start_idx:stop_idx])
    PacketTableLevel.append(c)
    PacketTable.append(PacketTableLevel)
    
#exit condition
    if N <= 1 or N % 2 :
        return PacketTable 
    
#actual data generation for this level
    w = pywt.Wavelet(wavelet)
    if flip :
        cHigh, cLow = pywt.dwt(c, w)
    else :
        cLow, cHigh = pywt.dwt(c, w)
        
#recursive levels
    PacketTable_Low = WDP_rec(cLow, N=N/2, wavelet=wavelet)
    PacketTable_High = WDP_rec(cHigh, N=N/2, flip = True, wavelet=wavelet)
    
    for ii in xrange(len(PacketTable_Low)) :
        PacketTable.append(PacketTable_Low[ii] + PacketTable_High[ii])
        
    return PacketTable
        
        
def FullWPD(x, wavelet='haar') :		
	return WDP_rec(x, wavelet=wavelet)