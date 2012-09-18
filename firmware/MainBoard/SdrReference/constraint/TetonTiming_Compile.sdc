################################################################################
#  SDC WRITER VERSION "3.1";
#  DESIGN "Teton";
#  Timing constraints scenario: "Primary";
#  DATE "Tue Sep 11 16:11:37 2012";
#  VENDOR "Actel";
#  PROGRAM "Actel Designer Software Release v10.1";
#  VERSION "10.1.0.14"  Copyright (C) 1989-2012 Actel Corp. 
################################################################################


set sdc_version 1.7


########  Clock Constraints  ########

create_clock  -name { USB_CLK } -period 16.667 -waveform { 0.000 8.333  }  { USB_CLK  } 

create_clock  -name { atck } -period 100.000 -waveform { 0.000 50.000  }  { atck  } 

create_clock  -name { comm_block_INST.tck } -period 1000.000 -waveform { 0.000 500.000  }  { \
comm_block_INST/jtagi/jtag_clkint_prim/U_CLKSRC:Y  } 

create_clock  -name { XTLOSC } -period 50.000 -waveform { 0.000 25.000  }  { Teton_MSS_0/MSS_CCC_0/I_XTLOSC:CLKOUT  } 



########  Generated Clock Constraints  ########

create_generated_clock  -name { mss_ccc_gla1 } -divide_by 8  -multiply_by 8  -source { Teton_MSS_0/MSS_CCC_0/I_MSSCCC/U_MSSCCC:CLKA } { \
Teton_MSS_0/MSS_CCC_0/I_MSSCCC/U_MSSCCC:GLA  } 
#  read only
#
# *** Note *** SmartTime supports extensions to the create_generated_clock constraint supported by SDC,
#              Extensions to this constraint may not be accepted by tools other than Actel's

create_generated_clock  -name { mss_ccc_gla0 } -divide_by 8  -multiply_by 8  -source { Teton_MSS_0/MSS_CCC_0/I_MSSCCC/U_MSSCCC:CLKA } { \
Teton_MSS_0/MSS_CCC_0/I_MSSCCC/U_MSSCCC:GLAMSS  } 
#  read only
#
# *** Note *** SmartTime supports extensions to the create_generated_clock constraint supported by SDC,
#              Extensions to this constraint may not be accepted by tools other than Actel's

create_generated_clock  -name { mss_fabric_interface_clock } -divide_by 1  -source { Teton_MSS_0/MSS_ADLIB_INST/U_CORE:FCLK } { \
Teton_MSS_0/MSS_ADLIB_INST/U_CORE:GLB  } 
#  read only

create_generated_clock  -name { mss_aclk } -divide_by 1  -source { Teton_MSS_0/MSS_ADLIB_INST/U_CORE:FCLK } { \
Teton_MSS_0/MSS_ADLIB_INST/U_CORE:ACLK  } 
#  read only

create_generated_clock  -name { mss_pclk1 } -divide_by 1  -source { Teton_MSS_0/MSS_ADLIB_INST/U_CORE:FCLK } { \
Teton_MSS_0/MSS_ADLIB_INST/U_CORE:PCLK1  } 
#  read only



########  Clock Source Latency Constraints #########



########  Input Delay Constraints  ########



########  Output Delay Constraints  ########



########   Delay Constraints  ########



########   Delay Constraints  ########



########   Multicycle Constraints  ########



########   False Path Constraints  ########



########   Output load Constraints  ########

set_load 35 { AFE1_SHDN_n } 

set_load 35 { AFE1_CLK } 

set_load 35 { AFE2_SHDN_n } 

set_load 35 { AFE1_TR_n } 

set_load 35 { LED1 } 

set_load 35 { AFE2_CLK } 

set_load 35 { LED2 } 

set_load 35 { AFE2_TR_n } 



########  Disable Timing Constraints #########



########  Clock Uncertainty Constraints #########

set_clock_uncertainty 0.4 -from { XTLOSC } -to { mss_ccc_gla0 }
#  read only

set_clock_uncertainty 0.4 -from { mss_ccc_gla0 } -to { XTLOSC }
#  read only



