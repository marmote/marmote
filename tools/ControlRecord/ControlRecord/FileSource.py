import numpy as np
import os


################################################################################
class FileSource:

################################################################################
    def __init__(self, FileOrDir):
        
        if os.path.isdir(FileOrDir) :
            self.filelist = os.listdir(FileOrDir)
            for ii in range(len(self.filelist)) :
                self.filelist[ii] = FileOrDir + '/' + self.filelist[ii]
        else :
            self.filelist = [FileOrDir]

        self.file_cnt = -1
        self.f = None

        self.IterateFileList()


################################################################################
    def __del__( self ) :

        self.CloseCurrentFile()


################################################################################
    def SourceEmpty( self ) :

        return self.f is None


################################################################################
    def GetBuffer(self, N = 600):

        accum = np.array([], dtype=np.uint8)

        while not self.SourceEmpty() and accum.size < N :
            N_new = N-accum.size

            temp = np.fromfile(self.f, dtype=np.uint8, count=N_new)

            if temp.size == 0 :
                self.IterateFileList()
                continue

            accum = np.append(accum, temp)

        return accum


################################################################################
    def CloseCurrentFile(self):
        if not self.f is None :
            self.f.close()
            self.f = None
            print 'Closed file: %s' % (self.filelist[self.file_cnt])
             

################################################################################
    def IterateFileList(self):

        self.CloseCurrentFile()

        self.file_cnt += 1
        if self.file_cnt < len(self.filelist) :
            print 'Opening file: %s' % (self.filelist[self.file_cnt])
            self.f = open(self.filelist[self.file_cnt], 'rb')
