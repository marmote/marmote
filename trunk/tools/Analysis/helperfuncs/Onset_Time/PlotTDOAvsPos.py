import numpy as np
import matplotlib.pyplot as plt

def PlotTDOAvsPos(TD_meas, positions) :
	fig, ax = plt.subplots(1, 1, sharex=True, sharey=True ) 
    
	ax.plot(positions, TD_meas, '.-')
	ax.set_title('TDOA versus position')
	ax.set_xlabel('position')
	ax.set_ylabel('time difference of arrival [usec]')