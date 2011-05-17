quietly set ACTELLIBNAME smartfusion
quietly set PROJECT_DIR "D:/Work/marmote/projects/ADC_SPI_DMA_IPstack"
source "${PROJECT_DIR}/simulation/CompileDssBfm.tcl";source "${PROJECT_DIR}/simulation/bfmtovec_compile.tcl";

if {[file exists presynth/_info]} {
   echo "INFO: Simulation library presynth already exists"
} else {
   vlib presynth
}
vmap presynth presynth
vmap smartfusion "C:/Actel/Libero_v9.1/Designer/lib/modelsim/precompiled/vhdl/smartfusion"
vmap proasic3 "C:/Actel/Libero_v9.1/Designer/lib/modelsim/precompiled/vhdl/smartfusion"
vmap MSSLIB "C:/Actel/Libero_v9.1/Designer/lib/modelsim/precompiled/mixed/smartfusion/MSSLIB"
vmap MSS_BFM_LIB "../component/Actel/SmartFusionMSS/MSS/2.4.105/mti/user_verilog/MSS_BFM_LIB"
vcom -work MSS_BFM_LIB -refresh
vlog -work MSS_BFM_LIB -refresh
vmap COREAPB3_LIB "../component/Actel/DirectCore/CoreAPB3/3.0.103/mti/user_vhdl/COREAPB3_LIB"
vcom -work COREAPB3_LIB -refresh
vlog -work COREAPB3_LIB -refresh

vcom -93 -explicit -work presynth "${PROJECT_DIR}/component/work/uC/MSS_CCC_0/uC_tmp_MSS_CCC_0_MSS_CCC.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/component/work/uC/uC.vhd"
vcom -93 -explicit -work COREAPB3_LIB "${PROJECT_DIR}/component/Actel/DirectCore/CoreAPB3/3.0.103/rtl/vhdl/core_obfuscated/coreapb3_muxptob3.vhd"
vcom -93 -explicit -work COREAPB3_LIB "${PROJECT_DIR}/component/Actel/DirectCore/CoreAPB3/3.0.103/rtl/vhdl/core_obfuscated/coreapb3.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/hdl/common.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/hdl/APB_SPI.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/component/work/top/top.vhd"
vcom -93 -explicit -work COREAPB3_LIB "${PROJECT_DIR}/component/Actel/DirectCore/CoreAPB3/3.0.103/rtl/vhdl/core_obfuscated/components.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/stimulus/mytestbench.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/component/work/top/testbench.vhd"

vsim -L work -L MSSLIB -L smartfusion -L presynth -L MSS_BFM_LIB -L COREAPB3_LIB  -t 1ps presynth.SPI_APB_ADC_tb
add wave /SPI_APB_ADC_tb/*
run 1000ns
