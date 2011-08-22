quietly set ACTELLIBNAME smartfusion
quietly set PROJECT_DIR "D:/Work/marmote/projects/CIC"

if {[file exists presynth/_info]} {
   echo "INFO: Simulation library presynth already exists"
} else {
   vlib presynth
}
vmap presynth presynth
vmap smartfusion "C:/Actel/Libero_v9.1/Designer/lib/modelsim/precompiled/vhdl/smartfusion"
vmap MSSLIB "C:/Actel/Libero_v9.1/Designer/lib/modelsim/precompiled/mixed/smartfusion/MSSLIB"
vmap MSS_BFM_LIB "../component/Actel/SmartFusionMSS/MSS/2.5.106/mti/user_verilog/MSS_BFM_LIB"
vcom -work MSS_BFM_LIB -refresh
vlog -work MSS_BFM_LIB -refresh

vcom -93 -explicit -work presynth "${PROJECT_DIR}/hdl/common.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/hdl/CIC.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/stimulus/mytestbench_CIC.vhd"

vsim -L work -L MSSLIB -L smartfusion -L presynth -L MSS_BFM_LIB  -t 1ps presynth.CIC_tb
add wave /CIC_tb/*
run 10000ns
