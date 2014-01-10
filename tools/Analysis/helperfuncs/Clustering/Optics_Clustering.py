import numpy as np
import math

class Optics_Clustering:

    #########################################################################
    def __init__( self, data, epsilon, min_pts ):
        self.data = data
        self.epsilon = epsilon
        self.min_pts = min_pts
        self.N = np.shape(data)[1]

        self.neighbors_list = [None] * self.N #Stored neighbors' idx and distance from center

        self.processed = [False] * self.N 
        self.data_idxs = [] 
        self.reach_dists = []

        # For ordered seeds and neighbors
        self.dtype = [ ('idx', int), ('dist', float) ] 


    #########################################################################
    def Get_Distance( self, idx1, idx2 ):
        return np.linalg.norm( self.data[:,idx1] - self.data[:,idx2] )


    #########################################################################
    def Get_Neighbors( self, idx ):
        if self.neighbors_list[idx] is None:
            neighbors = np.array([], self.dtype)

            for ii in xrange( self.N ):
                dist = self.Get_Distance(idx, ii)

                if dist <= self.epsilon:
                    neighbors = np.append( neighbors, np.array( (ii, dist), self.dtype ) )

            self.neighbors_list[idx] = np.sort( neighbors, order='dist' )[1:] #To remove self distance

 #           print "Calculating neighbors for ", idx, ", it has ", len( self.neighbors_list[idx] ), "neighbors"

 #       print "Retrieving neighbors for ", idx
        return self.neighbors_list[idx]


    #########################################################################
    def Is_Core_Object( self, idx ):
        return len( self.Get_Neighbors(idx) ) >= self.min_pts


    #########################################################################
    def Get_Core_Distance( self, idx ):
        if not self.Is_Core_Object(idx):
            return None

        return self.Get_Neighbors(idx)[self.min_pts-1]['dist']


    #########################################################################
    def Update_Ordered_Seeds( self, idx_in, ordered_seeds ):
        neighbors = self.Get_Neighbors( idx_in ) # All neighbors within epsilon
        core_distance = self.Get_Core_Distance( idx_in )

        assert ( core_distance is not None ) and ( not math.isnan(core_distance) )

        for neighbor in neighbors:
            idx = neighbor['idx']
            dist = neighbor['dist']

            # If point has already been processed don't bother 
            if self.processed[idx]:
                continue

            new_reach_dist = max( core_distance, dist )

            seed_idx = np.where( ordered_seeds['idx'] == idx )[0]

            if len( seed_idx ) == 0:
                ordered_seeds = np.append( ordered_seeds, np.array( [ (idx, new_reach_dist) ], self.dtype ) )
            else:
                ordered_seeds[seed_idx] = np.array( (idx, min( ordered_seeds[seed_idx]['dist'], new_reach_dist )), self.dtype )

        return np.sort( ordered_seeds, order='dist' )


    #########################################################################
    def Generate_Reach_Dist( self ):

        for ii in xrange( self.N ):

            if self.processed[ii]:
                continue

            ordered_seeds = np.array( [ (ii, None) ], self.dtype )

            while len(ordered_seeds):
                idx = ordered_seeds[0]['idx']
                reach_dist = None if math.isnan(ordered_seeds[0]['dist']) else ordered_seeds[0]['dist']

                ordered_seeds = ordered_seeds[1:]

#                self.processed[idx] = len(self.reach_dists)
                self.processed[idx] = True
                self.reach_dists.append(reach_dist)
                self.data_idxs.append(idx)

                if not self.Is_Core_Object(idx):
                    continue

                ordered_seeds = self.Update_Ordered_Seeds( idx, ordered_seeds )

        return self.reach_dists, self.data_idxs


    #########################################################################
    def Get_Clusters_Threshold( self, threshold, min_cluster_pts=1 ):

        if len(self.reach_dists) == 0:
            self.Generate_Reach_Dist()

        cluster_idxs = []
        reach_dist_ranges = []
    
        collecting_state = False
    
        for ii in xrange( 1, self.N ):
            dist = self.reach_dists[ii]
            valid_dist = (dist is not None) and (dist <= threshold)

            #State transitions
            if collecting_state:
                if valid_dist == False:
                    collecting_state = False

                    stop_idx = ii
                
                    if stop_idx - start_idx >= min_cluster_pts:
                        reach_dist_ranges.append( (start_idx, stop_idx) )
                        cluster_idxs.append( sorted( self.data_idxs[start_idx:stop_idx] ) )
           
            else:
                if valid_dist:
                    collecting_state = True
                
                    start_idx = ii-1
                
        if collecting_state:
            stop_idx = self.N

            if (min_cluster_pts is None) or (stop_idx - start_idx >= min_cluster_pts):
                reach_dist_ranges.append( (start_idx, stop_idx) )
                cluster_idxs.append( sorted( self.data_idxs[start_idx:stop_idx] ) )

        return reach_dist_ranges, cluster_idxs


    #########################################################################
    def Generate_Hierarchical_Clusters_List( self, ranges, current_ranges, idxses, current_idxses, miscs=None, current_miscs=[None] ):

#        print current_ranges
#        print current_idxses
#        print current_miscs

        if len(current_ranges) == 0 or len(current_idxses) == 0:
            return ranges, idxses, miscs

        for range, idxs, misc in map( None, current_ranges, current_idxses, current_miscs ):
            
#            print range
#            print idxs
#            print misc
            
            if misc is None:
                misc = current_miscs[-1]

            start = range[0]
            stop = range[1]

            cluster_handled = False

            for ii in xrange( len(ranges) ):
                c = ranges[ii][-1]
                start_prev = c[0]
                stop_prev = c[1]
    
                if not (start == start_prev and stop == stop_prev) and (start <= start_prev and stop >= stop_prev):
                    ranges[ii].append( range )
                    idxses[ii].append( idxs )
                    if miscs is not None:
                        miscs[ii].append( misc )

                    cluster_handled = True
        
            if not cluster_handled:
                ranges.append( [range] ) 
                idxses.append( [idxs] )
                if miscs is not None:
                    miscs.append( [misc] )

        return ranges, idxses, miscs


    #########################################################################
    def Get_Hierarchical_Clusters_Threshold( self, min_cluster_pts=1 ):

        ranges          = []
        idxses          = []
        thresholds      = []

        unique_reach_dists = np.unique(self.reach_dists)

        for th in unique_reach_dists:
            if th is None:
                continue
    
            ranges_th, idxses_th = self.Get_Clusters_Threshold( threshold=th, min_cluster_pts=min_cluster_pts )
            
#            print ranges_th
#            print idxses_th

#            if len(ranges_th) == 0:
#                continue
        
            ranges, idxses, thresholds = self.Generate_Hierarchical_Clusters_List( ranges, ranges_th, idxses, idxses_th, thresholds, [th] )

        return ranges, idxses, thresholds    


#########################################################################
    def Get_Hierarchical_Clusters_Steepness( self, xi = 0.01, steep_tolerance_pts=0, min_cluster_pts=1 ):

        xi = max(xi, 0.01)
        xi = min(xi, 1)

        if len(self.reach_dists) == 0:
            self.Generate_Reach_Dist()

        ranges          = []
        idxses          = []


        #############################
        def Get_Trend(r0, r1, xi):
            a = r0 if r0 is not None else float("inf")
            b = r1 if r1 is not None else float("inf")

            if a <= b * (1 - xi):
                return 2

            if a < b:
                return 1

            if a * (1 - xi) >= b:
                return -2

            if a > b:
                return -1

            return 0


        #############################
        def Look_For_Clusters( U, reach_dists, data_idxs, steep_downs, min_cluster_pts, ranges, idxses ):
            ReachEnd = U[1]
            Up_region_plus = [ v if v is not None else float("inf") for v in reach_dists[ U[0]:U[1]+1 ] ]
            if U[1] - self.N + 1 > 0:
                Up_region_plus = Up_region_plus + [float("inf")] * (U[1] - self.N + 1)
                ReachEnd_val = float("inf")
            else:
                ReachEnd_val = reach_dists[ ReachEnd ] if reach_dists[ ReachEnd ] is not None else float("inf")
            
            #print "Up region start idx:   %d"%(U[0])
            #print "Up region stop idx:    %d"%(U[1])

            for D in steep_downs:
                ReachStart  = D[0]
                Down_region = [ v if v is not None else float("inf") for v in reach_dists[ D[0]:D[1] ] ]
                ReachStart_val = reach_dists[ ReachStart ] if reach_dists[ ReachStart ] is not None else float("inf")

                #print "Down region start idx: %d"%(D[0])
                #print "Down region stop idx:  %d"%(D[1])

                potential_cluster = [ v if v is not None else float("inf") for v in reach_dists[ReachStart+1:ReachEnd] ]

                #3b
                if np.max( potential_cluster ) >  min( ReachStart_val, ReachEnd_val ) * (1 - xi):
                    continue

                #4
                if (ReachStart_val == ReachEnd_val) or ((ReachStart_val * (1 - xi) < ReachEnd_val) and (ReachStart_val > ReachEnd_val * (1 - xi))):
                    SoC = D[0]
                    EoC = U[1]
#                    print "1"
#                    print SoC
#                    print EoC

                elif ReachStart_val * (1 - xi) >= ReachEnd_val:
                    SoC = D[0] + np.where( np.array( Down_region ) > ReachEnd_val )[0][-1]
                    EoC = U[1]
 #                   print "2"
 #                   print D[0]
 #                   print D[1]
 #                   print Down_region
 #                   print np.array( Down_region )
 #                   print np.where( np.array( Down_region ) > ReachEnd_val )
 #                   print np.where( np.array( Down_region ) > ReachEnd_val )[-1]
 #                   print SoC
 #                   print EoC

                elif ReachStart_val <= ReachEnd_val * (1 - xi):
                    SoC = D[0]
                    EoC = U[0] + np.where( np.array( Up_region_plus ) > ReachStart_val )[0][0] + 1
  #                  print "3"
  #                  print SoC
  #                  print EoC
    
                #3a
                if EoC - SoC < min_cluster_pts:
                    continue

                #Yaaaaay, found a cluster
                range = (SoC, EoC)
                idxs = data_idxs[SoC:EoC]
                ranges, idxses, _ = self.Generate_Hierarchical_Clusters_List( ranges, [range], idxses, [idxs] )

            #print ranges
            #print idxses
            return ranges, idxses


        normal_state    = True
        direction       = 0

        steep_downs     = []

        for ii in xrange(0, self.N):

            trend = Get_Trend(self.reach_dists[ii] if ii < self.N else None, 
                              self.reach_dists[ii+1] if ii+1 < self.N else None,
                              xi)

            if normal_state:
                if trend == -2 or trend == 2:
                    normal_state        = False

                    start               = ii
                    tolerance_point_cnt = 0
                    direction           = np.sign(trend)

            else:
                if direction * trend == 2:
                    tolerance_point_cnt  = 0

                elif direction * trend == -1:
                    normal_state        = True

                    stop                = ii - tolerance_point_cnt
                    if direction < 0:
                        steep_downs.append( (start, stop) )
                    else:
                        U = (start, stop)
                        ranges, idxses = Look_For_Clusters(U, self.reach_dists, self.data_idxs, steep_downs, min_cluster_pts, ranges, idxses)

                elif direction * trend == -2:
                    stop                = ii - tolerance_point_cnt
                    if direction < 0:
                        steep_downs.append( (start, stop) )
                    else:
                        U = (start, stop)

                        #print U
                        #print self.reach_dists
                        #print self.data_idxs
                        #print steep_downs
                        #print min_cluster_pts
                        #print idxses
                        ranges, idxses = Look_For_Clusters(U, self.reach_dists, self.data_idxs, steep_downs, min_cluster_pts, ranges, idxses)

                    start               = ii
                    tolerance_point_cnt = 0
                    direction           = np.sign(trend)

                elif tolerance_point_cnt + 1 > steep_tolerance_pts:
                    normal_state        = True

                    stop                = ii - tolerance_point_cnt + 1
                    if direction < 0:
                        steep_downs.append( (start, stop) )
                    else:
                        U = (start, stop)
                        ranges, idxses = Look_For_Clusters(U, self.reach_dists, self.data_idxs, steep_downs, min_cluster_pts, ranges, idxses)

                else:
                    tolerance_point_cnt += 1

            if ii == self.N - 1:
                stop = ii + 1

                U = (start, stop)
                ranges, idxses = Look_For_Clusters(U, self.reach_dists, self.data_idxs, steep_downs, min_cluster_pts, ranges, idxses)

        return ranges, idxses


#############################################################################
if __name__ == "__main__":
    x = [1,2,3,1,2,3,1,2,3]
    y = [1,1,1,2,2,2,3,3,3]

    OC = Optics_Clustering(data = np.array([x, y]), 
                        epsilon = 1.5, 
                        min_pts = 4)
    reach_dists, idxs = OC.Generate_Reach_Dist()

