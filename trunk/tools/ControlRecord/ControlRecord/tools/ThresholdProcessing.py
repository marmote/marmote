import numpy as np


################################################################################
class ThresholdFilter:

################################################################################
    def __init__(self, TH_level):
        self.TH_level = TH_level
        self.rec_frame_num = 10
        self.TH_cnt = 0


################################################################################
    def Process(self, buff):

        if self.TH_cnt > 0 :
            self.TH_cnt -= 1

        buff = buff.view(dtype=np.int16).newbyteorder()

        if np.abs(buff).max() >= self.TH_level :
            self.TH_cnt = self.rec_frame_num

        return self.TH_cnt > 0