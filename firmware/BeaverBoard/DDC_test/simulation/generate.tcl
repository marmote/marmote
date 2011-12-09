### script to run Generator for CoreCORDIC
### for simulation
# 11Dec09		Production Release Version 3.0
quietly set chmod_exe    "/bin/chmod"
quietly set chmod_win    "win"
quietly set chmod_lin    "lin"
quietly set linux_exe    "corecordic"
quietly set windows_exe  "corecordic.exe"

# check OS type and use appropriate executable
if {$tcl_platform(os) == "Linux"} {
	echo "--- Using Linux Data Generator"
	quietly set bfmtovec_exe $linux_exe
	quietly set chmod $chmod_lin
	
} else {
	echo "--- Using Windows Data Generator"
	quietly set bfmtovec_exe $windows_exe
	quietly set chmod $chmod_win

}
# compile BFM source file(s) into vector output file(s)
cd ../component/Actel/DirectCore/CORECORDIC
quietly set folders [glob  -type d *]
quietly set dir [split $folders " "]

foreach f $dir {
  if {[file isdirectory $f]} {
    cd $f/$chmod
	if {$tcl_platform(os) == "Linux"} {
	  if {![file executable $bfmtovec_exe]} {
		quietly set cmds "exec chmod +x $bfmtovec_exe"
		eval $cmds
	  }
	  quietly set cmd "exec ./$bfmtovec_exe"
	} else {
      quietly set cmd "exec $bfmtovec_exe"
	}
	
    echo "--- Running Generator ..."
    eval $cmd
	cd ../..
  }
}
cd ../../../../simulation

echo "--- Done."
