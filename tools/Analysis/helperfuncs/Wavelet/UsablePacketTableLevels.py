import numpy as np


def UsablePacketTableLevels(min_div, PacketTable, N) :
    start_level = 0

    while start_level < xrange(len(PacketTable)) :
        if len(PacketTable[start_level]) >= min_div :
            break; 
        start_level += 1


    stop_level = len(PacketTable)-1
    while stop_level >= 0 :
        if N / len(PacketTable[stop_level]) >= min_div :
            break; 
        stop_level -= 1


    if start_level > stop_level :
        start_level = None
        stop_level = None


    return start_level, stop_level


################################################################################
if __name__ == "__main__":
    pass