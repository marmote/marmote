quietly set ACTELLIBNAME smartfusion
quietly set PROJECT_DIR "D:/Work/marmote/projects/DecimationFilters/CIC/CIC_COMB_BlockRAM.a"

if {[file exists presynth/_info]} {
   echo "INFO: Simulation library presynth already exists"
} else {
   vlib presynth
}
vmap presynth presynth
vmap smartfusion "C:/Actel/Libero_v9.1/Designer/lib/modelsim/precompiled/vhdl/smartfusion"
vmap MSSLIB "C:/Actel/Libero_v9.1/Designer/lib/modelsim/precompiled/mixed/smartfusion/MSSLIB"

vcom -93 -explicit -work presynth "${PROJECT_DIR}/smartgen/CIC_COMB_mem/CIC_COMB_mem.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/hdl/common.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/hdl/CIC_COMB_control.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/component/work/CIC_COMB/CIC_COMB.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/component/work/CIC_COMB/testbench.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/stimulus/CIC_COMB_testbench.vhd"

vsim -L work -L MSSLIB -L smartfusion -L presynth  -t 1ps presynth.CIC_COMB_tb
add wave /CIC_COMB_tb/*
run 20000ns
