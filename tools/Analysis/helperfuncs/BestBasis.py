def BestBasis_rec(cost, level = 0, stop_level = None, item = 0) :
    val = cost[level][item]
    ret_levels = [level]
    ret_items = [item]
    
    if stop_level is None :
        stop_level = len(cost)-1
    else :
        stop_level = min(len(cost)-1, stop_level)

    if level >= stop_level:
        return val, ret_levels, ret_items
    
    left_val, left_levels, left_items = BestBasis_rec(cost, level+1, stop_level, 2*item)
    right_val, right_levels, right_items = BestBasis_rec(cost, level+1, stop_level, 2*item+1)
    
    if left_val + right_val > val :
        val = left_val + right_val
        ret_levels = left_levels + right_levels
        ret_items = left_items + right_items
    
    return val, ret_levels, ret_items


def BestBasis(cost, start_level=None, stop_level=None) :
    if start_level is None :
        start_level = 0

    ret_vals = []
    ret_levels = []
    ret_items = []
    for ii in xrange(len(cost[start_level])) :
        val, levels, items = BestBasis_rec(cost, level=start_level, stop_level=stop_level, item=ii)

        ret_vals.append(val)
        ret_levels = ret_levels + levels
        ret_items = ret_items + items

    return ret_vals, ret_levels, ret_items