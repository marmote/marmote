################################################################################
#  SDC WRITER VERSION "3.1";
#  DESIGN "Teton";
#  Timing constraints scenario: "Primary";
#  DATE "Thu May 17 14:26:33 2012";
#  VENDOR "Actel";
#  PROGRAM "Actel Designer Software Release v10.0 SP1";
#  VERSION "10.0.10.4"  Copyright (C) 1989-2012 Actel Corp. 
################################################################################


set sdc_version 1.7


########  Clock Constraints  ########

create_clock  -name { AFE1_CLK } -period 50.000 -waveform { 0.000 25.000  }  { AFE1_CLK  } 



########  Generated Clock Constraints  ########



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

set_output_delay 0.000 -clock { AFE1_CLK }  [get_ports { AFE1_DB AFE1_DB[0] AFE1_DB[1] AFE1_DB[2] AFE1_DB[3] AFE1_DB[4] AFE1_DB[5] AFE1_DB[6] AFE1_DB[7] AFE1_DB[8] AFE1_DB[9] }] 
set_max_delay 38.000 -from [get_clocks {AFE1_CLK}]  -to [get_ports { AFE1_DB AFE1_DB[0] AFE1_DB[1] \
AFE1_DB[2] AFE1_DB[3] AFE1_DB[4] AFE1_DB[5] AFE1_DB[6] AFE1_DB[7] AFE1_DB[8] AFE1_DB[9] \
}] 
set_min_delay -0.000 -from [get_clocks {AFE1_CLK}]  -to [get_ports { AFE1_DB AFE1_DB[0] AFE1_DB[1] \
AFE1_DB[2] AFE1_DB[3] AFE1_DB[4] AFE1_DB[5] AFE1_DB[6] AFE1_DB[7] AFE1_DB[8] AFE1_DB[9] \
}] 



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



