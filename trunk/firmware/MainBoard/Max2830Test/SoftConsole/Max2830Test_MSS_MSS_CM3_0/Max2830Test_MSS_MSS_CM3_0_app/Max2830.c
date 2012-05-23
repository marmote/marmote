//#include "io_ports.h"
#include "Max2830.h"

#include <stdint.h>
#include "flags.h"
#include "iostuff.h"

/*
Recommended Register Settings

|------| |------|------||------|------|------|------||------|------|------|------||------|------|------|------||------------|
| REG  | | D13  | D12  || D11  | D10  |  D9  |  D8  ||  D7  |  D6  |  D5  |  D4  ||  D3  |  D2  |  D1  |  D0  ||   A3:A0    |
|------| |------|------||------|------|------|------||------|------|------|------||------|------|------|------||------------|
|   0  | |   0  |   1  ||   0  |   1  |   1  |   1  ||   0  |   1  |   0  |   0  ||   0  |   0  |   0  |   0  ||    0000    |
|------| |------|------||------|------|------|------||------|------|------|------||------|------|------|------||------------|
|   1  | |   0  |   1  ||   0  |   0  |   0  |   1  ||   1  |   0  |   0  |   1  ||   1  |   0  |   1  |   0  ||    0001    |
|------| |------|------||------|------|------|------||------|------|------|------||------|------|------|------||------------|
|   2  | |   0  |   1  ||   0  |   0  |   0  |   0  ||   0  |   0  |   0  |   0  ||   0  |   0  |   1  |   1  ||    0010    |
|------| |------|------||------|------|------|------||------|------|------|------||------|------|------|------||------------|
|   3  | |   0  |   0  ||   0  |   0  |   0  |   0  ||   0  |   1  |   1  |   1  ||   1  |   0  |   0  |   1  ||    0011    |
|------| |------|------||------|------|------|------||------|------|------|------||------|------|------|------||------------|
|   4  | |   1  |   1  ||   0  |   1  |   1  |   0  ||   0  |   1  |   1  |   0  ||   0  |   1  |   1  |   0  ||    0100    |
|------| |------|------||------|------|------|------||------|------|------|------||------|------|------|------||------------|
|   5  | |   0  |   0  ||   0  |   0  |   0  |   0  ||   1  |   0  |   1  |   0  ||   0  |   1  |   0  |   0  ||    0101    |
|------| |------|------||------|------|------|------||------|------|------|------||------|------|------|------||------------|
|   6  | |   0  |   0  ||   0  |   0  |   0  |   0  ||   0  |   1  |   1  |   0  ||   0  |   0  |   0  |   0  ||    0110    |
|------| |------|------||------|------|------|------||------|------|------|------||------|------|------|------||------------|
|   7  | |   0  |   1  ||   0  |   0  |   0  |   0  ||   0  |   0  |   1  |   0  ||   0  |   0  |   1  |   0  ||    0111    |
|------| |------|------||------|------|------|------||------|------|------|------||------|------|------|------||------------|
|   8  | |   1  |   0  ||   0  |   0  |   0  |   0  ||   0  |   0  |   1  |   0  ||   0  |   0  |   0  |   1  ||    1000    |
|------| |------|------||------|------|------|------||------|------|------|------||------|------|------|------||------------|
|   9  | |   0  |   0  ||   0  |   0  |   1  |   1  ||   1  |   0  |   1  |   1  ||   0  |   1  |   0  |   1  ||    1001    |
|------| |------|------||------|------|------|------||------|------|------|------||------|------|------|------||------------|
|  10  | |   0  |   1  ||   1  |   1  |   0  |   1  ||   1  |   0  |   1  |   0  ||   0  |   1  |   0  |   0  ||    1010    |
|------| |------|------||------|------|------|------||------|------|------|------||------|------|------|------||------------|
|  11  | |   0  |   0  ||   0  |   0  |   0  |   0  ||   0  |   1  |   1  |   1  ||   1  |   1  |   1  |   1  ||    1011    |
|------| |------|------||------|------|------|------||------|------|------|------||------|------|------|------||------------|
|  12  | |   0  |   0  ||   0  |   0  |   0  |   1  ||   0  |   1  |   0  |   0  ||   0  |   0  |   0  |   0  ||    1100    |
|------| |------|------||------|------|------|------||------|------|------|------||------|------|------|------||------------|
|  13  | |   0  |   0  ||   1  |   1  |   1  |   0  ||   1  |   0  |   0  |   1  ||   0  |   0  |   1  |   0  ||    1101    |
|------| |------|------||------|------|------|------||------|------|------|------||------|------|------|------||------------|
|  14  | |   0  |   0  ||   0  |   0  |   1  |   1  ||   0  |   0  |   1  |   1  ||   1  |   0  |   1  |   1  ||    1110    |
|------| |------|------||------|------|------|------||------|------|------|------||------|------|------|------||------------|
|  15  | |   0  |   0  ||   0  |   0  |   0  |   1  ||   0  |   1  |   0  |   0  ||   0  |   1  |   0  |   1  ||    1111    |
|------| |------|------||------|------|------|------||------|------|------|------||------|------|------|------||------------|
*/

//According to the recommended values in the table above
#define MAX2830_REG0	0x00001740
#define MAX2830_REG1	0x0000119A
#define MAX2830_REG2	0x00001003
#define MAX2830_REG3	0x00000079
#define MAX2830_REG4	0x00003666
#define MAX2830_REG5	0x000000A4
#define MAX2830_REG6	0x00000060
#define MAX2830_REG7	0x00001022
#define MAX2830_REG8	0x00002021
#define MAX2830_REG9	0x000003B5
#define MAX2830_REG10	0x00001DA4
#define MAX2830_REG11	0x0000007F
#define MAX2830_REG12	0x00000140
#define MAX2830_REG13	0x00000E92
#define MAX2830_REG14	0x0000033B
#define MAX2830_REG15	0x00000145


//Flags
//reg 0
#define MAX2830_FRACTIONAL_N_PLL_MODE_ENABLE_FLAG					0x0400
//reg 1
#define MAX2830_LOCK_DETECTOR_OUTPUT_SELECTOR						0x1000
//reg 5
#define MAX2830_LOCK_DETECT_OUTPUT_INTERNAL_PULLUP_ENABLE_FLAG		0x0200
#define MAX2830_LOCK_DETECT_OUTPUT_ENABLE_FLAG						0x0020
#define MAX2830_REFERENCE_DIV_RATIO									0x0004
//reg 6
#define MAX2830_POWER_DETECTOR_ENABLE_FLAG							0x0040
#define MAX2830_RX_CALIBRATION_MODE_ENABLE_FLAG						0x0001
#define MAX2830_TX_CALIBRATION_MODE_ENABLE_FLAG						0x0002
//reg 8
#define MAX2830_RX_GAIN_PROG_THROUGH_SPI_ENABLE_FLAG				0x1000
#define MAX2830_INDEPENDENT_RSSI_OUTPUT_ENABLE_FLAG					0x0400
//reg 9
#define MAX2830_TX_GAIN_PROG_THROUGH_SPI_ENABLE_FLAG				0x0400


//Registers (Some of the registers are defined as local variables in functions)
flags_t		reg5 = MAX2830_REG5;
flags_t		reg6 = MAX2830_REG6;
flags_t		reg7 = MAX2830_REG7;
flags_t		reg8 = MAX2830_REG8;



///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
//
//	Low level register handling functions
//
///////////////////////////////////////////////////////////////////////
//
//	Stuff for register 0
//

void Set_Fractional_N_PLL_Mode_Enable(char EnableFlag)
{
//	Fractional-N PLL Mode Enable.
//	Set 1 to enable the fractional-N PLL or set 0 to enable the integer-N PLL.

	flags_t		reg0 = MAX2830_REG0;

	SetFlagVal(&reg0, (flags_t) MAX2830_FRACTIONAL_N_PLL_MODE_ENABLE_FLAG, EnableFlag);

	send_SPI(reg0 << 4 | 0x0);
}


///////////////////////////////////////////////////////////////////////
//
//	Stuff for register 1
//

void Set_Lock_Detector_Output_Select(char OutputType)
{
//	Lock-Detector Output Select.
//	Set to 1 for CMOS Output. Set to 0 for open-drain output.
//	Bit D9 	in register (A3:A0 = 0101) enables or disables an internal 30kOhm pullup resistor in open-drain output mode.

	flags_t		reg1 = MAX2830_REG1;

	SetFlagVal(&reg1, (flags_t) MAX2830_LOCK_DETECTOR_OUTPUT_SELECTOR, OutputType);

	send_SPI(reg1 << 4 | 0x1);
}


///////////////////////////////////////////////////////////////////////
//
//	Stuff for register 3 and 4
//

void Set_Main_Divider(uint8_t IntegerPortion, uint32_t FractionalPortion)
{
//	8-Bit Integer Portion of Main Divider. Programmable from 64 to 255.

//	6 LSBs of 20-Bit Fractional Portion of Main Divider
//	14 MSBs of 20-Bit Fractional Portion of Main Divider

	flags_t		reg3 = MAX2830_REG3;

	if (IntegerPortion < 64)
		IntegerPortion = 64;

	FractionalPortion = FractionalPortion & 0xFFFFF;

//////////////////////
	reg3 = reg3 | IntegerPortion;
	reg3 = reg3 | ((FractionalPortion & 0x3F)) << 8;

	send_SPI(reg3 << 4 | 0x3);

//////////////////////
	flags_t		reg4 = MAX2830_REG4;

	reg4 = reg4 | (FractionalPortion >> 6);

	send_SPI(reg4 << 4 | 0x4);
}


///////////////////////////////////////////////////////////////////////
//
//	Stuff for register 5
//

void Set_Lock_Detect_Output_Internal_Pullup_Resistor_Enable(char EnableFlag)
{
//	Lock-Detect Output Internal Pullup Resistor Enable.
//	Set to 1 to enable internal 30kOhm pullup resistor or set to 0 to disable the resistor.
//	Only available when lock-detect, open-drain output is selected (A3:A0 = 0001, D12 = 1).

	SetFlagVal(&reg5, (flags_t) MAX2830_LOCK_DETECT_OUTPUT_INTERNAL_PULLUP_ENABLE_FLAG, EnableFlag);

	send_SPI(reg5 << 4 | 0x5);
}

void Set_Lock_Detect_Output_Enable(char EnableFlag)
{
//	Lock-Detect Output Enable.
//	Set to 1 to enable the lock-detect output or set to 0 to disable the output.
//	The output is high impedance when disabled.

	SetFlagVal(&reg5, (flags_t) MAX2830_LOCK_DETECT_OUTPUT_ENABLE_FLAG, EnableFlag);

	send_SPI(reg5 << 4 | 0x5);
}

void Set_Reference_Frequency_Divider_Ratio(char DividerRatio)
{
//	Reference Frequency Divider Ratio to PLL.
//	Set to 0 to divide by 1. Set to 1 to divide by 2.

	SetFlagVal(&reg5, (flags_t) MAX2830_REFERENCE_DIV_RATIO, DividerRatio);

	send_SPI(reg5 << 4 | 0x5);
}


///////////////////////////////////////////////////////////////////////
//
//	Stuff for register 6
//

void Set_TX_IQ_Calibration_LO_Leakage_and_Sideband_Detector_Gain(uint8_t value)
{
//	Tx I/Q Calibration LO Leakage and Sideband Detector Gain-Control Bits.
//	D12:D11 =
//		00: 9dB;
//		01 19dB;
//		10: 29dB;
//		11: 39dB.

	value = value & 0x3;

	reg6 = reg6 | (((uint32_t) value) << 11);

	send_SPI(reg6 << 4 | 0x6);
}

void Set_Power_Detector_Enable(char EnableFlag)
{
//	Power-Detector Enable in Tx Mode.
//	Set to 1 to enable the power detector or set to 0 to disable the detector.

	SetFlagVal(&reg6, (flags_t) MAX2830_POWER_DETECTOR_ENABLE_FLAG, EnableFlag);

	send_SPI(reg6 << 4 | 0x6);
}

void Set_Tx_Calibration_Mode(char EnableFlag)
{
//	Tx Calibration Mode.
//	Set to 1 to place the device in Tx calibration mode or 0 to place the
//	device in normal Tx mode when RXTX is set to 1 (see Table 32).

	SetFlagVal(&reg6, (flags_t) MAX2830_TX_CALIBRATION_MODE_ENABLE_FLAG, EnableFlag);

	send_SPI(reg6 << 4 | 0x6);
}

void Set_Rx_Calibration_Mode(char EnableFlag)
{
//	Rx Calibration Mode.
//	Set to 1 to place the device in Rx calibration mode or 0 to place the
//	device in normal Rx mode when RXTX is set to 0 (see Table 32).

	SetFlagVal(&reg6, (flags_t) MAX2830_RX_CALIBRATION_MODE_ENABLE_FLAG, EnableFlag);

	send_SPI(reg6 << 4 | 0x6);
}


///////////////////////////////////////////////////////////////////////
//
//	Stuff for register 7
//

void Set_RX_Highpass_Corner_Frequency(uint8_t value)
{
//	Receiver Highpass Corner Frequency Setting for RXHP = 0.
//	Set to
//		00 for 100Hz,
//		X1 for 4kHz,
//		and 10 for 30kHz.

	value = value & 0x3;

	reg7 = reg7 | (((uint32_t) value) << 12);

	send_SPI(reg7 << 4 | 0x7);
}

void Set_TX_Lowpass_Corner_Frequency(uint8_t value)
{
//	Transmitter Lowpass Filter Corner Frequency Fine Adjustment (Relative to Coarse Setting).
//	See Table 9. Bits D1:D0 in A3:A0 = 1000 provide the lowpass filter corner coarse adjustment.

	value = value & 0x7;

	reg7 = reg7 | (((uint32_t) value) << 3);

	send_SPI(reg7 << 4 | 0x7);
}

void Set_RX_Lowpass_Corner_Frequency(uint8_t value)
{
//	Receiver Lowpass Filter Corner Frequency Fine Adjustment (Relative to Coarse Setting).
//	See table 6. Bits D1:D0 in A3:A0 = 1000 provide the lowpass filter corner coarse adjustment.

	value = value & 0x7;

	reg7 = reg7 | (((uint32_t) value) << 0);

	send_SPI(reg7 << 4 | 0x7);
}


///////////////////////////////////////////////////////////////////////
//
//	Stuff for register 8
//

void Set_RX_Gain_Prog_Through_SPI(char EnableFlag)
{
//	Enable Receiver Gain Programming Through the Serial Interface.
//	Set to 1 to enable programming through the 3-wire serial interface
//	(D6:D0 in Register A3:A0 = 1011).
//	Set to 0 to enable programming in parallel through external digital pins (B7:B1).

	SetFlagVal(&reg8, (flags_t) MAX2830_RX_GAIN_PROG_THROUGH_SPI_ENABLE_FLAG, EnableFlag);

	send_SPI(reg8 << 4 | 0x8);
}

void Set_Independent_RSSI_Output_Enable(char EnableFlag)
{
//	RSSI Operating Mode.
//	Set to 1 to enable RSSI output independent of RXHP.
//	Set to 0 to disable RSSI output if RXHP = 0, and enable the RSSI output if RXHP = 1.

	SetFlagVal(&reg8, (flags_t) MAX2830_INDEPENDENT_RSSI_OUTPUT_ENABLE_FLAG, EnableFlag);

	send_SPI(reg8 << 4 | 0x8);
}

void Set_RSSI_Power_Temp_Selection(uint8_t value)
{
//	RSSI, Power Detector, or Temperature Sensor Output Select.
//	Set to 00 to enable the RSSI output in receive mode.
//	Set to 01 to enable the temperature sensor output in receive and transmit modes.
//	Set to 10 to enable the power-detector output in transmit mode.
//	See Table 7.

	value = value & 0x7;

	reg8 = reg8 | (((uint32_t) value) << 8);

	send_SPI(reg8 << 4 | 0x8);
}

void Set_RX_TX_LPF_Corner_frequency(uint8_t value)
{
//	Receiver and Transmitter Lowpass Filter Corner Frequency Coarse Adjustment.
//	See Tables 4 and 7.

	value = value & 0x7;

	reg8 = reg8 | (((uint32_t) value) << 0);

	send_SPI(reg8 << 4 | 0x8);
}


///////////////////////////////////////////////////////////////////////
//
//	Stuff for register 9
//

void Set_TX_Gain_Prog_Through_SPI(char EnableFlag)
{
//	Enable Transmitter Gain Programming Through the Serial or Parallel Interface.
//	Set to 1 to enable programming through the 3-wire serial interface (D5:D0 in Register A3:A0 = 1011).
//	Set to 0 to enable programming in parallel through external digital pins (B6:B1).

	flags_t		reg9 = MAX2830_REG9;

	SetFlagVal(&reg9, (flags_t) MAX2830_TX_GAIN_PROG_THROUGH_SPI_ENABLE_FLAG, EnableFlag);

	send_SPI(reg9 << 4 | 0x9);
}


///////////////////////////////////////////////////////////////////////
//
//	Stuff for register 10
//

void Set_PA_Delay(uint8_t value)
{
//	Power-Amplifier Enable Delay.
//	Sets a delay between RXTX  low-to-high transition and  internal  PA enable.
//	Programmable in 0.5µs steps. D13:D10 = 0001 (0.2µs) and D13:D 10 = 1111 (7µs).

	flags_t		reg10 = MAX2830_REG10;

	value = value & 0xF;

	reg10 = reg10 | (((uint32_t) value) << 10);

	send_SPI(reg10 << 4 | 0xA);
}


///////////////////////////////////////////////////////////////////////
//
//	Stuff for register 12
//

void Set_TX_VGA_Gain(uint8_t value)
{
//	Transmitter VGA Gain Control.
//	Set D5:D0 = 000000 for minimum gain, and set D5:D0 = 111111 for maximum gain.

	flags_t		reg12 = MAX2830_REG12;

	value = value & 0x3F;

	reg12 = reg12 | (((uint32_t) value) << 0);

	send_SPI(reg12 << 4 | 0xC);
}





///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
//
//	High level functions
//


void SetFrequency(uint32_t f)
{
// See Max2830 documentation page 24 for calculation

	uint32_t	f_LO = 20e6; // Frequency of the TCXO on the RF board
	uint8_t		RefFreqDivider = 1; // Either 1 or 2

	uint32_t	f_Comp;
	uint8_t		IntegerDivider; // 64<=  <=255
	uint32_t	FractionalDivider;

	f_Comp = f_LO / RefFreqDivider;

	IntegerDivider = (uint8_t) (f / f_Comp);
	if (IntegerDivider < 64)
		IntegerDivider = 64;

	FractionalDivider = (uint32_t) (((uint64_t) (f % f_Comp)) * 1048575 / f_Comp);

//////////////////////////////////

//TODO Do we really have to set these every time?
	Set_Fractional_N_PLL_Mode_Enable(1);			//Set 1 to enable the fractional-N PLL or set 0 to enable the integer-N PLL.
	Set_Reference_Frequency_Divider_Ratio(0);		//Set to 0 to divide by 1. Set to 1 to divide by 2.

//Actual frequency setup
	Set_Main_Divider(IntegerDivider, FractionalDivider);

}


void SetTXGain(uint8_t g)
{
//TODO Do we really have to set this every time?
	Set_TX_Gain_Prog_Through_SPI(1); //1 SPI, 0 external digital pins (B6:B1).

	Set_TX_VGA_Gain(g);
}



void ShutDownEnable(char EnableFlag)
{
// 1 -> enable shutdown
// 0 -> wake up
	SetGPIO(nSHDN, !EnableFlag );
}


void SetRXTX(RXTX_t RXTX_mode)
{
// 1 -> enable shutdown
// 0 -> wake up
	SetGPIO(RXTX, (uint8_t) RXTX_mode);
}




void Max2830init()
{
// Set default values recommended by manufacturer
	send_SPI(MAX2830_REG0 << 4 | 0x0);
	send_SPI(MAX2830_REG1 << 4 | 0x1);
	send_SPI(MAX2830_REG2 << 4 | 0x2);
	send_SPI(MAX2830_REG3 << 4 | 0x3);
	send_SPI(MAX2830_REG4 << 4 | 0x4);
	send_SPI(MAX2830_REG5 << 4 | 0x5);
	send_SPI(MAX2830_REG6 << 4 | 0x6);
	send_SPI(MAX2830_REG7 << 4 | 0x7);
	send_SPI(MAX2830_REG8 << 4 | 0x8);
	send_SPI(MAX2830_REG9 << 4 | 0x9);
	send_SPI(MAX2830_REG10 << 4 | 0xA);
	send_SPI(MAX2830_REG11 << 4 | 0xB);
	send_SPI(MAX2830_REG12 << 4 | 0xC);
	send_SPI(MAX2830_REG13 << 4 | 0xD);
	send_SPI(MAX2830_REG14 << 4 | 0xE);
	send_SPI(MAX2830_REG15 << 4 | 0xF);
}
