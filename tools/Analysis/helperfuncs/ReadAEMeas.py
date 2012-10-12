import numpy as np
import os
import sys

mpath = os.path.split(__file__)[0]
addpath = os.path.abspath(os.path.join(mpath, '..\\..\\ControlRecord\\ControlRecord'))

if addpath not in sys.path :
	sys.path.append(addpath)
	print 'Module folder added to system path'


import tools.DSPConfig				as conf
import tools.FileSource				as FS
import tools.GenerateDisplayData	as GDD
import tools.SignalProcessing		as SP


def keynat(string):
    r'''A natural sort helper function for sort() and sorted()
    without using regular expression.

    >>> items = ('Z', 'a', '10', '1', '9')
    >>> sorted(items)
    ['1', '10', '9', 'Z', 'a']
    >>> sorted(items, key=keynat)
    ['1', '9', '10', 'Z', 'a']
    '''
    r = []
    for c in string:
        try:
            c = int(c)
            try: r[-1] = r[-1] * 10 + c
            except: r.append(c)
        except:
            r.append(c)
    return r   

	
def ReadAEMeas(dir):
	""""""
#Generate file list

	DSPconf = conf.DSPconf_t()
	Display_N = 0
	MF_hist_len = 4

	filelist_in = os.listdir(dir)
	filepath = []
	filelist = []

	for ii in xrange(len(filelist_in)) :
		fname = dir + '/' + filelist_in[ii]
		if os.path.isfile(fname) :
			filepath.append(fname)
			filelist.append(filelist_in[ii])

     
	filepath = sorted(filepath, key=keynat)        
	filelist = sorted(filelist, key=keynat) 

	
#Extract data
	Fs	= float(DSPconf.Fs)    
	T	= 1 / Fs * 1e6
	
	th_cross_level = 0.15
	
	
	y = []
	y2 = []
	AE_start = []
	AE_start2 = []
	TD_meas = []
	fnames = []


	for ii in xrange(len(filelist)) :
	#Read files
		source = FS.FileSource(filepath[ii])
		dg = GDD.DisplayDataGenerator(source, DSPconf, Display_N, MF_hist_len)

		dg.GetPreProcessedBuff()

		if dg.int_buff.size == 0 :
			continue

		frame_starts, I_buff, Q_buff, I_spectrum, Q_spectrum, spectrum = SP.SignalProcessing( dg.frame_starts, dg.int_buff, DSPconf )  # Assumes 2 channels !!!

	#Generate data
	
		#Find AE signal beginnings
		max_val = np.amax(np.absolute(I_buff))
		val = 0
		for jj in xrange(I_buff.size) :
			if I_buff[jj] >= max_val*th_cross_level : 
				val = jj
				break
		AE_start.append(val * T)
    
		max_val2 = np.amax(np.absolute(Q_buff))
		val = 0
		for jj in xrange(Q_buff.size) :
			if Q_buff[jj] >= max_val2*th_cross_level : 
				val = jj
				break
		AE_start2.append(val * T)
		
		TD_meas.append(AE_start2[-1] - AE_start[-1])

        #output    
		y.append(I_buff)
		y2.append(Q_buff)
    
		fnames.append(filelist[ii])
	
	return y, y2, AE_start, AE_start2, TD_meas, T, fnames
