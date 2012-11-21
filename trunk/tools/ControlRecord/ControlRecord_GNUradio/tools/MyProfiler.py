import time as ttt
import numpy as np


################################################################################
class MyProfiler:
    
################################################################################
    def __init__(self, N):
        self.history = np.zeros(N, dtype=np.double)
        self.hist_len = 0

        self.t1 = ttt.time()


################################################################################
    def start_timer(self):
        self.t1 = ttt.time()


################################################################################
    def stop_timer(self):
        if self.hist_len >= self.history.size :
            self.hist_len -= 1
            self.history[:-1] = self.history[1:]

        self.history[self.hist_len] = ttt.time() - self.t1

        self.hist_len += 1


################################################################################
    def get_result(self):
        return np.average( self.history[:self.hist_len] )
