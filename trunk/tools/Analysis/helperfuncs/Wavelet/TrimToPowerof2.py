def TrimToPowerof2(x):
	levels = 0
	while 2**levels <= x.size :
		levels += 1
   
	if levels == 0 :
		new_end = 0
	else :
		new_end = 2**(levels-1)
   
	return x[0:new_end]