import numpy as np

def Estimate_Multivariate_Normal_Parameters(x):
    mu = np.mean(x, 1)
    sigma = np.cov(x)

    return mu, sigma