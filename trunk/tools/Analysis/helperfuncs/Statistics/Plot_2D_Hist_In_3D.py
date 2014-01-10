from Plot_Surface_With_Colorbar import Plot_Surface_With_Colorbar
import numpy as np

def Plot_2D_Hist_In_3D(x, y, xedges_in, yedges_in, title=None, xlabel=None, ylabel=None, zlabel=None):

    H, xedges_out, yedges_out = np.histogram2d(x, y, bins=(xedges_in, yedges_in), normed=True)
    H = H.transpose()
    X, Y = np.meshgrid(xedges_out[0:-1], yedges_out[0:-1])

#    print X
#    print Y

    Plot_Surface_With_Colorbar(X, Y, H,
			title=title, xlabel=xlabel, ylabel=ylabel, zlabel=zlabel)
