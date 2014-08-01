import matplotlib.pyplot as plt
import numpy as np

def Plot_Reach_Dist(y, threshold=None, xlabel=None):
    fig, axarr = plt.subplots(1, 1, sharex=True)
#	axarr = axarr.flat
    fig.hold(True)

    axarr.plot(y, 'b',  lw=2)
    if threshold is not None:
        axarr.plot([0, len(y)-1], [threshold, threshold], 'r')

    axarr.set_title('Time series')
    axarr.set_ylabel('Sample []')

    if xlabel is not None:
        axarr.set_xlabel(xlabel)
