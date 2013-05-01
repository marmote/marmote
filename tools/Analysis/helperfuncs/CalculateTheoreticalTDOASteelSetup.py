import numpy as np

def CalculateTheoreticalTDOASteelSetup(positions) :
	inch = 0.0254
	tick = 3 * inch
	first_tick_from_crack = 4 * inch

	distance = np.sqrt((np.array(positions)*tick + (positions > 9) * 5 * inch)**2 + inch**2)
	distance2 = np.sqrt(((29 - np.array(positions))*tick + (positions < 10) * 5 * inch)**2 + inch**2)
	dist_diff = distance - distance2 #m

	v_s = 5100 #m/s

	TD_theory = dist_diff/v_s*1e6
	
	return dist_diff, TD_theory, v_s