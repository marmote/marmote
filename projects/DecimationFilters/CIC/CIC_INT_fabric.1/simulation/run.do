quietly set ACTELLIBNAME smartfusion
quietly set PROJECT_DIR "D:/Work/marmote/projects/DecimationFilters/CIC/CIC_INT_fabric.1"

if {[file exists presynth/_info]} {
   echo "INFO: Simulation library presynth already exists"
} else {
   vlib presynth
}
vmap presynth presynth
vmap smartfusion "C:/Actel/Libero_v9.1/Designer/lib/modelsim/precompiled/vhdl/smartfusion"
vmap MSSLIB "C:/Actel/Libero_v9.1/Designer/lib/modelsim/precompiled/mixed/smartfusion/MSSLIB"

vcom -93 -explicit -work presynth "${PROJECT_DIR}/hdl/common.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/hdl/CIC_INT.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/stimulus/CIC_INT_testbench.vhd"

vsim -L work -L MSSLIB -L smartfusion -L presynth  -t 1ps presynth.CIC_INT_tb
add wave /CIC_INT_tb/*
run 10000ns
