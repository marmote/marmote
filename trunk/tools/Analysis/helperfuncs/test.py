import numpy as np
from Raw_Data.ReadAEMeas import ReadAEMeas
from Raw_Data.removeDC import removeDC
from Onset_Time.CalculateTDOA import CalculateTDOA
from Onset_Time.Onset_Reciprocal import Onset_Reciprocal
from Clustering.Optics_Clustering import Optics_Clustering


#############################################################################
if __name__ == "__main__":

    dir = '../../../../Measurements/BreakTest_AluminiumBeam/results.enhanced/1-0.5'
    y_1, y2_1, T_1, fnames_1, start_time = ReadAEMeas(dir)

    Fs = 1/T_1
    #print Fs


    y_1 = removeDC(y_1)
    y2_1 = removeDC(y2_1)


    
    AE_start_1, AE_start2_1, TD_meas, qty1, qty2 = CalculateTDOA(y_1, y2_1, T_1, Onset_Reciprocal)
    qty_min = np.minimum(qty1, qty2)
    qty_max = np.maximum(qty1, qty2)



    TD_meas = TD_meas[np.log10(qty_min) > -100]
    qty_min = qty_min[np.log10(qty_min) > -100]


    data = np.array([TD_meas*1e3, np.log10(qty_min)])

    OC = Optics_Clustering(data = data, 
                            epsilon = 1, 
                            min_pts = 3)

    ranges, idxses = OC.Get_Hierarchical_Clusters_Steepness( xi = 0.01, 
                                                             steep_tolerance_pts=3, 
                                                             min_cluster_pts=4 )

    print ranges
    print idxses

