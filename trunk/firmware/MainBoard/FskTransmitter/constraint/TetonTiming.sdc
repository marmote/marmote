################################################################################
#  SDC WRITER VERSION "3.1";
#  DESIGN "Teton";
#  Timing constraints scenario: "Primary";
#  DATE "Wed May 30 15:44:35 2012";
#  VENDOR "Actel";
#  PROGRAM "Actel Designer Software Release v10.0 SP1";
#  VERSION "10.0.10.4"  Copyright (C) 1989-2012 Actel Corp. 
################################################################################


set sdc_version 1.7


########  Clock Constraints  ########

create_clock  -name { Teton_MSS_0/MSS_CCC_0/I_XTLOSC:CLKOUT } -period 50.000 -waveform { 0.000 25.000  }  { Teton_MSS_0/MSS_CCC_0/I_XTLOSC:CLKOUT  } 



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

create_generated_clock  -name { mss_fclk } -divide_by 1  -source { Teton_MSS_0/MSS_CCC_0/I_XTLOSC:CLKOUT } { \
Teton_MSS_0/MSS_ADLIB_INST/U_CORE:FCLK  } 



########  Clock Source Latency Constraints #########



########  Input Delay Constraints  ########



########  Output Delay Constraints  ########



########   Delay Constraints  ########



########   Delay Constraints  ########



########   Multicycle Constraints  ########



########   False Path Constraints  ########



########   Output load Constraints  ########



########  Disable Timing Constraints #########



########  Clock Uncertainty Constraints #########

set_clock_uncertainty 0.4 -from { Teton_MSS_0/MSS_CCC_0/I_XTLOSC:CLKOUT } -to { mss_ccc_gla1 }
#  read only

set_clock_uncertainty 0.4 -from { Teton_MSS_0/MSS_CCC_0/I_XTLOSC:CLKOUT } -to { mss_ccc_gla0 }
#  read only

set_clock_uncertainty 0.4 -from { mss_ccc_gla1 } -to { Teton_MSS_0/MSS_CCC_0/I_XTLOSC:CLKOUT }
#  read only

set_clock_uncertainty 0.4 -from { mss_ccc_gla0 } -to { Teton_MSS_0/MSS_CCC_0/I_XTLOSC:CLKOUT }
#  read only



