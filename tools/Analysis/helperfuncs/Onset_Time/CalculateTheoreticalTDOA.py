import numpy as np

def CalculateTheoreticalTDOA(positions) :
	inch = 0.0254
	tick = 3 * inch

	distance = np.sqrt(((20 - np.array(positions))*tick)**2 + inch**2)
	distance2 = np.sqrt(((np.array(positions) - 1)*tick)**2 + inch**2)
	dist_diff = distance2 - distance #m

	v_s = 5100 #m/s

	TD_theory = dist_diff/v_s*1e6
	
	return dist_diff, TD_theory, v_s