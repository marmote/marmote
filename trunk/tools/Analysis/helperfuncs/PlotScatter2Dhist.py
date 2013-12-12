import matplotlib.pyplot as plt
import numpy as np
import MultivariateNormalPDF as MNPDF


##############################
def PlotScatter(x, y, xlabel, ylabel, xlim_min=-1, xlim_max=1):
    fig, ax = plt.subplots(1, 1, sharex=True, sharey=True ) 

    ax.scatter(x, y)
    
    ax.set_xlabel(xlabel)
    ax.set_ylabel(ylabel)
    ax.set_xlim(xlim_min, xlim_max)


##############################
def PlotScatter2Dhist(x, y, 
            xlabel, ylabel, 
            xbins=25, ybins=25, 
            xlim_min=None, xlim_max=None, ylim_min=None, ylim_max=None, 
            fitcurve=False, alpha=None, mu=None, sigma=None,
            cluster_idxs=None, correct_aspect=None):
    fig, axScatter = plt.subplots(1, 1, sharex=True, sharey=True )



    # the scatter plot:
    if cluster_idxs is None:
        axScatter.scatter(x, y)
    else:
        axScatter.scatter(x, y, c='w')

        #b: blue
        #g: green
        #r: red
        #c: cyan
        #m: magenta
        #y: yellow
        #k: black
        #w: white

        colors = "rcmyk" 
        for ii in xrange( len(cluster_idxs) ):
            idxs = cluster_idxs[ii]
            c = colors[ii % len(colors)]
            axScatter.scatter(x[idxs], y[idxs], c=c)

    if (correct_aspect is not None) and correct_aspect:
        fig.set_figheight( fig.get_figheight()* 3)
        axScatter.set_aspect(1.)

    if xlim_min is None:
        xlim_min = axScatter.get_xlim()[0]
    if xlim_max is None:
        xlim_max = axScatter.get_xlim()[1]
    if ylim_min is None:
        ylim_min = axScatter.get_ylim()[0]
    if ylim_max is None:
        ylim_max = axScatter.get_ylim()[1]

    if fitcurve:
        gridstep = 100
        xi = np.linspace(xlim_min, xlim_max, gridstep)
        yi = np.linspace(ylim_min, ylim_max, gridstep)
        zi = np.zeros((xi.size, yi.size))

        axScatter.hold('on')
        for g in xrange(alpha.size):
            for ix in xrange(xi.size):
                for iy in xrange(yi.size):
                    zi[iy, ix] = MNPDF.MultivariateNormalPDF(np.array([xi[ix], yi[iy]]), mu[g,:], sigma[g,:,:]) * alpha[g]

            axScatter.contour(xi,yi,zi,linewidths=0.5)
        axScatter.hold('off')


    # create new axes on the right and on the top of the current axes
    # The first argument of the new_vertical(new_horizontal) method is
    # the height (width) of the axes to be created in inches.
    from mpl_toolkits.axes_grid1 import make_axes_locatable
    divider = make_axes_locatable(axScatter)
    axHistx = divider.append_axes("top", 1.2, pad=0.1, sharex=axScatter)
    axHisty = divider.append_axes("right", 1.2, pad=0.1, sharey=axScatter)

    # make some labels invisible
    plt.setp(axHistx.get_xticklabels() + axHisty.get_yticklabels(),
            visible=False)

    axHistx.hist(x, bins=xbins)
    axHisty.hist(y, bins=ybins, orientation='horizontal')

    # the xaxis of axHistx and yaxis of axHisty are shared with axScatter,
    # thus there is no need to manually adjust the xlim and ylim of these
    # axis.

    #axHistx.axis["bottom"].major_ticklabels.set_visible(False)
    for tl in axHistx.get_xticklabels():
        tl.set_visible(False)
    #axHistx.set_yticks([0, 50, 100])

    #axHisty.axis["left"].major_ticklabels.set_visible(False)
    for tl in axHisty.get_yticklabels():
        tl.set_visible(False)
    labels = axHisty.get_xticklabels()
    plt.setp(labels, rotation=90)        
    #axHisty.set_xticks([0, 50, 100])

    axScatter.set_xlim(xlim_min, xlim_max)
    axScatter.set_ylim(ylim_min, ylim_max)

    axHistx.set_xlim( axScatter.get_xlim() )
    axHisty.set_ylim( axScatter.get_ylim() )    

    axScatter.set_xlabel(xlabel)
    axScatter.set_ylabel(ylabel)


################################################################################
if __name__ == "__main__":
    x = np.concatenate( (np.random.normal(-0.5, 0.1, 100), np.random.normal(0.5, 0.1, 100)) )
    y = np.concatenate( (np.random.normal(-0.5, 0.1, 100), np.random.normal(0.0, 0.1, 100)) )

    alpha = np.array([0.8, 0.1, 0.1])
    mu = np.array([[0.1, -0.75], [0.2, 0.5], [0.8, 0.7]])
    sigma = np.array( [[[0.2, 0.0],[0.0, 0.4]], [[0.005, 0.0],[0.0, 0.3]], [[0.005, 0.0],[0.0, 0.3]]] )

    PlotScatter2Dhist(x, y, "sdgh", "dfgh", ylim_min=-1.5, ylim_max=1.5, fitcurve=True, alpha=alpha, mu=mu, sigma=sigma)


######################
#    x = np.concatenate( (np.random.normal(-0.5, 0.1, 100), np.random.normal(0.5, 0.1, 100)) )
#    y = np.concatenate( (np.random.normal(-0.5, 0.1, 100), np.random.normal(0.0, 0.1, 100)) )
#
#    from Estimate_Multivariate_Normal_Parameters import Estimate_Multivariate_Normal_Parameters
#
#    data = np.array([x, y])
#    cluster_idxs = [range(0,100), range(100,200)]
#    mu0, sigma0 = Estimate_Multivariate_Normal_Parameters( data[:,cluster_idxs[0]] )
#    mu1, sigma1 = Estimate_Multivariate_Normal_Parameters( data[:,cluster_idxs[1]] )
#
#    alpha = np.array([1.0, 1.0])
#    mu = np.array([mu0, mu1])
#    sigma = np.array([sigma0, sigma1])
#
#    PlotScatter2Dhist(x, y, "sdgh", "dfgh", ylim_min=-1.5, ylim_max=1.5, fitcurve=True, alpha=alpha, mu=mu, sigma=sigma)


######################
#    x = np.array([1,2,3,1,2,3,1,2,3])
#    y = np.array([1,1,1,2,2,2,3,3,3])
#
#    PlotScatter2Dhist( x, y, "sdgh", "dfgh", cluster_idxs=[[1, 2, 3, 4, 5, 6, 7, 8]] )
######################

    plt.show()