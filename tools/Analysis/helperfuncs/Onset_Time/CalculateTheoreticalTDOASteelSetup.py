import numpy as np

def CalculateTheoreticalTDOASteelSetup(positions) :
	inch = 0.0254
	tick = 3 #inches
	first_tick_from_crack = 4 #inches

#	print positions
#	print (positions > 9) * (2 * first_tick_from_crack - tick)
#	print (positions < 10) * (2 * first_tick_from_crack - tick)
#	print (positions > 9)
#	print (positions < 10)
#	print (np.array(positions) > 9)
#	print (np.array(positions) < 10)

	positions = np.array(positions)

	distance_inch = positions*tick + (positions > 9) * (2 * first_tick_from_crack - tick)
	distance2_inch = (29 - positions)*tick + (positions < 10) * (2 * first_tick_from_crack - tick)

#	print distance_inch
#	print distance2_inch

	distance = np.sqrt((distance_inch * inch)**2 + inch**2)
	distance2 = np.sqrt((distance2_inch * inch)**2 + inch**2)
	dist_diff = distance - distance2 #m

	v_s = 5100 #m/s

	TD_theory = dist_diff/v_s*1e6
	
	return dist_diff, TD_theory, v_s, distance_inch, distance2_inch