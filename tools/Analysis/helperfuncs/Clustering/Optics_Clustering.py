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


#############################################################################
if __name__ == "__main__":
    x = [1,2,3,1,2,3,1,2,3]
    y = [1,1,1,2,2,2,3,3,3]

    OC = Optics_Clustering(data = np.array([x, y]), 
                        epsilon = 1.5, 
                        min_pts = 4)
    reach_dists, idxs = OC.Generate_Reach_Dist()

