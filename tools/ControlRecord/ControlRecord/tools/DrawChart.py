import numpy as np

import matplotlib
matplotlib.use('WXAgg')
import matplotlib.pyplot as plt
import matplotlib.animation as animation

import time as ttt


################################################################################
class FancyDisplay:

################################################################################
    def __init__(self, DSPconf, N = 100, MF_hist_len = 100, FigureAnimated = True):

        self.Nsep               = 40
        self.DSPconf            = DSPconf
#        self.fig, self.axarr    = plt.subplots(4, 1)
        self.fig, self.axarr    = plt.subplots(3, 1)

        self.InitFigure(FigureAnimated, N, MF_hist_len)


################################################################################
    def InitFigure(self, FigureAnimated, N, MF_hist_len = 100):

    ########################################
    # Set variables    
        F_offset        = float(self.DSPconf.F_offset)
        Fs              = float(self.DSPconf.Fs)

        Full_Scale_dB   = self.DSPconf.Full_scale_dB()
        T               = 1 / Fs

    ########################################
    # Draw charts
        lines = []
        texts = []
        axarr = self.axarr


    # Missed frames history
        hax = axarr[0]

        lines.append( hax.plot([], [], '.-', animated=FigureAnimated)[0] )
        hax.set_xlim(-(MF_hist_len-1), 0)
#        hax.set_yscale("log")
        hax.set_ylim(-0.2,5)
        hax.set_title('Frame losses')
        hax.set_xlabel('frame #')
        hax.set_ylabel('lost frames')
    
    
    # Time
        hax = axarr[1]

        hax.hold(True)

        for ii in range(self.Nsep) :
            lines.append( hax.plot([], [], '-', animated=FigureAnimated)[0] ) #for frame separator indicators

        lines.append( hax.plot([], [], 'b.-', animated=FigureAnimated)[0] ) #for I
        lines.append( hax.plot([], [], 'g.-', animated=FigureAnimated)[0] ) #for Q

        texts.append( hax.text(0.98, 0.85, '', color='b', horizontalalignment='right', transform=hax.transAxes, animated=FigureAnimated) )
        texts.append( hax.text(0.98, 0.65, '', color='g', horizontalalignment='right', transform=hax.transAxes, animated=FigureAnimated) )

        hax.set_xlim(0, (N-1)*T*1e6)
        hax.set_ylim(-1, 1)
        hax.set_title('Time domain')
        hax.set_xlabel('time [usec]')
        hax.set_ylabel('Sample []')
    
        hax.hold(False)


    # Spectrum separate IQ
        hax = axarr[2]

        hax.hold(True)

        lines.append( hax.plot([], [], 'b', animated=FigureAnimated)[0] ) #for I
        lines.append( hax.plot([], [], 'g', animated=FigureAnimated)[0] ) #for Q
        lines.append( hax.plot([], [], 'ro', animated=FigureAnimated)[0] ) #for max points indicators
        lines.append( hax.plot([], [], 'ro', animated=FigureAnimated)[0] ) #for max points indicators
        
        texts.append( hax.text(0.98, 0.85, '', color='b', horizontalalignment='right', transform=hax.transAxes, animated=FigureAnimated) )
        texts.append( hax.text(0.98, 0.65, '', color='g', horizontalalignment='right', transform=hax.transAxes, animated=FigureAnimated) )
    
#        hax.set_xlim(freq[0]/1e6, freq[-1]/1e6)
        hax.set_xlim(F_offset, F_offset + Fs/2./1e6)
        hax.set_ylim(-Full_Scale_dB, 0)
        hax.set_title('Separate spectrum')
        hax.set_xlabel('Frequency [MHz]')
        hax.set_ylabel('Amplitude [dB]')

        hax.hold(False)


#    # Spectrum IQ
#        hax = axarr[3]
#
#        hax.hold(True)
#
#        lines.append( hax.plot([], [], 'b', animated=FigureAnimated)[0] )
#        lines.append( hax.plot([], [], 'ro', animated=FigureAnimated)[0] ) #for max points indicator
#
#        texts.append( hax.text(0.98, 0.85, '', color='b', horizontalalignment='right', transform=hax.transAxes, animated=FigureAnimated) )
#    
#        hax.set_xlim(F_offset - Fs/2./1e6, F_offset + Fs/2./1e6)
#        hax.set_ylim(-Full_Scale_dB, 0)
#        hax.set_title('Combined spectrum')
#        hax.set_xlabel('Frequency [MHz]')
#        hax.set_ylabel('Amplitude [dB]')
#
#        hax.hold(False)

    ########################################
    # Save line objects    
        self.GraphObjs = [lines, texts]

        self.fig.tight_layout()


################################################################################
    def InitObj(self):

        for ii in range(len(self.GraphObjs[0])):
            self.GraphObjs[0][ii].set_data([], [])

        for ii in range(len(self.GraphObjs[1])):
            self.GraphObjs[1][ii].set_text('')

        return self.GraphObjs[0] + self.GraphObjs[1]

        
################################################################################
    def DrawFigure(self, data):

        frame_starts, missing_frames, I_buff, Q_buff, I_spectrum, Q_spectrum, = data

    ########################################
    # Set variables    
        N               = int(I_buff.size)
        F_offset        = float(self.DSPconf.F_offset)
        Fs              = float(self.DSPconf.Fs)
        num_pos_fr      = int(self.DSPconf.num_pos_fr(N))
#        num_neg_fr      = int(self.DSPconf.num_neg_fr(N))

        T               = 1 / Fs
        F               = Fs / N


    ########################################
    # Update objects
        lines = self.GraphObjs[0]
        lines_cnt = 0
        texts = self.GraphObjs[1]
        texts_cnt = 0

    # Missed frames history    
        lines[lines_cnt].set_data(range(-(missing_frames.size-1),1), missing_frames)
        lines_cnt += 1


    # Time
        for ii in xrange(self.Nsep) :
            if ii < len(frame_starts) :
                x = ( frame_starts[-1-ii]*T - T/2 )*1e6

                lines[lines_cnt + ii].set_data([x, x], [-1, 1])

                if ii >= missing_frames.size :
                    lines[lines_cnt + ii].set_color('k')
                elif missing_frames[-1-ii] == 0 :
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

        texts[texts_cnt].set_text('I: Mean = %.3f' % (np.mean(I_buff)))
        texts_cnt += 1
        texts[texts_cnt].set_text('Q: Mean = %.3f' % (np.mean(Q_buff)))
        texts_cnt += 1


    # Spectrum separate IQ
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

        texts[texts_cnt].set_text('I: Max val = %.1f [dB]; Max f = %.1f [MHz]' % (I_val, I_max_f/1e6))
        texts_cnt += 1
        texts[texts_cnt].set_text('Q: Max val = %.1f [dB]; Max f = %.1f [MHz]' % (Q_val, Q_max_f/1e6))
        texts_cnt += 1


#    # Spectrum IQ
#        c_freq = np.array( range(-num_neg_fr,0) )
#        c_freq = np.append( c_freq, range(0,num_pos_fr) )
#        c_freq = c_freq*F + F_offset
#
#        lines[lines_cnt].set_data(c_freq/1e6, spectrum)
#        lines_cnt += 1
#
#        val     = spectrum.max()
#        max_f   = c_freq[spectrum.argmax()]
#
#        lines[lines_cnt].set_data(max_f/1e6, val)
#
#        texts[texts_cnt].set_text('Max val = %.1f [dB]; Max f = %.1f [MHz]' % (val, max_f/1e6))

        self.GraphObjs[0] = lines
        self.GraphObjs[1] = texts


################################################################################
    def Animate(self, data):
        self.DrawFigure(data)

    # FPS calculation
        self.displayed_frames += 1
        current_time = ttt.time()
        if current_time - self.previous_time > 3 :
            print '%.1f' % ( float(self.displayed_frames) / (current_time - self.previous_time) )
            self.displayed_frames = 0
            self.previous_time = current_time

        return self.GraphObjs[0] + self.GraphObjs[1]


################################################################################
    def SetupAnimation(self, data_gen):
        self.displayed_frames = 0
        self.previous_time = ttt.time()

        self.ani = animation.FuncAnimation(self.fig, self.Animate, data_gen, init_func=self.InitObj, blit=True, interval=1, repeat=False)

        # save the animation as an mp4.  This requires ffmpeg or mencoder to be
        # installed.  The extra_args ensure that the x264 codec is used, so that
        # the video can be embedded in html5.  You may need to adjust this for
        # your system: for more information, see
        # http://matplotlib.sourceforge.net/api/animation_api.html
#        self.ani.save('basic_animation.mp4', fps=30, extra_args=['-vcodec', 'libx264'])


################################################################################
    def ShowFigure(self):
        plt.draw()
        plt.show()


