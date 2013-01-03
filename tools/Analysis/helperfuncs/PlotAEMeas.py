import numpy as np
import matplotlib.pyplot as plt

def PlotAEMeas(y, y2, AE_start, AE_start2, T, fnames, positions, x_lim_min = 0, x_lim_max = 1000, y_lim_min = -1.1, y_lim_max = 1.1, threshold=None) :
    rows = 1
    cols = 1

    while rows * cols < len(y) :
        if rows < cols :
            rows += 1
        else :
            cols += 1

    fig, axarr    = plt.subplots(rows, cols, sharex=True, sharey=True )
    if rows == 1 and cols == 1 :
        axarr = [axarr]
    else :
        axarr = axarr.flat

    axarr_cnt = 0

    for act_pos in xrange(min(positions), max(positions)+1) :
        for ii in xrange(len(y)) :
            if positions[ii] != act_pos :
                continue

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
            if AE_start is not None and AE_start2 is not None :
                axarr[axarr_cnt].set_title('pos %d\nTD = %.2f' % (positions[ii], AE_start2[ii] - AE_start[ii]))
            else:
                axarr[axarr_cnt].set_title('pos %d' % (positions[ii]))

        axarr_cnt += 1
    
    fig.set_size_inches(10, 8, forward = True)
    fig.tight_layout()
    fig.subplots_adjust(left=0.04, bottom=0.07, right=0.97, top=0.91, wspace=0.2, hspace=0.6)    
