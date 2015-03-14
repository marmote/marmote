# Rev B Changes #

  * Removed C117 and fixed C116 (rated 250V)
  * Replaced J2 (RJ-45) connector with J0011D21BNL
  * Reassigned and rerouted North Bridge GPIOs to parallel gain control (every GPIO is driven by FPGA I/O now)

  * Corrected issues in BOM file
  * Corrected VBAT symbol issue in library and removed [R53](https://code.google.com/p/marmote/source/detail?r=53) on PWRSAV line altogether
  * Ethernet PHY R<sub>bias</sub> part number has been corrected in BOM file
  * Fixed C5 and [R7](https://code.google.com/p/marmote/source/detail?r=7) label on the bottom layer (assembly drawing)