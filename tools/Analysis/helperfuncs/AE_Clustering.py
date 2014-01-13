import numpy as np
from Clustering.Optics_Clustering                       import Optics_Clustering
from Clustering.Select_Best_Clusters                    import Select_Best_Clusters
from Statistics.Estimate_Multivariate_Normal_Parameters import Estimate_Multivariate_Normal_Parameters
from Statistics.Plot_Scatter_Hists                      import Plot_Scatter_Hists


def AE_Clustering(x, y, sound_speed_mps, epsilon=1, min_pts=3, xi=0.06, steep_tolerance_pts=0, min_cluster_pts=4, standard_deviation_th_m = 0.3, log_qty_th = -3.5):
########################################################################
    data = np.array([x, y])

    OC = Optics_Clustering(data = data, 
                            epsilon = epsilon, 
                            min_pts = min_pts)

    rangeses, idxseses = OC.Get_Hierarchical_Clusters_Steepness( xi = xi, 
                                                        steep_tolerance_pts=steep_tolerance_pts, 
                                                        min_cluster_pts=min_cluster_pts )


########################################################################
    t_ms = standard_deviation_th_m / sound_speed_mps * 1e3
    var_ms = t_ms ** 2


########################################################################
    Check_Func = lambda x, th1, th2 : np.mean(x[1]) > th1 and np.var(x[0]) < th2
    Check_Func2 = lambda x : Check_Func(x, log_qty_th, var_ms)

    out_ranges, out_idxses = Select_Best_Clusters(rangeses, idxseses, data, Check_Func2)


########################################################################
    alpha = []
    mu = []
    sigma = []
    for cluster_idxs in out_idxses:
        m, s = Estimate_Multivariate_Normal_Parameters( data[:,cluster_idxs] )
        alpha.append(1.0)
        mu.append(m)
        sigma.append(s)
    
    alpha = np.array(alpha)
    mu = np.array(mu)
    sigma = np.array(sigma)


########################################################################
    Plot_Scatter_Hists(x, y, 
                        '', 'time diff [msec]', 'log10(quality idx) []', 
                        fitcurve=True, alpha=alpha, mu=mu, sigma=sigma,
                        cluster_idxs=out_idxses, correct_aspect=True)
