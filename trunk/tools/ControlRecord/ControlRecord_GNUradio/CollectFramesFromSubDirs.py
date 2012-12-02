from optparse import OptionParser

import sys
import os
import shutil



parser = OptionParser()
parser.add_option("-i", "--input", dest="inputdir",
                  help="Input directory containing directories with binary files <FILEORDIRNAME> (default %default)", metavar="DIRNAME", default=".")


################################################################################
if __name__ == "__main__":
    (options, args) = parser.parse_args()


    dir = options.inputdir

    if not os.path.isdir(dir) :
        print "Input not directory!"
        sys.exit(1)

    filelist = os.listdir(dir)
    dirlist = []
    pathlist = []

    for ii in xrange(len(filelist)) :
        new_path = dir + '/' + filelist[ii]
        if os.path.isdir(new_path) :
            dirlist.append(filelist[ii])
            pathlist.append(new_path)
            
             
    if not os.path.exists('./results'):
        os.makedirs('./results')

    for ii in xrange(len(pathlist)) :
        ret = os.system( 'python ./CollectFrames.py -i "%s"' % pathlist[ii] )

        if ret :
            continue

#        new_name = dirlist[ii] + '.bin'
#        if os.path.isfile('./results/' + new_name) :
#            os.remove('./results/' + new_name)
#        if os.path.isfile(new_name) :
#            os.remove(new_name)
#
#        os.rename('collect.bin', new_name)
#
#        try:
#            shutil.move(new_name, './results')
#
#        except:
#            pass
#
#        finally:
#            pass


        new_dir = './results/' + dirlist[ii]
        os.makedirs(new_dir)


        collect_filelist = os.listdir('.')

        for collect_file in collect_filelist :
            if os.path.isfile('./' + collect_file) :
                if collect_file[0:7] == 'collect' and collect_file[-4:] == '.bin' :

                    try:
                        shutil.move('./' + collect_file, new_dir)

                    except:
                        pass

                    finally:
                        pass