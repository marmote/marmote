# Rev C #

  1. 2 former DGND pins became I/O pins (P15 and P16)
  1. Fixed the silkscreen placement for D1V5 and D3V3
  1. Added name and caption for SW2 and 5V input on the silkscreen

# Rev B #

  1. The !CHRG pin of the LTC4085 is connected to a microcontroller GPIO (PB9) instead of an external LED (LED0)
  1. LED0 has been removed
  1. The !PWRGD pin of the LTC4361 is NOT connected to a microcontroller GPIO (PB9) anymore
  1. Power rail measurements have changed
    * Current on VSUP (individually) and on D3V3\_STM is not measured anymore
    * Current and voltage on VSUP\_R (source of all rails) is measured instead
    * The current sense - ADC connections have been completely reorganized
  1. The LTC2942-1 battery gauge !AL/CC pin is connected to GPIO PB4 instead of PB5
  1. The 64-pin mezzanine connector has been replaced with a 84-pin one
  1. The mezzanine connector pinous has been reorganized
    * The PB5 GPIO line on the connector has been replaced with PB4 (with SMBus alter functionality)
  1. JTAG DNP resistors have been removed, only SWD is available
  1. Added pull-up resistor to the USBDP line (still not the best solution)
  1. Reset jumper has been replaced with a push button
  1. BOOT0 selector jumper has been replaced with a slide switch