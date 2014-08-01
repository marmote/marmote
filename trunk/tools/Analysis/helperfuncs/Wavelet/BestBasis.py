def BestBasis_rec(cost, level, stop_level, item) :
	val = cost[level][item]
	ret_levels = [level]
	ret_items = [item]

	if level >= stop_level:
		return val, ret_levels, ret_items

	left_val, left_levels, left_items = BestBasis_rec(cost, level+1, stop_level, 2*item)
	right_val, right_levels, right_items = BestBasis_rec(cost, level+1, stop_level, 2*item+1)

	if left_val + right_val < val :
		val = left_val + right_val
		ret_levels = left_levels + right_levels
		ret_items = left_items + right_items

	return val, ret_levels, ret_items


########################################################################################
def BestBasis(cost, start_level=None, stop_level=None) :
#Tries to minimize overall "val" of the WPD table
	if start_level is None :
		start_level = 0

	if stop_level is None :
		stop_level = len(cost)-1
	else :
		stop_level = min(len(cost)-1, stop_level)

	ret_vals = []
	ret_levels = []
	ret_items = []
	for ii in xrange(len(cost[start_level])) :
		val, levels, items = BestBasis_rec(cost, level=start_level, stop_level=stop_level, item=ii)

		ret_vals.append(val)
		ret_levels = ret_levels + levels
		ret_items = ret_items + items

	return ret_vals, ret_levels, ret_items


########################################################################################
def Best_Basis_For_Multiple_Cost_Trees_Rec(costs, level, stop_level, item) :
	vals = []
	for cost in costs:
		vals.append( cost[level][item] )
	ret_levels = [level]
	ret_items = [item]

	if level >= stop_level:
		return vals, ret_levels, ret_items

	left_vals, left_levels, left_items = Best_Basis_For_Multiple_Cost_Trees_Rec(costs, level+1, stop_level, 2*item)
	right_vals, right_levels, right_items = Best_Basis_For_Multiple_Cost_Trees_Rec(costs, level+1, stop_level, 2*item+1)

	if sum(left_vals) + sum(right_vals) < sum(vals) :
		vals = []
		for left_val, right_val in zip(left_vals, right_vals) :
			vals.append(left_val + right_val)
		ret_levels = left_levels + right_levels
		ret_items = left_items + right_items

	return vals, ret_levels, ret_items


########################################################################################
def Best_Basis_For_Multiple_Cost_Trees(costs, start_level=None, stop_level=None) :
#TODO: Check that every item in list has the same length

#Tries to minimize overall "val" of the WPD table
	if start_level is None :
		start_level = 0

	if stop_level is None :
		stop_level = len(costs[0])-1
	else :
		stop_level = min(len(costs[0])-1, stop_level)

	ret_vals = []
	ret_levels = []
	ret_items = []
	for ii in xrange(len(costs[0][start_level])) :
		vals, levels, items = Best_Basis_For_Multiple_Cost_Trees_Rec(costs, level=start_level, stop_level=stop_level, item=ii)

		ret_vals.append(vals)
		ret_levels = ret_levels + levels
		ret_items = ret_items + items

	return ret_vals, ret_levels, ret_items



