def Get_Clusters_From_Reach_Dist(reach_dist, data_idxs, threshold):
    cluster_idxs = []
    reach_dist_ranges = []
    
    collecting_state = False
    
    for ii in xrange( 1, len(reach_dist) ):
        dist = reach_dist[ii]
        valid_dist = (dist is not None) and (dist <= threshold)

        #State transitions
        if collecting_state:
            if valid_dist == False:
                collecting_state = False

                stop_idx = ii
                
                reach_dist_ranges.append( (start_idx, stop_idx) )
                cluster_idxs.append( sorted( data_idxs[start_idx:stop_idx] ) )
           
        else:
            if valid_dist:
                collecting_state = True
                
                start_idx = ii-1
                
    if collecting_state:
        stop_idx = len(reach_dist)

        reach_dist_ranges.append( (start_idx, stop_idx) )
        cluster_idxs.append( sorted( data_idxs[start_idx:stop_idx] ) )

    return reach_dist_ranges, cluster_idxs