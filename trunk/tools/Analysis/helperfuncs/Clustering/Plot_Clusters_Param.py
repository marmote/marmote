import matplotlib.pyplot as plt
import numpy as np

def Plot_Clusters_Param(data, growing_clusters, growing_cluster_idxs, reach_dist, param_func, title=None, xlabel=None, ylabel=None):
    r = np.unique(reach_dist)
    fig, axarr = plt.subplots(1, 1, sharex=True)
    fig.hold(True)

    for one_cluster, one_cluster_idxs in zip(growing_clusters, growing_cluster_idxs):
        one_cluster_ths = one_cluster['threshold']
        
        x = r[ np.where( r >= one_cluster_ths[0] ) ]
        
        y = []
        for th in x:
            i = np.where( one_cluster_ths - th <= 0 )[0][-1]
#            print one_cluster_ths
#            print th
#            print np.where( one_cluster_ths - th <= 0 )
#            print i
#            print "------------------------------"
            
            idxs = one_cluster_idxs[i]
            y.append( param_func(data[:,idxs]) )

        axarr.plot(x, y, 'b')
    
    if title is not None:
        axarr.set_title(title)

    if xlabel is not None:
        axarr.set_xlabel(xlabel)

    if ylabel is not None:
        axarr.set_ylabel(ylabel)
