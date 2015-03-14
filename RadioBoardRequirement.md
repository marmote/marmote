# Rev B #

_Note: Only changes compared to Rev A and non-implemented functions are listed here._

  * **LDO for VCCVCO and other A3V3 powered lines**
  * **Footprint for both the TCXO and an external XTAL**
    * Single ended connection from the TCXO output to the SmartFusion (REF\_CLK+)
  * **Clock synchronization between boards (optional) or 1PPS input and output**
    * 1 PPM input with SMA connector
    * Connection to the SmartFusion (through REF\_CLK-)
  * **FPGA I/O connection to the following pins (B1, B2, B3, B4, B5, TXRX, LD, SHDN)**
    * Parallel I/O lines for gain cotnrol (VGA section at least)

  * ~~Consider using a low-phase-noise (RF) TCXO~~
  * ~~VCTCXO (controlled from AFE DAC) instead of simple TCXO~~
  * Via fence around the IC
  * **Via openings for test points (e.g. CLKOUT)**

  * Power-down mode for 20 MHz oscillator
  * Add a zero ohm resistor to optionally shut down the baseband section
  * ~~Second antenna in the same band for MIMO applications~~

  * Analog baseband filter
    * Should be removable
    * TBD cut-off frequency
    * Candidate ICs ([LTC6602](http://www.linear.com/product/LTC6602))
  * The whole board should be powered down by default (including the TCXO)


# Rev A #

# Functional #

  * May support UWB time-sync/localization
  * Should have a PLL to lock-on a carrier signal
  * Should have a fine tunable LO (say in < 50 Hz steps)
  * Should operate in the 433 MHz and/or 2.4 GHz band

# Clocking #

  * LO clocks should be derived from a temperature compensated voltage controlled crystal oscillator (TCVCXO) driven source
  * Should have an on-board TCXO (for cases the bottom board is unable to provide it)
  * Must be able to use a clock sourced from the MainBoard through the mezzanine connector
  * Should be able to switch between the above two (either by a jumper or a digital switch)

## Candidate clock buffer ICs ##

| IDT | [ICS83026I](http://www.idt.com/products/clocks-timing/clock-distribution/fanout-buffers-non-pll/83026i-01-12-differential-lvcmoslvttl-fanout-buffer) |
|:----|:-----------------------------------------------------------------------------------------------------------------------------------------------------|

# Analog front-end #

  * Consider adding a second RF front-end IC and antenna if ADCs and DACs are already present (at least at footprint-level)
  * Consider connecting the RSSI signal to both the SF ADC and a high-precision ADC

# Test points #

  * Analog baseband waveform feed in (signal generator) and signal out (oscilloscope) test point (e.g. right after the DAC/ADC)
    * Consider adding this functionality to the Inspection Board (may also affect Main Board ADC/DAC analog interface)
  * Analog baseband signal loop-back option
  * Analog RF signal loopback option (might be trivial)

# Misc #

  * May have a microphone and a speaker (footprint)

# Candidate RF parts #

| **Vendor** | **Model** | **RX mixer** | **LPF** | **TX mixer** | **PLL** | Power Consumption | Frequency |
|:-----------|:----------|:-------------|:--------|:-------------|:--------|:------------------|:----------|
| Analog Devices | [ADF9010](http://www.analog.com/static/imported-files/data_sheets/ADF9010.pdf) | no | yes | yes | yes | ? | ? |
| Maxim | [MAX2830](http://datasheets.maxim-ic.com/en/ds/MAX2830.pdf) |  |  |  |  | 80 mA | 2.4 GHz |

| **Vendor** | **Model** | **Channels** | **LPF cutoff (min)** | **Supply voltage** | **Current consumption** |
|:-----------|:----------|:-------------|:---------------------|:-------------------|:------------------------|
| Skyworks | [SKY73201-364LF](http://www.skyworksinc.com/uploads/documents/200755C.pdf) | 1 | 1 MHz | **3.3V** | **32 mA**  |
| Skyworks | [SKY73202-364LF](http://www.skyworksinc.com/uploads/documents/200755C.pdf) | 2 | 1 MHz | **3.3V** | **60 mA**  |


http://datasheets.maxim-ic.com/en/ds/MAX2830.pdf (MAX2831 with PA)

http://datasheets.maxim-ic.com/en/ds/MAX2510.pdf