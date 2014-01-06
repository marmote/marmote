import numpy as np
from Get_Clusters_From_Reach_Dist import Get_Clusters_From_Reach_Dist

def Get_Growing_Clusters_From_Reach_Dist(reach_dist, data_idxs):

    dtype = [ ('threshold', float), ('range', int, 2)]

    cluster_grow = []
    idxses = []
    unique_reach_dists = np.unique(reach_dist)

    for th in unique_reach_dists:
        if th is None:
            continue
    
    #    print '-------------------------------------------------------'
    #    print th
        reach_dist_ranges, cluster_idxs = Get_Clusters_From_Reach_Dist(reach_dist, data_idxs, th)
    #    print reach_dist_ranges
    
        for r, idxs in zip(reach_dist_ranges, cluster_idxs):
            start = r[0]
            stop = r[1]

            cluster_handled = False

            for ii in xrange( len(cluster_grow) ):
                c = cluster_grow[ii][-1]
                start_prev = c['range'][0]
                stop_prev = c['range'][1]
    
                if not (start == start_prev and stop == stop_prev) and (start <= start_prev and stop >= stop_prev):
                    cluster_grow[ii] = np.append( cluster_grow[ii], np.array([(th, r)], dtype) )
                    idxses[ii].append(idxs)
                    cluster_handled = True
 #               print "cluster growing"
        
            if not cluster_handled:
                cluster_grow.append( np.array([(th, r)], dtype) ) 
                idxses.append( [idxs] )

#       print cluster_grow
    return cluster_grow, idxses
