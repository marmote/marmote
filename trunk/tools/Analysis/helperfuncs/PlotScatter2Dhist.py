import matplotlib.pyplot as plt


def PlotScatter(x, y, xlabel, ylabel, xlim_min=-1, xlim_max=1):
    fig, ax = plt.subplots(1, 1, sharex=True, sharey=True ) 

    ax.scatter(x, y)
    
    ax.set_xlabel(xlabel)
    ax.set_ylabel(ylabel)
    ax.set_xlim(xlim_min, xlim_max)


def PlotScatter2Dhist(x, y, xlabel, ylabel, xbins=25, ybins=25, xlim_min=-1, xlim_max=1):
    fig, axScatter = plt.subplots(1, 1, sharex=True, sharey=True )

    # the scatter plot:
    axScatter.scatter(x, y)
    #axScatter.set_aspect(1.)

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
    axHistx.set_xlim( axScatter.get_xlim() )
    axHisty.set_ylim( axScatter.get_ylim() )    
    
    axScatter.set_xlabel(xlabel)
    axScatter.set_ylabel(ylabel)