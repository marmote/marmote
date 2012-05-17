################################################################################
#  SDC WRITER VERSION "3.1";
#  DESIGN "Teton";
#  Timing constraints scenario: "Primary";
#  DATE "Thu May 17 16:28:11 2012";
#  VENDOR "Actel";
#  PROGRAM "Actel Designer Software Release v10.0 SP1";
#  VERSION "10.0.10.4"  Copyright (C) 1989-2012 Actel Corp. 
################################################################################


set sdc_version 1.7


########  Clock Constraints  ########

create_clock  -name { AFE_CLK } -period 50.000 -waveform { 0.000 25.000  }  { \
Teton_MSS_0/MSS_CCC_0/I_MSSCCC/U_TILE1:PIN5  } 



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

set_output_delay  -max 10.000 -clock { AFE_CLK }  [get_ports { AFE1_DB[0] AFE1_DB[1] AFE1_DB[2] AFE1_DB[3] AFE1_DB[4] AFE1_DB[5] AFE1_DB[6] AFE1_DB[7] AFE1_DB[8] AFE1_DB[9] }] 
set_output_delay  -min 5.000 -clock { AFE_CLK }  [get_ports { AFE1_DB[0] AFE1_DB[1] AFE1_DB[2] AFE1_DB[3] AFE1_DB[4] AFE1_DB[5] AFE1_DB[6] AFE1_DB[7] AFE1_DB[8] AFE1_DB[9] }] 

set_output_delay  -clock_fall  -max 10.000 -clock { AFE_CLK }  [get_ports { AFE1_DB[0] AFE1_DB[1] AFE1_DB[2] AFE1_DB[3] AFE1_DB[4] AFE1_DB[5] AFE1_DB[6] AFE1_DB[7] AFE1_DB[8] AFE1_DB[9] }] 
set_output_delay  -clock_fall  -min 5.000 -clock { AFE_CLK }  [get_ports { AFE1_DB[0] AFE1_DB[1] AFE1_DB[2] AFE1_DB[3] AFE1_DB[4] AFE1_DB[5] AFE1_DB[6] AFE1_DB[7] AFE1_DB[8] AFE1_DB[9] }] 



########   Delay Constraints  ########



########   Delay Constraints  ########



########   Multicycle Constraints  ########



########   False Path Constraints  ########



########   Output load Constraints  ########

set_load 35 { LED1 } 

set_load 35 { AFE2_TR_n } 

set_load 35 { AFE1_CLK } 

set_load 35 { AFE2_CLK } 

set_load 35 { LED2 } 

set_load 35 { AFE2_SHDN_n } 

set_load 35 { AFE1_TR_n } 

set_load 35 { AFE1_SHDN_n } 



########  Disable Timing Constraints #########



########  Clock Uncertainty Constraints #########



