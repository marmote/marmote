def Select_Best_Clusters(rangeses, idxseses, data, Is_Cluster_Good):
    out_ranges = []
    out_idxses = []

    for ranges, idxses in zip(rangeses, idxseses):
    
        out_range = []
        out_idxs = []
    
        for range, idxs in zip(ranges, idxses):
            if Is_Cluster_Good( data[:,idxs] ):
                out_range = range
                out_idxs = idxs

        if not out_range:
            continue
       
        if out_range not in out_ranges:
            out_ranges.append(out_range)
            out_idxses.append(out_idxs)

    return out_ranges, out_idxses