import numpy as np
import os

import time as ttt

from HumanReadableDataSize import GetHumanReadableDataSize
from keynat import keynat


################################################################################
class FileSource:

################################################################################
    def __init__(self, FileOrDir):
        
        if os.path.isdir(FileOrDir) :
            self.filelist_in = os.listdir(FileOrDir)
            self.filelist_in.sort( key=keynat )

            self.filelist = []
            for ii in range(len(self.filelist_in)) :
                fname = FileOrDir + '/' + self.filelist_in[ii]
                if os.path.isfile(fname) :
                    self.filelist.append(fname)
        else :
            self.filelist = [FileOrDir]

        self.file_cnt = -1
        self.f = None

        self.IterateFileList()
        
        self.bytes_read = 0
        self.previous_time = ttt.time()


################################################################################
    def __del__( self ) :

        self.CloseCurrentFile()


################################################################################
    def SourceEmpty( self ) :

        return self.f is None


################################################################################
    def GetBuffer(self, N = 1024):

        accum = np.array([], dtype=np.uint8)

        while not self.SourceEmpty() and accum.size < N :
            N_new = N-accum.size

            temp = np.fromfile(self.f, dtype=np.uint8, count=N_new)

            if temp.size == 0 :
                self.IterateFileList()
                continue

            accum = np.append(accum, temp)
            
            self.bytes_read_file += temp.size


        self.bytes_read += accum.size
            
        current_time = ttt.time()
        if current_time - self.previous_time > 3 :
            BPS = float(self.bytes_read) / (current_time - self.previous_time)
            print 'Throughput: %s/s; Progress: %.2f%%' % ( GetHumanReadableDataSize(BPS),  float(self.bytes_read_file) / self.current_file_size * 100 )
            self.bytes_read = 0
            self.previous_time = current_time
           

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
            
            st = os.stat(self.filelist[self.file_cnt])
            self.current_file_size = st.st_size
            self.bytes_read_file = 0