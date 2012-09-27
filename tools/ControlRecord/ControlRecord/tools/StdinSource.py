import numpy as np
import sys

import time as ttt
from HumanReadableDataSize import GetHumanReadableDataSize



################################################################################
class StdinSource:

################################################################################
    def __init__(self):
        
        print 'Opening standard input'
        self.f = sys.stdin
            
        self.bytes_read = 0
        self.previous_time = ttt.time()


################################################################################
    def __del__( self ) :

        pass


################################################################################
    def SourceEmpty( self ) :

        return False


################################################################################
    def GetBuffer(self, N = 1024):

        accum = np.array([], dtype=np.uint8)

        while not self.SourceEmpty() and accum.size < N :
            N_new = N-accum.size

            temp = np.fromfile(self.f, dtype=np.uint8, count=N_new)

            if temp.size == 0 :
                continue

            accum = np.append(accum, temp)


        self.bytes_read += accum.size
            
        current_time = ttt.time()
        if current_time - self.previous_time > 3 :
            BPS = float(self.bytes_read) / (current_time - self.previous_time)
            print 'Throughput: %s/s' % ( GetHumanReadableDataSize(BPS) )
            self.bytes_read = 0
            self.previous_time = current_time
           

        return accum

