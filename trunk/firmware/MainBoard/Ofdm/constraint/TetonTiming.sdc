################################################################################
#  SDC WRITER VERSION "3.1";
#  DESIGN "Teton";
#  Timing constraints scenario: "Primary";
#  DATE "Mon Jul 16 18:17:13 2012";
#  VENDOR "Actel";
#  PROGRAM "Actel Designer Software Release v10.0 SP2";
#  VERSION "10.0.20.2"  Copyright (C) 1989-2012 Actel Corp. 
################################################################################


set sdc_version 1.7


########  Clock Constraints  ########

#create_clock  -name { USB_CLK } -period 16.667 -waveform { 0.000 8.333  }  { USB_CLK  } 
#create_clock  -name { XTLOSC } -period 50.000 -waveform { 0.000 25.000  }  { Teton_MSS_0/MSS_CCC_0/I_XTLOSC:CLKOUT  } 
#create_clock  -name { REF_CLK } -period 50.000 -waveform { 0.000 25.000  }  { Teton_MSS_0/MSS_CCC_0/I_MSSCCC/U_MSSCCC:CLKA } 

create_clock  -name { FAB_CLK } -period 50.000 -waveform { 0.000 25.000  }  { n:Teton_MSS_0_FAB_CLK } 




########  Generated Clock Constraints  ########



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



