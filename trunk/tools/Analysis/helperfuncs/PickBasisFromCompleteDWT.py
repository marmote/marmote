def PickBasisFromCompleteDWT(cll, levels, items) :
	c = []

	for ii in xrange(len(levels)) :
		c.append(cll[levels[ii]][items[ii]])
		
	return c
