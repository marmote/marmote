import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation
import time as ttt


################################################################################
class FancyDisplay:

################################################################################
    def __init__(self, data_gen, DSPconf):

        self.Nsep               = 5
        self.DSPconf            = DSPconf
        self.fig, self.axarr    = plt.subplots(4, 1)

        self.InitFigure()

        self.fig.tight_layout()

        self.displayed_frames = 0
        self.previous_time = ttt.time()

        self.ani = animation.FuncAnimation(self.fig, self.AnimateFigure, data_gen, init_func=self.InitObj, blit=True, interval=1, repeat=False)

        # save the animation as an mp4.  This requires ffmpeg or mencoder to be
        # installed.  The extra_args ensure that the x264 codec is used, so that
        # the video can be embedded in html5.  You may need to adjust this for
        # your system: for more information, see
        # http://matplotlib.sourceforge.net/api/animation_api.html
#        self.ani.save('basic_animation.mp4', fps=30, extra_args=['-vcodec', 'libx264'])


################################################################################
    def InitFigure(self):

    ########################################
    # Set variables    
        N               = int(self.DSPconf.N)
        F_offset        = float(self.DSPconf.F_offset)
        Fs              = float(self.DSPconf.Fs)
        Full_Scale      = int(self.DSPconf.Full_scale)
        MF_hist_len     = int(self.DSPconf.MF_hist_len)
        num_pos_fr      = int(self.DSPconf.num_pos_fr)
        num_neg_fr      = int(self.DSPconf.num_neg_fr)


        Full_Scale_dB   = 20 * np.log10(2*float(Full_Scale))
        T               = 1 / Fs
        F               = Fs / N

        freq = np.array( range(0,num_pos_fr) )
        freq = freq*F + F_offset

        c_freq = np.array( range(-num_neg_fr,0) )
        c_freq = np.append( c_freq, range(0,num_pos_fr) )
        c_freq = c_freq*F + F_offset

    ########################################
    # Draw charts
        lines = []
        texts = []
        axarr = self.axarr


    # Missed frames history
        hax = axarr[0]

        lines.append( hax.plot([], [], '.-', animated=True)[0] )
        hax.set_xlim(-(MF_hist_len-1), 0)
#        hax.set_yscale("log")
        hax.set_ylim(0,100)
        hax.set_title('Frame losses')
        hax.set_xlabel('frame #')
        hax.set_ylabel('lost frames')
    
    
    # Time
        hax = axarr[1]

        hax.hold(True)

        for ii in range(self.Nsep) :
            lines.append( hax.plot([], [], '-', animated=True)[0] ) #for frame separator indicators

        lines.append( hax.plot([], [], 'b.-', animated=True)[0] ) #for I
        lines.append( hax.plot([], [], 'g.-', animated=True)[0] ) #for Q
        hax.set_xlim(0, N*T*1e6)
        hax.set_ylim(-1, 1)
        hax.set_title('Time domain')
        hax.set_xlabel('time [usec]')
        hax.set_ylabel('Sample []')
    
        hax.hold(False)


    # Spectrum separate IQ
        hax = axarr[2]

        hax.hold(True)

        lines.append( hax.plot([], [], 'b', animated=True)[0] ) #for I
        lines.append( hax.plot([], [], 'g', animated=True)[0] ) #for Q
        lines.append( hax.plot([], [], 'ro', animated=True)[0] ) #for max points indicators
        lines.append( hax.plot([], [], 'ro', animated=True)[0] ) #for max points indicators
        
        texts.append( hax.text(0.98, 0.85, '', color='b', horizontalalignment='right', transform=hax.transAxes) )
        texts.append( hax.text(0.98, 0.65, '', color='g', horizontalalignment='right', transform=hax.transAxes) )
    
        hax.set_xlim(freq[0]/1e6, freq[-1]/1e6)
        hax.set_ylim(-Full_Scale_dB, 0)
        hax.set_title('Separate spectrum')
        hax.set_xlabel('Frequency [MHz]')
        hax.set_ylabel('Amplitude [dB]')

        hax.hold(False)


    # Spectrum IQ
        hax = axarr[3]

        hax.hold(True)

        lines.append( hax.plot([], [], 'b', animated=True)[0] )
        lines.append( hax.plot([], [], 'ro', animated=True)[0] ) #for max points indicator

        texts.append( hax.text(0.98, 0.85, '', color='b', horizontalalignment='right', transform=hax.transAxes) )
    
        hax.set_xlim(c_freq[0]/1e6, c_freq[-1]/1e6)
        hax.set_ylim(-Full_Scale_dB, 0)
        hax.set_title('Combined spectrum')
        hax.set_xlabel('Frequency [MHz]')
        hax.set_ylabel('Amplitude [dB]')

        hax.hold(False)

    ########################################
    # Save line objects    
        self.GraphObjs = [lines, texts]


################################################################################
    def InitObj(self):

        for ii in range(len(self.GraphObjs[0])):
            self.GraphObjs[0][ii].set_data([], [])

        for ii in range(len(self.GraphObjs[1])):
            self.GraphObjs[1][ii].set_text('')

        return self.GraphObjs[0] + self.GraphObjs[1]

        
################################################################################
    def AnimateFigure(self, data):

        frame_cnt_history, frame_starts, missing_frames, I_buff, Q_buff, spectrum, I_spectrum, Q_spectrum, DSPconf = data

    ########################################
    # Set variables    
        N               = int(self.DSPconf.N)
        F_offset        = float(self.DSPconf.F_offset)
        Fs              = float(self.DSPconf.Fs)
        Full_Scale      = int(self.DSPconf.Full_scale)
        MF_hist_len     = int(self.DSPconf.MF_hist_len)
        num_pos_fr      = int(self.DSPconf.num_pos_fr)
        num_neg_fr      = int(self.DSPconf.num_neg_fr)


        Full_Scale_dB   = 20 * np.log10(2*float(Full_Scale))
        T               = 1 / Fs
        F               = Fs / N


    ########################################
    # Update objects
        lines = self.GraphObjs[0]
        lines_cnt = 0
        texts = self.GraphObjs[1]
        texts_cnt = 0

    # Missed frames history    
        MF_history = frame_cnt_history[1:] - frame_cnt_history[:-1] - 1

        lines[lines_cnt].set_data(range(-(MF_history.size-1),1), MF_history)
        lines_cnt += 1


    # Time
        for ii in range(self.Nsep) :
            if ii < len(frame_starts) :
                x = ( frame_starts[ii]*T - T/2 )*1e6

                lines[lines_cnt + ii].set_data([x, x], [-1, 1])

                if missing_frames[ii] == 0 :
                    lines[lines_cnt + ii].set_color('g')
                else :
                    lines[lines_cnt + ii].set_color('r')
            else :
                lines[lines_cnt + ii].set_data([], [])

        lines_cnt += self.Nsep

        time = np.array( range(0,N) ) *T

        lines[lines_cnt].set_data(time*1e6, I_buff)
        lines_cnt += 1
        lines[lines_cnt].set_data(time*1e6, Q_buff)
        lines_cnt += 1


    # Spectrum
        freq = np.array( range(0,num_pos_fr) )
        freq = freq*F + F_offset

        lines[lines_cnt].set_data(freq/1e6, I_spectrum)
        lines_cnt += 1
        lines[lines_cnt].set_data(freq/1e6, Q_spectrum)
        lines_cnt += 1

        I_val   = I_spectrum.max()
        I_max_f = freq[I_spectrum.argmax()]
        Q_val   = Q_spectrum.max()
        Q_max_f = freq[Q_spectrum.argmax()]

        lines[lines_cnt].set_data(I_max_f/1e6, I_val)
        lines_cnt += 1
        lines[lines_cnt].set_data(Q_max_f/1e6, Q_val)
        lines_cnt += 1

        texts[texts_cnt].set_text('I: Max val = %.1f [dB]; Max f = %.1f [MHz]' % (I_val, I_max_f))
        texts_cnt += 1
        texts[texts_cnt].set_text('Q: Max val = %.1f [dB]; Max f = %.1f [MHz]' % (Q_val, Q_max_f))
        texts_cnt += 1


        c_freq = np.array( range(-num_neg_fr,0) )
        c_freq = np.append( c_freq, range(0,num_pos_fr) )
        c_freq = c_freq*F + F_offset

        lines[lines_cnt].set_data(c_freq/1e6, spectrum)
        lines_cnt += 1

        val     = spectrum.max()
        max_f   = c_freq[spectrum.argmax()]

        lines[lines_cnt].set_data(max_f/1e6, val)

        texts[texts_cnt].set_text('Max val = %.1f [dB]; Max f = %.1f [MHz]' % (val, max_f))

        self.GraphObjs[0] = lines
        self.GraphObjs[1] = texts

    # FPS calculation
        self.displayed_frames += 1
        current_time = ttt.time()
        if current_time - self.previous_time > 3 :
            print float(self.displayed_frames) / (current_time - self.previous_time) 
            self.displayed_frames = 0
            self.previous_time = current_time

        return self.GraphObjs[0] + self.GraphObjs[1]


################################################################################
def DrawChart(axarr, frame_cnt_history, frame_starts, missing_frames, I_buff, Q_buff, spectrum, I_spectrum, Q_spectrum, DSPconf):

########################################
# Set variables    
    N               = int(DSPconf.N)
    F_offset        = float(DSPconf.F_offset)
    Fs              = float(DSPconf.Fs)
    Full_Scale      = int(DSPconf.Full_scale)


    Full_Scale_dB   = 20 * np.log10(2*float(Full_Scale))
    T               = 1 / Fs
    F               = Fs / N
    num_pos_fr      = N/2+1             #positive and zero frequency bins
    num_neg_fr      = N - num_pos_fr    #negative frequency bins    


########################################
# Draw charts
    if I_buff.size != N or Q_buff.size != N:
        return


    c_freq = np.array( range(-num_neg_fr,0) )
    c_freq = np.append( c_freq, range(0,num_pos_fr) )
    c_freq = c_freq*F + F_offset

    val     = spectrum.max()
    max_f   = c_freq[spectrum.argmax()]

    
    freq = np.array( range(0,num_pos_fr) )
    freq = freq*F + F_offset

    time = np.array( range(0,N) ) *T

    I_val   = I_spectrum.max()
    I_max_f = freq[I_spectrum.argmax()]
    Q_val   = Q_spectrum.max()
    Q_max_f = freq[Q_spectrum.argmax()]


# Missing frames history    
    MF_history = frame_cnt_history[1:] - frame_cnt_history[:-1] - 1

#    hax = fig_handle.add_subplot(4, 1, 1)
    hax = axarr[0]
    hax.plot(MF_history, '.-')
    hax.set_xlim(0, MF_history.size-1)
    
    
# Time
    hax = axarr[1]
    hax.hold(True)

    for ii in range(len(frame_starts)) :
        x = ( frame_starts[ii]*T - T/2 )*1e6
        if missing_frames[ii] == 0 :
            hax.plot([x, x], [-1, 1], 'g-')
        else :
            hax.plot([x, x], [-1, 1], 'r-')
    
    hax.plot(time*1e6, I_buff, 'b.-')
    hax.plot(time*1e6, Q_buff, 'g.-')
    hax.set_xlim(0, N*T*1e6)
    hax.set_ylim(-1, 1)
    hax.set_xlabel('time [usec]')
    hax.set_ylabel('Sample []')
    
    hax.hold(False)

# Spectrum
    hax = axarr[2]

    hax.hold(True)
    hax.plot(freq/1e6, I_spectrum, 'b')
    hax.plot(freq/1e6, Q_spectrum, 'g')
    hax.plot(I_max_f/1e6, I_val, 'ro')
    hax.plot(Q_max_f/1e6, Q_val, 'ro')
    
    hax.set_xlim(freq[0]/1e6, freq[-1]/1e6)
    hax.set_ylim(-Full_Scale_dB, 0)
#   title(hax, ['Max val I: ' num2str(I_val, '%.1f') ' [dB]; Max f I: ' num2str(I_max_f/1e6, '%.1f') ' [MHz]; Max val Q: ' num2str(Q_val, '%.1f') ' [dB]; Max f Q: ' num2str(Q_max_f/1e6, '%.1f') ' [MHz]']);
    hax.set_xlabel('Frequency [MHz]')
    hax.set_ylabel('Amplitude [dB]')
    hax.hold(False)
    

    hax = axarr[3]

    hax.hold(True)
    hax.plot(c_freq/1e6, spectrum, 'b')
    hax.plot(max_f/1e6, val, 'ro')
    
    hax.set_xlim(c_freq[0]/1e6, c_freq[-1]/1e6)
    hax.set_ylim(-Full_Scale_dB, 0)
#    title(hax, ['Max val: ' num2str(val, '%.1f') ' [dB]; Max f: ' num2str(max_f/1e6, '%.1f') ' [MHz];']);
    hax.set_xlabel('Frequency [MHz]')
    hax.set_ylabel('Amplitude [dB]')
    hax.hold(False)
    
    plt.tight_layout()
    plt.draw()



################################################################################
#if __name__ == "__main__":
#
#    class DSPconf_t:
#        def __init__(self):
#            self.F_offset    = 0
#            self.Fs          = 1e6
#            self.channels    = 2
#            self.N           = 50
#            self.Full_scale  = 2**(16 - 1)
#
#
#    DSPconf = DSPconf_t()
#    N = DSPconf.N 
#
#
#    frame_cnt_history   = np.array([1, 2, 3, 4, 5], dtype=np.uint32)
#    frame_starts        = [0, 25, 40]
#    missing_frames      = np.array([1, 0, 3], dtype=np.uint32)
#    I_buff              = np.array(range(0,N), dtype=np.float)/N          
#    Q_buff              = np.array(range(N,0,-1), dtype=np.float)/N
#    spectrum            = np.array(range(0,N), dtype=np.float64)-90            
#    I_spectrum          = np.array(range(0,N/2+1), dtype=np.float64)-90
#    Q_spectrum          = np.array(range(N/2+1,0,-1), dtype=np.float64)-90           
#
#
#    fig_handle, axarr = CreateFigure()
#
#    DrawChart(axarr, frame_cnt_history, frame_starts, missing_frames, I_buff, Q_buff, spectrum, I_spectrum, Q_spectrum, DSPconf)
#
#    plt.show()