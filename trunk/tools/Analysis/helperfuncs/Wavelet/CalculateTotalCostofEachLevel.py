def CalculateTotalCostofEachLevel(cost) :
	line_costs = []
	for ii in xrange(len(cost)) :
		tsum = 0
		for jj in xrange(len(cost[ii])) :
			tsum += cost[ii][jj]
		line_costs.append(tsum)
		
	return line_costs
	
