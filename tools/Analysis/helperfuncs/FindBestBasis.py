def best_basis_rec(cost, level = 0, item = 0) :
    val = cost[level][item]
    ret_levels = [level]
    ret_items = [item]
    
    if level >= len(cost)-1 :
        return val, ret_levels, ret_items
    
    left_val, left_levels, left_items = best_basis_rec(cost, level+1, 2*item)
    right_val, right_levels, right_items = best_basis_rec(cost, level+1, 2*item+1)
    
    if left_val + right_val > val :
        val = left_val + right_val
        ret_levels = left_levels + right_levels
        ret_items = left_items + right_items
    
    return val, ret_levels, ret_items


def FindBestBasis(cost)	:
    ret_vals = []
    ret_levels = []
    ret_items = []
    for ii in xrange(len(cost[0])) :
        val, levels, items = best_basis_rec(cost, item=ii)

        ret_vals.append(val)
        ret_levels = ret_levels + levels
        ret_items = ret_items + items

    return ret_vals, ret_levels, ret_items