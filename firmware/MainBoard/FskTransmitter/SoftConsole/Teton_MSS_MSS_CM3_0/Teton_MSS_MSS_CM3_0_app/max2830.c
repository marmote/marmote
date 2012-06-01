//-----------------------------------------------------------------------------
// Title         : Max2830 firmware source
// Project       : Marmote Teton (Main Board)
//-----------------------------------------------------------------------------
// File          : max2830.h
// Author        : Benjamin Babjak and Sandor Szilvasi
// Company       : Vanderbilt University, ISIS
// Created       : 2012-05-29 10:13
// Last update   : 2011-05-31 09:15
// Platform      : Marmote
// Target device : Actel A2F500M3G
// Tool version  : CoreConsole v3.3
// Standard      : CMSIS
//-----------------------------------------------------------------------------
// Description   : Firmware for the Max2830 RF transceiver chip found on the
//                 Marmote Joshua module.
//-----------------------------------------------------------------------------
// Copyright (c) 2006-2012, Vanderbilt University
// All rights reserved.
//
// Permission to use, copy, modify, and distribute this software and its
// documentation for any purpose, without fee, and without written agreement is
// hereby granted, provided that the above copyright notice, the following
// two paragraphs and the author appear in all copies of this software.
//
// IN NO EVENT SHALL THE VANDERBILT UNIVERSITY BE LIABLE TO ANY PARTY FOR
// DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING OUT
// OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF THE VANDERBILT
// UNIVERSITY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// THE VANDERBILT UNIVERSITY SPECIFICALLY DISCLAIMS ANY WARRANTIES,
// INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
// AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE PROVIDED HEREUNDER IS
// ON AN "AS IS" BASIS, AND THE VANDERBILT UNIVERSITY HAS NO OBLIGATION TO
// PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.
//-----------------------------------------------------------------------------
// Revisions     :
// Date            Version  Author			Description
// 2012-05-31      1.1      Sandor Szilvasi
// 2012-05-29      1.0      Benjamin Babjak	Created
//-----------------------------------------------------------------------------

#include "max2830.h"

void Max2830_init ( )
{
	uint8_t i;

	// Initialize SPI1
	MSS_SPI_init( &g_mss_spi1 );
	MSS_SPI_configure_master_mode(
			&g_mss_spi1,
			MSS_SPI_SLAVE_0,
			MSS_SPI_MODE0,
			MSS_SPI_PCLK_DIV_2, // 20 MHz PCLK1 > 10 MHz SPI clock
			SPI_FRAME_SIZE_MAX2830
	);

	// Configure all MAX2830 registers
	for ( i = 0 ; i < 16 ; i++ )
	{
		Max2830_write_register(i, max2830_regs[i]);
	}

	// Initialize GPIOs

	//MSS_GPIO_init(); //
	MSS_GPIO_config( MSS_GPIO_LD, MSS_GPIO_INPUT_MODE );
	MSS_GPIO_config( MSS_GPIO_SHDN, MSS_GPIO_OUTPUT_MODE );
	MSS_GPIO_config( MSS_GPIO_RXHP, MSS_GPIO_OUTPUT_MODE );
	MSS_GPIO_config( MSS_GPIO_ANTSEL, MSS_GPIO_OUTPUT_MODE );
	MSS_GPIO_config( MSS_GPIO_RXTX, MSS_GPIO_OUTPUT_MODE );

	// FIXME: revise default values
	MSS_GPIO_set_outputs( MSS_GPIO_get_outputs() | MSS_GPIO_RXHP_MASK );	// N/A (since TX)
	MSS_GPIO_set_outputs( MSS_GPIO_get_outputs() | MSS_GPIO_ANTSEL_MASK );	// N/A (see RXTX)

	Max2830_set_mode( MAX2830_SHUTDOWN_MODE );
}


uint16_t Max2830_read_register(uint8_t addr)
{
	if ( addr > 15 )
	{
		addr = 15;
	}

	return max2830_regs[addr];
}


void Max2830_write_register(uint8_t addr, uint16_t data)
{
	uint32_t tx_frame;

	if ( addr > 15 )
	{
		return;
	}

	tx_frame = addr & 0xF; // bytes [3:0] 4 LSB
	tx_frame |= (data & 0x3FFF) << 4; // bytes [18:4] 18 - 5 MSB

	// Initiate SPI transmission
	MSS_SPI_set_slave_select(
			&g_mss_spi1,
			MSS_SPI_SLAVE_0
	);

	MSS_SPI_transfer_frame(
			&g_mss_spi1,
			tx_frame
	);

	MSS_SPI_clear_slave_select(
			&g_mss_spi1,
			MSS_SPI_SLAVE_0
	);

	// Update local copy of register
	max2830_regs[addr] = data & 0x3FFF;
}



void Max2830_set_frequency( uint32_t freq_hz )
{
	uint32_t	f_LO = 20e6; // Frequency of the TCXO on the RF board
	uint8_t		RefFreqDivider = 1; // Either 1 or 2

	uint32_t	f_Comp;
	uint8_t		IntegerDivider; // 64 <=  <= 255
	uint32_t	FractionalDivider;

	if ( freq_hz < 2400000000u || freq_hz > 2500000000u )
	{
		return;
	}

	f_Comp = f_LO / RefFreqDivider;

	IntegerDivider = (uint8_t) (freq_hz / f_Comp);
	if (IntegerDivider < 64)
		IntegerDivider = 64;

	FractionalDivider = (uint32_t) (((uint64_t) (freq_hz % f_Comp)) * 1048575 / f_Comp);
	FractionalDivider = FractionalDivider & 0xFFFFF;

	// TODO: Do we really have to set these every time?
	// Set_Fractional_N_PLL_Mode_Enable(1);			//Set 1 to enable the fractional-N PLL or set 0 to enable the integer-N PLL.
	// Set_Reference_Frequency_Divider_Ratio(0);		//Set to 0 to divide by 1. Set to 1 to divide by 2.

	// Actual frequency setup
	//	8-Bit Integer Portion of Main Divider. Programmable from 64 to 255.

	//	6 LSBs of 20-Bit Fractional Portion of Main Divider
	//	14 MSBs of 20-Bit Fractional Portion of Main Divider

	Max2830_write_register(0x3, IntegerDivider | ((FractionalDivider & 0x3F) << 8));
	Max2830_write_register(0x4, (FractionalDivider >> 6));
}

uint32_t Max2830_get_frequency( void )
{
	// TODO: cleanup variables
	// TODO: read fractional PLL mode enable bit (assume bit value 1 now)
	// TODO: read reference frequency divider ratio (assume bit value 0 now - divide by 1)

	const uint32_t FREQ_CONST = 1048575; // 2^20-1  or (1 << 19) - 1;
	uint32_t	f_LO = 20e6; // Frequency of the TCXO on the RF board
	uint8_t		RefFreqDivider = 1; // Either 1 or 2
	uint8_t IntegerDivider;
	uint32_t FractionalDivider;
	uint32_t freq_hz;
	uint32_t	f_Comp;

	f_Comp = f_LO / RefFreqDivider;

	IntegerDivider = Max2830_read_register(3) & 0xFF;				//  [7:0] -> IntegerDivider[7:0]
	FractionalDivider  = (Max2830_read_register(3) >> 8) & 0x3F;	// [13:8] -> FractionalDivider[5:0]
	FractionalDivider |= (Max2830_read_register(4) & 0x3FFF) << 6;  // [13:0] -> FractionalDivider[19:6]

	freq_hz = (uint32_t) (IntegerDivider * f_Comp + ((uint64_t) FractionalDivider) * ((uint64_t) f_Comp) / FREQ_CONST );

	return freq_hz;
}


float Max2830_get_tx_gain( void )
{
	uint16_t gain;

	gain = Max2830_read_register(12) & 0x3F;

	return (float)gain / 2;
}

void Max2830_set_tx_gain( float gain_db )
{
	// FIXME: consider using uint8 instead of float for gain_db
	// TODO: Check if this needs to be set every time
	//	TX_Gain_Prog_Through_SPI(1); //1 SPI, 0 external digital pins (B6:B1).
	// Max2830_write_register(9, max2830_regs[9]);

	uint8_t gain;
	uint16_t reg_val;

	if (gain_db > 31.5)
	{
		gain_db = 31.5;
	}

	if (gain_db < 0.0)
	{
		gain_db = 0.0;
	}

	gain = 2 * gain_db;

	reg_val = Max2830_read_register(12) & ~0x3F; // Zero [5:0]
	reg_val |= gain & 0x3F; // Set gain in [5:0]

	Max2830_write_register(12, reg_val);
}

/*
void Max2830_Set_RXTX( Max2830_RXTX_Mode_t RXTX_mode )
{
	if (RXTX_mode == MAX2830_RX_MODE)
	{
		MSS_GPIO_set_outputs( MSS_GPIO_get_outputs() & ~MSS_GPIO_RXTX_MASK );
	}
	else
	{
		MSS_GPIO_set_outputs( MSS_GPIO_get_outputs() | MSS_GPIO_RXTX_MASK );
	}
}
*/

uint32_t Max2830_get_bandwidth( void )
{
	uint16_t bw;

	// Get LPF coarse -3dB corner frequency (R8[1:0])
	bw = (Max2830_read_register(8) & 0x3) * 6;

	// Get LPF fine -3dB corner frequency for TX (R7[5:3])
	// NOTE: Assuming the same value is set for RX
	bw += Max2830_read_register(7) & 0x7;

	return max2830_lpf_bws[bw];
}


void Max2830_set_bandwidth( uint32_t bandwidth )
{
	uint16_t i;
	uint16_t reg_val;

	for ( i = 0 ; i < sizeof(max2830_lpf_bws)/sizeof(uint16_t)-1 ; i++ )
	{
		if ( bandwidth <= max2830_lpf_bws[i] )
		{
			break;
		}
	}


	// Set LPF coarse -3dB corner frequency (R8[1:0])
	reg_val = Max2830_read_register(8) & ~0x3;
	Max2830_write_register(8, reg_val | (uint16_t)i / 6);

	// Set LPF fine -3dB corner frequency both for RX (R7[2:0]) and TX (R7[5:3])
	reg_val = Max2830_read_register(7) & ~0x3F;
	reg_val |= ( ((uint16_t)i % 6 << 3) | (uint16_t)i % 6 ) & 0x3F;
	Max2830_write_register(7, reg_val);
}



void Max2830_set_mode( Max2830_mode_t mode )
{
	uint8_t shutdown;
	uint8_t rxtx;
	uint8_t calibration;

	uint16_t reg_val;

	switch (mode)
	{
		case MAX2830_SHUTDOWN_MODE :
			shutdown = 0;
			rxtx = 0;
			calibration = 0;
			break;

		case MAX2830_STANDBY_MODE :
			shutdown = 0;
			rxtx = 1;
			calibration = 0;
			break;

		case MAX2830_RX_MODE :
			shutdown = 1;
			rxtx = 0;
			calibration = 0;
			break;

		case MAX2830_TX_MODE :
			shutdown = 1;
			rxtx = 1;
			calibration = 0;
			break;

		case MAX2830_RX_CALIBRATION_MODE :
			shutdown = 1;
			rxtx = 0;
			calibration = 3;
			break;

		case MAX2830_TX_CALIBRATION_MODE :
			shutdown = 1;
			rxtx = 1;
			calibration = 3;
			break;

		default :
			break;
	}

	if ( shutdown == 0 )
	{
		MSS_GPIO_set_outputs( MSS_GPIO_get_outputs() & ~MSS_GPIO_SHDN_MASK );
	}
	else
	{
		MSS_GPIO_set_outputs( MSS_GPIO_get_outputs() | MSS_GPIO_SHDN_MASK );
	}

	if ( rxtx == 0 )
	{
		MSS_GPIO_set_outputs( MSS_GPIO_get_outputs() & ~MSS_GPIO_RXTX_MASK );
	}
	else
	{
		MSS_GPIO_set_outputs( MSS_GPIO_get_outputs() | MSS_GPIO_RXTX_MASK );
	}

	reg_val = Max2830_read_register(6) & ~0x3;
	reg_val |= calibration;

	Max2830_write_register(6, reg_val);
}
