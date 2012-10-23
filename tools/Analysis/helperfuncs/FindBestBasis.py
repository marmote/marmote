def best_basis_rec(cost, level = 0, item = 0) :
    val = cost[level][item]
    ret_level = [level]
    ret_item = [item]
    
    if level >= len(cost)-1 :
        return val, ret_level, ret_item
    
    left_val, left_level, left_item = best_basis_rec(cost, level+1, 2*item)
    right_val, right_level, right_item = best_basis_rec(cost, level+1, 2*item+1)
    
    if left_val + right_val > val :
        val = left_val + right_val
        ret_level = left_level + right_level
        ret_item = left_item + right_item
    
    return val, ret_level, ret_item
	
	
def FindBestBasis(cost)	:
	return best_basis_rec(cost)