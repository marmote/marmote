quietly set ACTELLIBNAME smartfusion
quietly set PROJECT_DIR "D:/Work/marmote/projects/DDC_test"

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
vmap COREAPB3_LIB "../component/Actel/DirectCore/CoreAPB3/3.0.103/mti/user_vhdl/COREAPB3_LIB"
vcom -work COREAPB3_LIB -refresh
vlog -work COREAPB3_LIB -refresh

vcom -93 -explicit -work presynth "${PROJECT_DIR}/hdl/common.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/hdl/ADDERSUBTRACTOR.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/hdl/multiplier.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/component/work/complex_mult/complex_mult.vhd"
vcom -93 -explicit -work COREAPB3_LIB "${PROJECT_DIR}/component/Actel/DirectCore/CoreAPB3/3.0.103/rtl/vhdl/core_obfuscated/components.vhd"
vcom -93 -explicit -work CORECORDIC_LIB "${PROJECT_DIR}/component/Actel/DirectCore/CORECORDIC/3.0.196/rtl/vhdl/core/corecordic_package_word.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/stimulus/complex_mult_testbench.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/component/work/complex_mult/testbench.vhd"

vsim -L work -L MSSLIB -L smartfusion -L presynth -L MSS_BFM_LIB -L CORECORDIC_LIB -L COREAPB3_LIB  -t 1ps presynth.complex_mult_tb
add wave /complex_mult_tb/*
run 10000ns
