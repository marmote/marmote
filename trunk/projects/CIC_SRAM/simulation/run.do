quietly set ACTELLIBNAME smartfusion
quietly set PROJECT_DIR "C:/Users/babjak/Desktop/CIC_SRAM"

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

vcom -93 -explicit -work presynth "${PROJECT_DIR}/smartgen/CIC_regs/CIC_regs.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/hdl/common.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/hdl/CIC_control.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/component/work/CIC/CIC.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/stimulus/CIC_tb.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/component/work/CIC/testbench.vhd"

vsim -L work -L MSSLIB -L smartfusion -L presynth -L MSS_BFM_LIB  -t 1ps presynth.CIC_tb
add wave /CIC_tb/*
run 20000ns
