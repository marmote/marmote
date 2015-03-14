## Priorities ##

Throughout the design of the SmartFusion FPGA-based Main Board the priorities were the following:

  1. External Analog Front-End (highest)
  1. USB streaming interface
  1. SmartFusion Analog Front-End and Ethernet

## Known possible issues ##

  * The external AFE and USB digital data buses should have series resistors to minimize the digital transient currents. Due to board space limitations, these resistors were omitted.

  * The external AFE and USB were given priority over the SmartFusion AFE, thus the signals of the latter one might be noisy due to routing limitations.

  * The impedance control and the _proper termination is missing on the differential clock input signals_