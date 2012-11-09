import numpy as np


def SignalGenerator(N = 2048*2, Fs = 1e3, f_start = 100, f_stop = 300, f_steps = 3) :
    
    Fs = float(Fs)
    Ts = 1/Fs
    f_start = float(f_start)
    f_stop = float(f_stop)

#f = (f_stop - f_start)/(N-1)*np.array(range(N)) + f_start

#f = np.concatenate((f[0:N/2], np.ones(N/2)*f_stop/2))

    f = (f_stop - f_start)/(N-1)*np.array(range(N))
    f_max = float(f_stop-f_start)
    f_temp = f/f_max*f_steps
    f = f_temp.astype(int)*f_max/(f_steps-1) + f_start

    fint = np.zeros(N)
    fint[0] = f[0]
    for ii in xrange(N-1) :
        fint[ii+1] = fint[ii] + (f[ii+1]-f[ii])*Ts/2 + f[ii]*Ts
    
    return np.sin(2*np.pi*fint)