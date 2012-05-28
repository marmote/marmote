//#include "io_ports.h"
#include "Max2830.h"

#include <stdint.h>
#include "flags.h"


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

/*******************************************************************************
*
*                               DEFAULT REG VALUES
*
*          				(According to the recommended values
*          				in the table above with some platform
*          				specific modifications)
*
*******************************************************************************/
#define MAX2830_REG0	0x1740
#define MAX2830_REG1	0x119A
#define MAX2830_REG2	0x1003
#define MAX2830_REG3	0x0079
#define MAX2830_REG4	0x3666

//#define MAX2830_REG5	0x00A4
#define MAX2830_REG5	0x00A0 //No division for reference frequency divider

#define MAX2830_REG6	0x0060
#define MAX2830_REG7	0x1022

//#define MAX2830_REG8	0x2021
#define MAX2830_REG8	0x3421 //Enable RX gain setup through SPI AND RSSI output independent of RXHP

//#define MAX2830_REG9	0x03B5
#define MAX2830_REG9	0x07B5 //Enable TX gain setup through SPI


#define MAX2830_REG10	0x1DA4
#define MAX2830_REG11	0x007F
#define MAX2830_REG12	0x0140
#define MAX2830_REG13	0x0E92

//#define MAX2830_REG14	0x033B
#define MAX2830_REG14	0x013B //Reference clock disabled by default

#define MAX2830_REG15	0x0145


/*******************************************************************************
*
*						SOME FLAGS FOR REGISTER HANDLING
*
*******************************************************************************/
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
//reg 14
#define MAX2830_REF_CLK_OUTPUT_DIV_RATIO_FLAG						0x0400
#define MAX2830_REF_CLK_OUTPUT_ENABLE_FLAG							0x0200


//Registers
uint16_t Max2830Regs[] = {
		MAX2830_REG0,
		MAX2830_REG1,
		MAX2830_REG2,
		MAX2830_REG3,
		MAX2830_REG4,
		MAX2830_REG5,
		MAX2830_REG6,
		MAX2830_REG7,
		MAX2830_REG8,
		MAX2830_REG9,
		MAX2830_REG10,
		MAX2830_REG11,
		MAX2830_REG12,
		MAX2830_REG13,
		MAX2830_REG14,
		MAX2830_REG15 };



/*******************************************************************************
*
*							LOW LEVEL FUNCTIONS
*
*******************************************************************************/
void send_SPI_addr(uint16_t data, uint8_t addr)
{
	if (addr > 15)
		addr = 15;

	send_SPI( ((uint32_t) data) << 4 | (uint32_t) addr );
}

void send_Reg(uint8_t addr)
{
	if (addr > 15)
		addr = 15;

	send_SPI_addr(Max2830Regs[addr], addr);
}


/*******************************************************************************
*
*							LOW LEVEL REG HANDLING
*
*******************************************************************************/
/*******************************************************************************
*	REG0
*******************************************************************************/
void Fractional_N_PLL_Mode_Enable(char EnableFlag)
{
//	Fractional-N PLL Mode Enable.
//	Set 1 to enable the fractional-N PLL or set 0 to enable the integer-N PLL.

	SetFlagVal(&Max2830Regs[0], (flags_t) MAX2830_FRACTIONAL_N_PLL_MODE_ENABLE_FLAG, EnableFlag);

//	send_SPI_addr(Max2830Regs[0], 0);
}


/*******************************************************************************
*	REG1
*******************************************************************************/
void Lock_Detector_Output_Select(char OutputType)
{
//	Lock-Detector Output Select.
//	Set to 1 for CMOS Output. Set to 0 for open-drain output.
//	Bit D9 	in register (A3:A0 = 0101) enables or disables an internal 30kOhm pullup resistor in open-drain output mode.

	SetFlagVal(&Max2830Regs[1], (flags_t) MAX2830_LOCK_DETECTOR_OUTPUT_SELECTOR, OutputType);

//	send_SPI_addr(Max2830Regs[1], 1);
}


/*******************************************************************************
*	REG2
*******************************************************************************/

//Nothing here...


/*******************************************************************************
*	REG3 AND REG4
*******************************************************************************/
void Main_Divider(uint8_t IntegerPortion, uint32_t FractionalPortion)
{
//	8-Bit Integer Portion of Main Divider. Programmable from 64 to 255.

//	6 LSBs of 20-Bit Fractional Portion of Main Divider
//	14 MSBs of 20-Bit Fractional Portion of Main Divider

	if (IntegerPortion < 64)
		IntegerPortion = 64;

	FractionalPortion = FractionalPortion & 0xFFFFF;

	Max2830Regs[3] = (uint16_t) ( IntegerPortion | ( (FractionalPortion & 0x3F) << 8 ) );

//	send_SPI_addr(Max2830Regs[3], 3);

	Max2830Regs[4] = (uint16_t) ( (FractionalPortion & 0xFFFC0) >> 6 );

//	send_SPI_addr(Max2830Regs[4], 4);
}


/*******************************************************************************
*	REG5
*******************************************************************************/
void Lock_Detect_Output_Internal_Pullup_Resistor_Enable(char EnableFlag)
{
//	Lock-Detect Output Internal Pullup Resistor Enable.
//	Set to 1 to enable internal 30kOhm pullup resistor or set to 0 to disable the resistor.
//	Only available when lock-detect, open-drain output is selected (A3:A0 = 0001, D12 = 1).

	SetFlagVal(&Max2830Regs[5], (flags_t) MAX2830_LOCK_DETECT_OUTPUT_INTERNAL_PULLUP_ENABLE_FLAG, EnableFlag);

//	send_SPI_addr(Max2830Regs[5], 5);
}

void Lock_Detect_Output_Enable(char EnableFlag)
{
//	Lock-Detect Output Enable.
//	Set to 1 to enable the lock-detect output or set to 0 to disable the output.
//	The output is high impedance when disabled.

	SetFlagVal(&Max2830Regs[5], (flags_t) MAX2830_LOCK_DETECT_OUTPUT_ENABLE_FLAG, EnableFlag);

//	send_SPI_addr(Max2830Regs[5], 5);
}

void Reference_Frequency_Divider_Ratio(char DividerRatio)
{
//	Reference Frequency Divider Ratio to PLL.
//	Set to 0 to divide by 1. Set to 1 to divide by 2.

	SetFlagVal(&Max2830Regs[5], (flags_t) MAX2830_REFERENCE_DIV_RATIO, DividerRatio);

//	send_SPI_addr(Max2830Regs[5], 5);
}


/*******************************************************************************
*	REG6
*******************************************************************************/
typedef enum __Gain_Control_t
{
	GAIN_CTRL_9dB = 0,
	GAIN_CTRL_19dB = 1,
	GAIN_CTRL_29dB = 2,
	GAIN_CTRL_39dB = 3
} Gain_Control_t;

void TX_IQ_Calibration_LO_Leakage_and_Sideband_Detector_Gain(Gain_Control_t value)
{
//	Tx I/Q Calibration LO Leakage and Sideband Detector Gain-Control Bits.
//	D12:D11 =
//		00: 9dB;
//		01 19dB;
//		10: 29dB;
//		11: 39dB.

//	Max2830Regs[6] = Max2830Regs[6] | ( ((uint16_t) value & 0x3) << 11 );
	Max2830Regs[6] = Max2830Regs[6] | ( ((uint16_t) value) << 11 );

//	send_SPI_addr(Max2830Regs[6], 6);
}

void Power_Detector_Enable(char EnableFlag)
{
//	Power-Detector Enable in Tx Mode.
//	Set to 1 to enable the power detector or set to 0 to disable the detector.

	SetFlagVal(&Max2830Regs[6], (flags_t) MAX2830_POWER_DETECTOR_ENABLE_FLAG, EnableFlag);

//	send_SPI_addr(Max2830Regs[6], 6);
}

void Tx_Calibration_Mode(char EnableFlag)
{
//	Tx Calibration Mode.
//	Set to 1 to place the device in Tx calibration mode or 0 to place the
//	device in normal Tx mode when RXTX is set to 1 (see Table 32).

	SetFlagVal(&Max2830Regs[6], (flags_t) MAX2830_TX_CALIBRATION_MODE_ENABLE_FLAG, EnableFlag);

//	send_SPI_addr(Max2830Regs[6], 6);
}

void Rx_Calibration_Mode(char EnableFlag)
{
//	Rx Calibration Mode.
//	Set to 1 to place the device in Rx calibration mode or 0 to place the
//	device in normal Rx mode when RXTX is set to 0 (see Table 32).

	SetFlagVal(&Max2830Regs[6], (flags_t) MAX2830_RX_CALIBRATION_MODE_ENABLE_FLAG, EnableFlag);

//	send_SPI_addr(Max2830Regs[6], 6);
}


/*******************************************************************************
*	REG7
*******************************************************************************/
typedef enum __Reg_RX_HPF_Corner_Frequency_t
{
	REG_RX_HPF_0_1kHz = 0,
	REG_RX_HPF_4kHz = 1,
	REG_RX_HPF_30kHz = 2
} Reg_RX_HPF_Corner_Frequency_t;

void RX_Highpass_Corner_Frequency(Reg_RX_HPF_Corner_Frequency_t value)
{
//	Receiver Highpass Corner Frequency Setting for RXHP = 0.
//	Set to
//		00 for 100Hz,
//		X1 for 4kHz, and
//		10 for 30kHz.

//	Max2830Regs[7] = Max2830Regs[7] | ( ((uint16_t) value & 0x3) << 12 );
	Max2830Regs[7] = Max2830Regs[7] | ( ((uint16_t) value) << 12 );

//	send_SPI_addr(Max2830Regs[7], 7);
}


typedef enum __LPF_Corner_Frequency_Fine_t
{
	LPF_FINE_90PERCENT = 0,
	LPF_FINE_95PERCENT = 1,
	LPF_FINE_100PERCENT = 2,
	LPF_FINE_105PERCENT = 3,
	LPF_FINE_110PERCENT = 4,
	LPF_FINE_115PERCENT = 5
} LPF_Corner_Frequency_Fine_t;

void TX_LPF_Corner_Frequency(LPF_Corner_Frequency_Fine_t value)
{
//	Transmitter Lowpass Filter Corner Frequency Fine Adjustment (Relative to Coarse Setting).
//	See Table 9. Bits D1:D0 in A3:A0 = 1000 provide the lowpass filter corner coarse adjustment.

//	Max2830Regs[7] = Max2830Regs[7] | ( ((uint16_t) value & 0x7) << 3 );
	Max2830Regs[7] = Max2830Regs[7] | ( ((uint16_t) value) << 3 );

//	send_SPI_addr(Max2830Regs[7], 7);
}

void RX_LPF_Corner_Frequency(LPF_Corner_Frequency_Fine_t value)
{
//	Receiver Lowpass Filter Corner Frequency Fine Adjustment (Relative to Coarse Setting).
//	See table 6. Bits D1:D0 in A3:A0 = 1000 provide the lowpass filter corner coarse adjustment.

//	Max2830Regs[7] = Max2830Regs[7] | ( ((uint16_t) value & 0x7) << 0 );
	Max2830Regs[7] = Max2830Regs[7] | ( ((uint16_t) value) << 0 );

//	send_SPI_addr(Max2830Regs[7], 7);
}


/*******************************************************************************
*	REG8
*******************************************************************************/
void RX_Gain_Prog_Through_SPI(char EnableFlag)
{
//	Enable Receiver Gain Programming Through the Serial Interface.
//	Set to 1 to enable programming through the 3-wire serial interface
//	(D6:D0 in Register A3:A0 = 1011).
//	Set to 0 to enable programming in parallel through external digital pins (B7:B1).

	SetFlagVal(&Max2830Regs[8], (flags_t) MAX2830_RX_GAIN_PROG_THROUGH_SPI_ENABLE_FLAG, EnableFlag);

//	send_SPI_addr(Max2830Regs[8], 8);
}

void Independent_RSSI_Output_Enable(char EnableFlag)
{
//	RSSI Operating Mode.
//	Set to 1 to enable RSSI output independent of RXHP.
//	Set to 0 to disable RSSI output if RXHP = 0, and enable the RSSI output if RXHP = 1.

	SetFlagVal(&Max2830Regs[8], (flags_t) MAX2830_INDEPENDENT_RSSI_OUTPUT_ENABLE_FLAG, EnableFlag);

//	send_SPI_addr(Max2830Regs[8], 8);
}

/*typedef enum __Max2830_Analog_Meas_t
{
	MAX2830_ANALOG_MEAS_RSSI	= 0,
	MAX2830_ANALOG_MEAS_TEMP	= 1,
	MAX2830_ANALOG_MEAS_TXPOW	= 2
} Max2830_Analog_Meas_t;*/

void RSSI_Power_Temp_Selection(Max2830_Analog_Meas_t value)
{
//	RSSI, Power Detector, or Temperature Sensor Output Select.
//	Set to 00 to enable the RSSI output in receive mode.
//	Set to 01 to enable the temperature sensor output in receive and transmit modes.
//	Set to 10 to enable the power-detector output in transmit mode.
//	See Table 7.

//	Max2830Regs[8] = Max2830Regs[8] | ( ((uint16_t) value & 0x3) << 8 );
	Max2830Regs[8] = Max2830Regs[8] | ( ((uint16_t) value) << 8 );

//	send_SPI_addr(Max2830Regs[8], 8);
}


typedef enum __LPF_Corner_Frequency_Coarse_t
{
	LPF_COARSE_8 = 0,
	LPF_COARSE_11 = 1,
	LPF_COARSE_16_5 = 2,
	LPF_COARSE_22_5 = 3
} LPF_Corner_Frequency_Coarse_t;

void RX_TX_LPF_Corner_frequency(LPF_Corner_Frequency_Coarse_t value)
{
//	Receiver and Transmitter Lowpass Filter Corner Frequency Coarse Adjustment.
//	See Tables 4 and 7.

//	Max2830Regs[8] = Max2830Regs[8] | ( ((uint16_t) value & 0x3) << 0 );
	Max2830Regs[8] = Max2830Regs[8] | ( ((uint16_t) value) << 0 );

//	send_SPI_addr(Max2830Regs[8], 8);
}


/*******************************************************************************
*	REG9
*******************************************************************************/
void TX_Gain_Prog_Through_SPI(char EnableFlag)
{
//	Enable Transmitter Gain Programming Through the Serial or Parallel Interface.
//	Set to 1 to enable programming through the 3-wire serial interface (D5:D0 in Register A3:A0 = 1011).
//	Set to 0 to enable programming in parallel through external digital pins (B6:B1).

	SetFlagVal(&Max2830Regs[9], (flags_t) MAX2830_TX_GAIN_PROG_THROUGH_SPI_ENABLE_FLAG, EnableFlag);

//	send_SPI_addr(Max2830Regs[9], 9);
}


/*******************************************************************************
*	REG10
*******************************************************************************/
void PA_Delay(uint8_t value)
{
//	Power-Amplifier Enable Delay.
//	Sets a delay between RXTX  low-to-high transition and  internal  PA enable.
//	Programmable in 0.5탎 steps.
//		D13:D10 = 0001 (0.2탎) and
//		D13:D10 = 1111 (7탎).

	Max2830Regs[10] = Max2830Regs[10] | ( ((uint16_t) value & 0xF) << 10 );

//	send_SPI_addr(Max2830Regs[10], 10);
}


void Stage_2_PA_Bias_current(uint8_t value)
{
//	Second-Stage Power-Amplifier Bias Current Adjustment.
//	Set to XXXX for 802.11g/b.

	Max2830Regs[10] = Max2830Regs[10] | ( ((uint16_t) value & 0xF) << 3 );

//	send_SPI_addr(Max2830Regs[10], 10);
}


void Stage_1_PA_Bias_current(uint8_t value)
{
//	First-Stage Power-Amplifier Bias Current Adjustment.
//	Set to XXXX for 802.11g/b.

	Max2830Regs[10] = Max2830Regs[10] | ( ((uint16_t) value & 0x7) << 0 );

//	send_SPI_addr(Max2830Regs[10], 10);
}


/*******************************************************************************
*	REG11
*******************************************************************************/
/*typedef enum __Max2830_LNA_Att_t
{
	MAX2830_LNA_HIGH_GAIN			= 0,
	MAX2830_LNA_MED_GAIN_16dB_LESS	= 1,
	MAX2830_LNA_LOW_GAIN_33dB_LESS	= 2
} Max2830_LNA_Att_t;*/

void LNA_Gain(Max2830_LNA_Att_t value)
{
//	LNA Gain Control.
//	Set to 11 for high-gain mode.
//	Set to 10 for medium-gain mode, reducing LNA gain by 16dB.
//	Set to 0X for low-gain mode, reducing LNA gain by 33dB.

//	Max2830Regs[11] = Max2830Regs[11] | ( ((uint16_t) value & 0x3) << 5 );
	Max2830Regs[11] = Max2830Regs[11] | ( ((uint16_t) value) << 5 );

//	send_SPI_addr(Max2830Regs[11], 11);
}

void RX_VGA(uint8_t value)
{
//	Receiver VGA Control.
//	Set D4:D0 = 00000 for minimum gain and
//	D4:D0 = 11111 for maximum gain.

	Max2830Regs[11] = Max2830Regs[11] | ( ((uint16_t) value & 0x1F) << 0 );

//	send_SPI_addr(Max2830Regs[11], 11);
}


/*******************************************************************************
*	REG12
*******************************************************************************/
void TX_VGA(uint8_t value)
{
//	Transmitter VGA Gain Control.
//	Set D5:D0 = 000000 for minimum gain, and
//	set D5:D0 = 111111 for maximum gain.

	Max2830Regs[12] = Max2830Regs[12] | ( ((uint16_t) value & 0x3F) << 0 );

//	send_SPI_addr(Max2830Regs[12], 12);
}


/*******************************************************************************
*	REG13
*******************************************************************************/

//Nothing here...


/*******************************************************************************
*	REG14
*******************************************************************************/
void Ref_Clk_Output_Div(char Ratio)
{
//	Reference Clock Output Divider Ratio.
//	Set 1 to divide by 2 or
//	set 0 to divide by 1.

	SetFlagVal(&Max2830Regs[14], (flags_t) MAX2830_REF_CLK_OUTPUT_DIV_RATIO_FLAG, Ratio);

//	send_SPI_addr(Max2830Regs[14], 14);
}

void Ref_Clk_Output_Enable(char EnableFlag)
{
//	Reference Clock Output Enable.
//	Set 1 to enable the reference clock output or
//	set 0 to disable.

	SetFlagVal(&Max2830Regs[14], (flags_t) MAX2830_REF_CLK_OUTPUT_ENABLE_FLAG, EnableFlag);

//	send_SPI_addr(Max2830Regs[14], 14);
}


/*******************************************************************************
*	REG15
*******************************************************************************/
/*typedef enum __Max2830_IQ_Out_CM_t
{
	MAX2830_IQ_OUT_CM_1_1V	= 0,
	MAX2830_IQ_OUT_CM_1_2V	= 1,
	MAX2830_IQ_OUT_CM_1_3V	= 2,
	MAX2830_IQ_OUT_CM_1_45V	= 3
} Max2830_IQ_Out_CM_t;*/

void RX_IQ_Output_CM(Max2830_IQ_Out_CM_t value)
{
//	Receiver I/Q Output Common-Mode Voltage Adjustment.
//	Set D11:D10 =
//			00: 1.1V,
//			01: 1.2V,
//			10: 1.3V,
//			11: 1.45V.

//	Max2830Regs[15] = Max2830Regs[15] | ( ((uint16_t) value & 0x3) << 10 );
	Max2830Regs[15] = Max2830Regs[15] | ( ((uint16_t) value) << 10 );

//	send_SPI_addr(Max2830Regs[15], 15);
}


/*******************************************************************************
*
*							HIGH LEVEL FUNCTIONS
*
*******************************************************************************/

#define FREQ_CONST 1048575 // = 2^20 - 1

uint32_t Max2830_Set_Frequency(uint32_t freq_Hz)
{
// See Max2830 documentation page 24 for calculation

	uint32_t	f_LO = 20e6; // Frequency of the TCXO on the RF board
	uint8_t		RefFreqDivider = 1; // Either 1 or 2

	uint32_t	f_Comp;
	uint8_t		IntegerDivider; // 64<=  <=255
	uint32_t	FractionalDivider;

	f_Comp = f_LO / RefFreqDivider;

	IntegerDivider = (uint8_t) (freq_Hz / f_Comp);
	if (IntegerDivider < 64)
		IntegerDivider = 64;

	FractionalDivider = (uint32_t) (((uint64_t) (freq_Hz % f_Comp)) * FREQ_CONST / f_Comp);

//////////////////////////////////

//TODO Do we really have to set these every time?
//reg0
//	Fractional_N_PLL_Mode_Enable(1);		//Set 1 to enable the fractional-N PLL or set 0 to enable the integer-N PLL.
//	send_Reg(0);
//reg5
//	Reference_Frequency_Divider_Ratio(0);	//Set to 0 to divide by 1. Set to 1 to divide by 2.
//	send_Reg(5);

//Actual frequency setup
	Main_Divider(IntegerDivider, FractionalDivider);
	send_Reg(3);
	send_Reg(4);

	return (uint32_t) (IntegerDivider * f_Comp + ((uint64_t) FractionalDivider) * ((uint64_t) f_Comp) / FREQ_CONST );
}


/*******************************************************************************
*******************************************************************************/
void Max2830_Set_TX_Attenuation(float VGA_att_dB)
{
//TODO Do we really have to set this every time?
//reg9
//	TX_Gain_Prog_Through_SPI(1); //1 SPI, 0 external digital pins (B6:B1).
//	send_Reg(9);

	if (VGA_att_dB > 31.5)
		VGA_att_dB = 31.5;
	if (VGA_att_dB < 0.0)
		VGA_att_dB = 0.0;

//	uint8_t g = (uint8_t) (63 - 2 * VGA_att_dB);

//reg12
	TX_VGA( (uint8_t) (63 - 2 * VGA_att_dB) );

	send_Reg(12);
}


/*******************************************************************************
*******************************************************************************/
void Max2830_Set_RX_Attenuation(Max2830_LNA_Att_t LNA_att, uint8_t VGA_att_dB)
{
//TODO Do we really have to set this every time?
//reg8
//	RX_Gain_Prog_Through_SPI(1); //1 SPI, 0 external digital pins (B6:B1).
//	send_Reg(8);

	if (VGA_att_dB > 62)
		VGA_att_dB = 62;

//	uint8_t g = (uint8_t) (31 - VGA_att_dB / 2);

//reg11
	RX_VGA( (uint8_t) (31 - VGA_att_dB / 2) );

//reg11
	LNA_Gain(LNA_att);

	send_Reg(11);
}


/*******************************************************************************
*******************************************************************************/
void Max2830_Set_RXTX_LPF(Max2830_RXTX_BW_t BW)
{
//reg8
	RX_TX_LPF_Corner_frequency(	(LPF_Corner_Frequency_Coarse_t) (((uint8_t) BW) / 6) );
//reg7
	TX_LPF_Corner_Frequency( (LPF_Corner_Frequency_Fine_t) (((uint8_t) BW) % 6) );
	RX_LPF_Corner_Frequency( (LPF_Corner_Frequency_Fine_t) (((uint8_t) BW) % 6) );

	send_Reg(8);
	send_Reg(7);
}


/*******************************************************************************
*******************************************************************************/
void Max2830_Set_Lock_Detector(char Enable, char CMOSOutput, char PullupForOpenDrain)
{
//reg1
	Lock_Detector_Output_Select(CMOSOutput); //	Set to 1 for CMOS Output. Set to 0 for open-drain output.
//reg5
	Lock_Detect_Output_Internal_Pullup_Resistor_Enable(PullupForOpenDrain); //	Set to 1 to enable internal 30kOhm pullup resistor or set to 0 to disable the resistor.
	Lock_Detect_Output_Enable(Enable); //	Set to 1 to enable the lock-detect output or set to 0 to disable the output.

	send_Reg(1);
	send_Reg(5);
}


/*******************************************************************************
*******************************************************************************/
void Max2830_Set_Ref_Clk_Output(char Enable, char DivideByTwo)
{
//reg14
	Ref_Clk_Output_Div(DivideByTwo); // Set 1 to divide by 2 or set 0 to divide by 1.
	Ref_Clk_Output_Enable(Enable); //	Set 1 to enable the reference clock output or set 0 to disable.

	send_Reg(14);
}


/*******************************************************************************
*******************************************************************************/
void Max2830_Set_RX_HPF(Max2830_RX_HPF_t value)
{
	if (value == MAX2830_RX_HPF_600kHz)
		SetGPIO(MAX2830_RXHP, 1);
	else
	{
		SetGPIO(MAX2830_RXHP, 0);
//reg7
		RX_Highpass_Corner_Frequency( (Reg_RX_HPF_Corner_Frequency_t) value );

		send_Reg(7);
	}
}


/*******************************************************************************
*******************************************************************************/
void Max2830_Set_RSSI_Output(Max2830_Analog_Meas_t	value)
{
//TODO Do we really have to set this every time?
//reg 8
//	Independent_RSSI_Output_Enable(1); //Set to 1 to enable RSSI output independent of RXHP.
//	send_Reg(8);

	if ( (value == MAX2830_ANALOG_MEAS_TXPOW) != ( Max2830Regs[8] & 0x200 ) )
	{
//reg6
		Power_Detector_Enable(value == MAX2830_ANALOG_MEAS_TXPOW);	//	Set to 1 to enable the power detector or set to 0 to disable the detector.

		send_Reg(6);
	}

//reg8
	RSSI_Power_Temp_Selection(value);

	send_Reg(8);

}


/*******************************************************************************
*******************************************************************************/
void Max2830_Set_RX_IQ_Output_CM(Max2830_IQ_Out_CM_t value)
{
//reg15
	RX_IQ_Output_CM(value);

	send_Reg(15);
}


/*******************************************************************************
*******************************************************************************/
uint16_t Max2830_Set_PA_Delay(uint16_t delay_ns)
{
	if (delay_ns < 200)
		delay_ns = 200;

	if (delay_ns > 7000)
		delay_ns = 7000;

	uint8_t value = (uint8_t) ((7*delay_ns + 2000)/3400);

//reg10
	PA_Delay(value);
	//		D13:D10 = 0001 (0.2탎) and
	//		D13:D10 = 1111 (7탎).

	send_Reg(10);

	return (((uint16_t) value)*3400 - 2000)/7;
}


/*******************************************************************************
*******************************************************************************/
void Max2830_ShutDown(char ShutDown)
{
// 1 -> enable shutdown
// 0 -> wake up
	SetGPIO(MAX2830_nSHDN, !ShutDown );
}


/*******************************************************************************
*******************************************************************************/
void Max2830_Set_RXTX(Max2830_RXTX_Mode_t RXTX_mode)
{
	if (RXTX_mode == MAX2830_RX_MODE)
		SetGPIO(MAX2830_RXTX, 0);
	else
		SetGPIO(MAX2830_RXTX, 1);
}


/*******************************************************************************
*******************************************************************************/
void Max2830_Set_RX_Ant(Max2830_RX_Ant_t RX_Ant)
{
	if (RX_Ant == MAX2830_RX_ANT_MAIN)
		SetGPIO(MAX2830_ANTSEL, 0);
	else
		SetGPIO(MAX2830_ANTSEL, 1);
}


/*******************************************************************************
*******************************************************************************/
void Max2830_Init()
{
	SetGPIO(MAX2830_RXTX,	0);	//RX mode
	SetGPIO(MAX2830_ANTSEL,	1);	//RX from diversity (multiplexed) antenna
	SetGPIO(MAX2830_RXHP,	0);	//100, 4k, and 30k HPF filters enabled
	SetGPIO(MAX2830_nSHDN,	1);	//Start not in shutdown

	// Set default values
	send_Reg(0);
	send_Reg(1);
	send_Reg(2);
	send_Reg(3);
	send_Reg(4);
	send_Reg(5);
	send_Reg(6);
	send_Reg(7);
	send_Reg(8);
	send_Reg(9);
	send_Reg(10);
	send_Reg(11);
	send_Reg(12);
	send_Reg(13);
	send_Reg(14);
	send_Reg(15);
}
