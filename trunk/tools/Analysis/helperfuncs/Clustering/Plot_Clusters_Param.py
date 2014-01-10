import matplotlib.pyplot as plt
import numpy as np

def Plot_Clusters_Param(data, cluster_idxses, param_func, all_xs=None, cluster_xs=[None], title=None, xlabel=None, ylabel=None):
    fig, axarr = plt.subplots(1, 1, sharex=True)
    fig.hold(True)

    for idxses, valid_xs in map(None, cluster_idxses, cluster_xs):

        x = []
        y = []

        if valid_xs is None:
            valid_xs = map(len, idxses)

        if all_xs is None:
            x = valid_xs
        else:
            #Cut off the beginning, which is not used for these clusters
            x = np.array(all_xs)[ np.where( np.array(all_xs) >= valid_xs[0] ) ]
        
        for one_x in x:
            ii = np.where( np.array(valid_xs) - one_x <= 0 )[0][-1]    
        
            idxs = idxses[ii]
            y.append( param_func(data[:,idxs]) )

        axarr.plot(x, y, 'b')

    
    if title is not None:
        axarr.set_title(title)

    if xlabel is not None:
        axarr.set_xlabel(xlabel)

    if ylabel is not None:
        axarr.set_ylabel(ylabel)
