# Created by Actel Designer Software 10.0.20.2
# Fri Aug 10 10:28:13 2012

# (OPEN DESIGN)

open_design "StreamingReceiver.adb"

# set default back-annotation base-name
set_defvar "BA_NAME" "StreamingReceiver_ba"
set_defvar "IDE_DESIGNERVIEW_NAME" {Impl1}
set_defvar "IDE_DESIGNERVIEW_COUNT" "1"
set_defvar "IDE_DESIGNERVIEW_REV0" {Impl1}
set_defvar "IDE_DESIGNERVIEW_REVNUM0" "1"
set_defvar "IDE_DESIGNERVIEW_ROOTDIR" {D:\Work\marmote\firmware\MainBoard\StreamingReceiver\designer}
set_defvar "IDE_DESIGNERVIEW_LASTREV" "1"


# import of input files
import_source  \
-format "edif" -edif_flavor "GENERIC" -netlist_naming "VHDL" {../../synthesis/StreamingReceiver.edn} \
-format "pdc"  {..\..\component\work\StreamingReceiver\StreamingReceiver.pdc} -merge_physical "yes" -merge_timing "yes"
compile
report -type "status" {StreamingReceiver_compile_report.txt}

save_design
