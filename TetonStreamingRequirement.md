# Ethernet #

# USB #

## Packet format ##

| **_SOF_** | **SEQ** | **I<sub>0</sub>** | **Q<sub>0</sub>** | ... | **I<sub>N-1</sub>** | **Q<sub>N-1</sub>** |
|:----------|:--------|:------------------|:------------------|:----|:--------------------|:--------------------|

**_SOF_**: Start of frame delimiter (TBD: check if this is needed). Can be used to:

  * synchronize frames (helps to find SEQ)

**SEQ**: 16-bit unsigned sequence number of the _first sample_ in the packet. Can be used to:

  * synchronize frames
  * detect and count sample drops

_Note: Each sample will be associated with a sequence number in the FPGA internally, but the packet will include only that of the first._

**I<sub>x</sub>,Q<sub>x</sub>**: 16-bit unsigned (TBD: signed or unsigned) I and Q sample pairs

**N**: Packet payload length in samples.

  * N = 256 (TBD: value of N)