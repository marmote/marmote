import numpy as np
from Raw_Data.ReadAEMeas import ReadAEMeas
from Raw_Data.removeDC import removeDC
from Onset_Time.CalculateTDOA import CalculateTDOA
from Onset_Time.Onset_Reciprocal import Onset_Reciprocal
from Onset_Time.Onset_AIC import Onset_AIC
from Clustering.Optics_Clustering import Optics_Clustering
from Clustering.Select_Best_Clusters import Select_Best_Clusters


#############################################################################
if __name__ == "__main__":

    dir = '../../../../Measurements/BreakTest_AluminiumBeam/results.enhanced/2-0.75'
    y_2, y2_2, T_2, fnames_2, start_time = ReadAEMeas(dir)

    Fs = 1/T_2
    #print Fs


    y_2 = removeDC(y_2)
    y2_2 = removeDC(y2_2)


    
    AE_start_2, AE_start2_2, TD_meas, qty1, qty2 = CalculateTDOA(y_2, y2_2, T_2, Onset_AIC)
    qty_min = np.minimum(qty1, qty2)
    qty_max = np.maximum(qty1, qty2)



    TD_meas = TD_meas[np.log10(qty_min) > -100]
    qty_min = qty_min[np.log10(qty_min) > -100]


    data = np.array([TD_meas*1e3, np.log10(qty_min)])

    OC = Optics_Clustering(data = data, 
                            epsilon = 1, 
                            min_pts = 3)

    rangeses, idxseses = OC.Get_Hierarchical_Clusters_Steepness( xi = 0.05, 
                                                             steep_tolerance_pts=0, 
                                                             min_cluster_pts=3 )

    var_ms = 0.005974252984

    Check_Func = lambda x, th1, th2 : np.mean(x[1]) > th1 and np.var(x[0]) < th2
    Check_Func2 = lambda x : Check_Func(x, -10.5, var_ms)

    out_ranges, out_idxses = Select_Best_Clusters(rangeses, idxseses, data, Check_Func2)

    print out_ranges
    print out_idxses