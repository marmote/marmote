import numpy as np
import matplotlib.pyplot as plt

def PlotTDOAvsPos(AE_start, AE_start2, positions) :
	fig, ax = plt.subplots(1, 1, sharex=True, sharey=True ) 
    

	TD_meas = []
	for ii in xrange(len(AE_start)):
		TD_meas.append(AE_start2[ii] - AE_start[ii])
    
	ax.plot(positions, TD_meas, '.-')
	ax.set_title('TDOA versus position')
	ax.set_xlabel('position')
	ax.set_ylabel('time difference of arrival [usec]')