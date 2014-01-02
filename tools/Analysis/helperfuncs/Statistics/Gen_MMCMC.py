import time as ttt
import numpy as np


def Gen_MMCMC( N, variance, func, lim_x, lim_y, sample_discard_criterion=(lambda x,y : np.random.rand() > float(x)/y) ):
    previous_time = ttt.time()

    proposed_cnt = 0.0
    x = 0
    y = 0
    p = func(x, y)
    x_list = []
    y_list = []
    while len(x_list) < N:
        current_time = ttt.time()
        if current_time - previous_time > 3 :
            print 'Progress: %d/%d %.2f%%' % ( len(x_list), N, float(len(x_list)) / N * 100 )
            previous_time = current_time
	

        #Uniform distribution
        w = np.sqrt(12*variance)
        x_cand = x + w*np.random.rand() - w/2;
        y_cand = y + w*np.random.rand() - w/2;

        proposed_cnt = proposed_cnt + 1.0

        if x_cand < lim_x[0] or x_cand > lim_x[1] or y_cand < lim_y[0] or y_cand > lim_y[1]:
            continue

        p_cand = func(x_cand, y_cand)

#        if np.random.rand() > float(p_cand)/p:
        if sample_discard_criterion(p_cand, p):
            continue

        x = x_cand
        y = y_cand
        p = p_cand

        x_list.append(x)
        y_list.append(y)

    accept_rate = (N / proposed_cnt) * 100

    return x_list, y_list, accept_rate