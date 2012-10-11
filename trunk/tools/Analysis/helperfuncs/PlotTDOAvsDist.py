import numpy as np
import matplotlib.pyplot as plt

def PlotTDOAvsDist(AE_start, AE_start2, TD_theory, dist_diff, v) :
	fig, ax = plt.subplots(1, 1, sharex=True, sharey=True ) 
    
	TD_meas = []
	for ii in xrange(len(AE_start)):
		TD_meas.append(AE_start2[ii] - AE_start[ii])
	
	p = ax.plot(dist_diff*1e3, TD_meas, '.-', dist_diff*1e3, TD_theory, '.-',)
	ax.legend(p, ['Measured', 'Theoretical, v = %d m/s '%(v)], loc=4)
	ax.set_title('TDOA versus distance difference')
	ax.set_xlabel('distance difference [mm]')
	ax.set_ylabel('time difference of arrival [usec]')