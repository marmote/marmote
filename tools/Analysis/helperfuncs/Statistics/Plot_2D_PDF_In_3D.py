from mpl_toolkits.mplot3d import Axes3D
from matplotlib import cm
import matplotlib.pyplot as plt

def Plot_2D_PDF_In_3D(X, Y, Z, title=None, xlabel=None, ylabel=None, zlabel=None, z_lim=None):
#    fig, axarr = plt.subplots(1, 1, sharex=True)
#    axarr.pcolormesh(X, Y, Z)
#    axarr.set_aspect('equal')

    fig = plt.figure()
    ax = fig.gca(projection='3d')
    
    #surf = ax.plot_surface(X, Y, Z)
    #surf = ax.plot_surface(X, Y, Z, rstride=1, cstride=1, cmap=cm.coolwarm, linewidth=0, antialiased=False)
    surf = ax.plot_surface(X, Y, Z, rstride=1, cstride=1, cmap=cm.jet, linewidth=0, antialiased=True)

    fig.colorbar(surf, shrink=0.75, aspect=8)
    
    if title is not None:
        ax.set_title(title)
        
    if xlabel is not None:
        ax.set_xlabel(xlabel)
        
    if ylabel is not None:
        ax.set_ylabel(ylabel)
        
    if zlabel is not None:
        ax.set_zlabel(zlabel)
		
    if z_lim is not None:
        ax.set_zlim(z_lim)