create_clock  -name { atck } -period 100.000 -waveform { 0.000 50.000  }  { atck  } 
create_clock  -name { comm_block_INST.tck } -period 1000.000 -waveform { 0.000 500.000  }  { \
comm_block_INST/jtagi/jtag_clkint_prim/U_CLKSRC:Y  } 

