import numpy as np

def Get_Empirical_CDF(random_var_samples):
    N = len(random_var_samples)

    y = np.arange(N, dtype='double')/N
    x = np.sort(random_var_samples)

    return x, y
