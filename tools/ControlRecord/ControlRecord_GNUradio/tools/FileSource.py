import numpy as np
import os

import time as ttt
from HumanReadableDataSize import GetHumanReadableDataSize



################################################################################
class FileSource:

################################################################################
    def __init__(self, FileOrDir):
        
        if os.path.isdir(FileOrDir) :
            self.filelist_in = os.listdir(FileOrDir)
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


        self.accum = np.array([], dtype=np.uint8)
        self.accum_length = 0


################################################################################
    def __del__( self ) :

        self.CloseCurrentFile()


################################################################################
    def SourceEmpty( self ) :

        return self.f is None


################################################################################
    def GetBuffer(self, N = 1024):

        while not self.SourceEmpty() and self.accum_length < N :
            N_new = N - self.accum_length

            f = open('./temp2.bin', 'ab')
            f.write('N_new: %d\n'%N_new)
            f.close()

            temp = np.fromfile(self.f, dtype=np.uint8, count=N_new)

            f = open('./temp2.bin', 'ab')
            f.write('Read temp size: %d\n'%temp.size)
            f.close()

            if temp.size == 0 :
                self.IterateFileList()
                continue


            # Check to see if the buffer is large enough, if not increase size
            worst_case_size = self.accum_length + temp.size
            size_diff = worst_case_size - self.accum.size
            if size_diff > 0 :
                self.accum = np.append( self.accum, temp )
            else :
                self.accum[self.accum_length:self.accum_length+temp.size] = temp
            
            self.accum_length += temp.size
            
            self.bytes_read_file += temp.size
            self.bytes_read += temp.size
            
        current_time = ttt.time()
        if current_time - self.previous_time > 3 :
            BPS = float(self.bytes_read) / (current_time - self.previous_time)
            print 'Throughput: %s/s; Progress: %.2f%%' % ( GetHumanReadableDataSize(BPS),  float(self.bytes_read_file) / self.current_file_size * 100 )
            self.bytes_read = 0
            self.previous_time = current_time

        f = open('./temp2.bin', 'ab')
        f.write('accum_length: %d\n'%self.accum_length)
        f.close()
           
        return self.accum, self.accum_length


################################################################################
    def ClearFromBeginning(self, buff_len) :

        buff_len = min( buff_len, self.accum_length )

        self.accum[0:self.accum_length - buff_len] = self.accum[buff_len:self.accum_length]

        self.accum_length -= buff_len


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