quietly set ACTELLIBNAME smartfusion
quietly set PROJECT_DIR "D:/Work/marmote/projects/CORDIC"
source "${PROJECT_DIR}/simulation/generate.tcl";

if {[file exists presynth/_info]} {
   echo "INFO: Simulation library presynth already exists"
} else {
   vlib presynth
}
vmap presynth presynth
vmap smartfusion "C:/Actel/Libero_v9.1/Designer/lib/modelsim/precompiled/vhdl/smartfusion"
vmap proasic3 "C:/Actel/Libero_v9.1/Designer/lib/modelsim/precompiled/vhdl/smartfusion"
vmap MSSLIB "C:/Actel/Libero_v9.1/Designer/lib/modelsim/precompiled/mixed/smartfusion/MSSLIB"
vmap MSS_BFM_LIB "../component/Actel/SmartFusionMSS/MSS/2.5.106/mti/user_verilog/MSS_BFM_LIB"
vcom -work MSS_BFM_LIB -refresh
vlog -work MSS_BFM_LIB -refresh
if {[file exists CORECORDIC_LIB/_info]} {
   echo "INFO: Simulation library CORECORDIC_LIB already exists"
} else {
   vlib CORECORDIC_LIB
}
vmap CORECORDIC_LIB "CORECORDIC_LIB"

vcom -93 -explicit -work presynth "${PROJECT_DIR}/hdl/common.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/hdl/SIGN_CORRECTOR.vhd"
vcom -93 -explicit -work CORECORDIC_LIB "${PROJECT_DIR}/component/Actel/DirectCore/CORECORDIC/3.0.196/rtl/vhdl/core/corecordic_package_word.vhd"
vcom -93 -explicit -work CORECORDIC_LIB "${PROJECT_DIR}/component/Actel/DirectCore/CORECORDIC/3.0.196/rtl/vhdl/core/corecordic_word.vhd"
vcom -93 -explicit -work CORECORDIC_LIB "${PROJECT_DIR}/component/Actel/DirectCore/CORECORDIC/3.0.196/rtl/vhdl/core/corecordic_addpackage_word.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/hdl/phase_gen.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/component/work/sincos_gen/sincos_gen.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/stimulus/mytestbench_sincos_gen.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/component/work/sincos_gen/testbench.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/stimulus/mytestbench_phase_gen.vhd"

vsim -L work -L MSSLIB -L smartfusion -L presynth -L MSS_BFM_LIB -L CORECORDIC_LIB  -t 1ps presynth.sincos_gen_tb
add wave /sincos_gen_tb/*
run 10000ns
