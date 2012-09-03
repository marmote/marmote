import numpy as np

class Frameconf_t:
    def __init__(self):
        self.START_OF_FRAME = np.array([0xA1, 0xBE, 0xAF], dtype = np.uint8)
        self.DATA_FRAME_ID  = np.array([0x01], dtype = np.uint8)
