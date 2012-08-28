import numpy as np
import os
import ExtractFrames as EF
import Processing as P
import ThresholdProcessing as TP
import SignalProcessing as SP


################################################################################
class FileDataGenerator:

################################################################################
    def __init__(self, FileOrDir, DSPconf):
        self.DSPconf = DSPconf
        
        if os.path.isdir(FileOrDir) :
            self.filelist = os.listdir(FileOrDir)
            for ii in range(len(self.filelist)) :
                self.filelist[ii] = FileOrDir + '/' + self.filelist[ii]
        else :
            self.filelist = [FileOrDir]

        self.file_cnt = -1
        self.f = 0

        ##########

        self.tf = TP.ThresholdFilter(DSPconf)


        ##########

        self.accum = np.array([], dtype=np.uint8)

        self.frame_cnt_history   = np.array([], dtype=np.uint32)
        self.frame_FIFO          = []
        self.frame_cnt_FIFO      = np.array([], dtype=np.uint32)

        self.IterateFileList()


################################################################################
    def __del__( self ) :

        self.CloseCurrentFile()

################################################################################
    def GetFrames(self):
        DSPconf = self.DSPconf

        while self.f != 0 :

            temp = np.fromfile(self.f, dtype=np.uint8, count=600)
    
            if temp.size == 0 :
                self.IterateFileList()
                continue

            self.accum = np.append( self.accum, temp )
    
            ( frames, frame_cnt, self.accum ) = EF.ExtractFrames( self.accum, DSPconf )
    
            if len(frames) == 0 :
                continue

            self.frame_FIFO += frames
            self.frame_cnt_FIFO = np.append( self.frame_cnt_FIFO, frame_cnt )

            break
    

################################################################################
    def data_gen(self):
        DSPconf = self.DSPconf

        while self.f != 0 :
            self.GetFrames()
    
            ( self.frame_FIFO, self.frame_cnt_FIFO, self.frame_cnt_history, frame_starts, missing_frames, buff ) = P.Processing( self.frame_FIFO, self.frame_cnt_FIFO, self.frame_cnt_history, DSPconf )

            if buff.size == 0 :
                continue

            ( I_buff, Q_buff, spectrum, I_spectrum, Q_spectrum ) = SP.SignalProcessing( buff, DSPconf )

            if I_buff.size == 0 or Q_buff.size == 0:
                continue

            yield self.frame_cnt_history, frame_starts, missing_frames, I_buff, Q_buff, spectrum, I_spectrum, Q_spectrum


################################################################################
    def data_gen_th(self):
        DSPconf = self.DSPconf

        frame_FIFO          = []
        frame_cnt_FIFO      = np.array([], dtype=np.uint32)

        while self.f != 0 :
            self.GetFrames()

            (self.frame_FIFO, self.frame_cnt_FIFO, frame_FIFO, frame_cnt_FIFO) = self.tf.ThresholdProcessing( self.frame_FIFO, self.frame_cnt_FIFO, frame_FIFO, frame_cnt_FIFO )
    
            ( frame_FIFO, frame_cnt_FIFO, self.frame_cnt_history, frame_starts, missing_frames, buff ) = P.Processing( frame_FIFO, frame_cnt_FIFO, self.frame_cnt_history, DSPconf )

            if buff.size == 0 :
                continue

            ( I_buff, Q_buff, spectrum, I_spectrum, Q_spectrum ) = SP.SignalProcessing( buff, DSPconf )

            if I_buff.size == 0 or Q_buff.size == 0:
                continue

            yield self.frame_cnt_history, frame_starts, missing_frames, I_buff, Q_buff, spectrum, I_spectrum, Q_spectrum


################################################################################
    def CloseCurrentFile(self):
        if self.f != 0 :
            self.f.close()
            self.f = 0
            print 'Closed file: %s' % (self.filelist[self.file_cnt])
             

################################################################################
    def IterateFileList(self):

        self.CloseCurrentFile()

        self.file_cnt += 1
        if self.file_cnt < len(self.filelist) :
            print 'Opening file: %s' % (self.filelist[self.file_cnt])
            self.f = open(self.filelist[self.file_cnt], 'rb')


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