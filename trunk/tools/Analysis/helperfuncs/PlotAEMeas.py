import numpy as np
import matplotlib.pyplot as plt

def PlotAEMeas(y, y2, AE_start, AE_start2, T,  positions = None, x_lim_min = 0, x_lim_max = 1e-3, y_lim_min = -1.1, y_lim_max = 1.1, threshold=None) :

	if y is not None and y2 is not None and len(y) and len(y2):
		y_temp = min( len(y), len(y2) )
	else:
		return

	if positions is not None and len(positions):
		p_temp = max(positions) + 1 - min(positions)
	else:
		p_temp = None



	if p_temp is not None and y_temp is not None:
		number_of_figs = max( p_temp, y_temp )
	elif p_temp is not None:
		number_of_figs = p_temp 
	elif y_temp is not None:
		number_of_figs = y_temp
	else:
		number_of_figs = 0 


	rows = 1
	cols = 1
	while rows * cols < number_of_figs :
		if rows < cols :
			rows += 1
		else :
			cols += 1

	fig, axarr    = plt.subplots(rows, cols, sharex=True, sharey=True )
	if rows == 1 and cols == 1 :
		axarr = [axarr]
	else :
		axarr = axarr.flat


	axarr_cnt = -1
	for ii in xrange(y_temp) :
		axarr_cnt += 1

		if positions is not None:
			axarr_cnt = 0
			act_pos = min(positions)
			while act_pos < max(positions) and act_pos != positions[ii] :
				act_pos += 1
				axarr_cnt += 1

		axarr[axarr_cnt].hold('on')

		N = y[ii].size
		time = np.array( xrange(0,N) ) *T

		if AE_start is not None and AE_start2 is not None :
			if AE_start[ii] < AE_start2[ii] :
				axarr[axarr_cnt].plot(time, y[ii], 'g')
				axarr[axarr_cnt].plot(time, y2[ii], 'b')
			else :
				axarr[axarr_cnt].plot(time, y2[ii], 'b')
				axarr[axarr_cnt].plot(time, y[ii], 'g')

			axarr[axarr_cnt].plot([AE_start[ii], AE_start[ii]], [-1, 1], 'r')
			axarr[axarr_cnt].plot([AE_start2[ii], AE_start2[ii]], [-1, 1], 'r')
		else :
			axarr[axarr_cnt].plot(time, y[ii], 'g')
			axarr[axarr_cnt].plot(time, y2[ii], 'b')

		if threshold is not None:
			axarr[axarr_cnt].plot([x_lim_min, x_lim_max], [threshold, threshold], 'r')
			axarr[axarr_cnt].plot([x_lim_min, x_lim_max], [-threshold, -threshold], 'r')

		axarr[axarr_cnt].hold('off')
		axarr[axarr_cnt].locator_params(axis='both', nbins=4)
		axarr[axarr_cnt].ticklabel_format(scilimits=(-3,3))
		axarr[axarr_cnt].set_ylim(y_lim_min, y_lim_max)
		axarr[axarr_cnt].set_xlim(x_lim_min, x_lim_max)

		title_str = ''

		if positions is not None:
			title_str += 'pos %d' % positions[ii]

		if AE_start is not None and AE_start2 is not None :
			title_str += '\nTD = %.2f' % (AE_start2[ii] - AE_start[ii])

		axarr[axarr_cnt].set_title(title_str)

	fig.set_size_inches(10, 8, forward = True)
	fig.tight_layout()
	fig.subplots_adjust(left=0.04, bottom=0.07, right=0.97, top=0.91, wspace=0.2, hspace=0.6)    


################################################################################
if __name__ == "__main__":
    T_I = 1/750000.0
    y_AIC_I = [ np.array([1, 2, 3]), 
               np.array([1, 2, 3]),
               np.array([1, 2, 3]),
               np.array([1, 2, 3]),
               np.array([1, 2, 3]),
               np.array([1, 2, 3]),
               np.array([1, 2, 3]),
               np.array([1, 2, 3]),
               np.array([1, 2, 3]) ]

    y2_AIC_I = [ np.array([1, 2, 3]), 
               np.array([1, 2, 3]),
               np.array([1, 2, 3]),
               np.array([1, 2, 3]),
               np.array([1, 2, 3]),
               np.array([1, 2, 3]),
               np.array([1, 2, 3]),
               np.array([1, 2, 3]),
               np.array([1, 2, 3]) ]

    AE_start_AIC_I = [50,
                      50,
                      50,
                      50,
                      50,
                      50,
                      50,
                      50,
                      50 ]

    AE_start2_AIC_I = [50,
                      50,
                      50,
                      50,
                      50,
                      50,
                      50,
                      50,
                      50 ]

    positions_AIC_I = [19, 17, 15, 9, 8, 6, 4, 3, 1]

    PlotAEMeas(y_AIC_I,   y2_AIC_I,   AE_start_AIC_I,   AE_start2_AIC_I,   T_I,   positions_AIC_I)

    
    plt.show()