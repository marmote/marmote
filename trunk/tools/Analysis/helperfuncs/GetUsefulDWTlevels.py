def GetUsefulDWTlevels(min_div, cll) :
    start_level = 0
    while start_level < xrange(len(cll)) :
        if len(cll[start_level]) >= min_div :
            break; 
        start_level += 1

    stop_level = len(cll)-1
    while stop_level >= 0 :
        if cll[stop_level][0].size >= min_div :
            break; 
        stop_level -= 1

    if start_level > stop_level :
        start_level = None
        stop_level = None

    return start_level, stop_level

    



################################################################################
if __name__ == "__main__":
    pass