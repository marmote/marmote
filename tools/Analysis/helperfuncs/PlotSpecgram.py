import numpy as np
import matplotlib.pyplot as plt

def PlotSpecgram(y, Fs) :
    fig, ax = plt.subplots(1, 1, sharex=True, sharey=True ) 

    NFFT = 32
    noverlap = 16

    time_max = y.size/Fs - NFFT/Fs

    Pxx, freqs, bins, im = ax.specgram(y, NFFT = NFFT, noverlap = noverlap, Fs = Fs, interpolation='nearest', cmap='spectral')
    fig.colorbar(im)

    ax.set_title('DSTFFT/Spectrogram\nhigh-res time, low-res fr; window size: %d overlap: %d'%(NFFT, noverlap))
    ax.set_xlabel('time [sec]')
    ax.set_ylabel('frequency [Hz]')
    ax.set_xlim(0, time_max)
    ax.set_ylim(0, Fs/2)


    fig, ax = plt.subplots(1, 1, sharex=True, sharey=True ) 

    NFFT = 2048
    noverlap = 2000

    time_max = y.size/Fs - NFFT/Fs

    Pxx, freqs, bins, im = ax.specgram(y, NFFT = NFFT, noverlap = noverlap, Fs = Fs, interpolation='nearest', cmap='spectral')
    fig.colorbar(im)

    ax.set_title('DSTFFT/Spectrogram\nlow-res time, high-res fr; window size: %d overlap: %d'%(NFFT, noverlap))
    ax.set_xlabel('time [sec]')
    ax.set_ylabel('frequency [Hz]')
    ax.set_xlim(0, time_max)
    ax.set_ylim(0, Fs/2)