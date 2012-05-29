//-----------------------------------------------------------------------------
// Title         : Teton board source
// Project       : Marmote Teton (Main Board)
//-----------------------------------------------------------------------------
// File          : joshua.h
// Author        : Sandor Szilvasi
// Company       : Vanderbilt University, ISIS
// Created       : 2011-11-02 20:13
// Last update   : 2011-11-02 20:15
// Platform      : Marmote
// Target device : Actel A2F500M3G
// Tool version  : CoreConsole v3.3
// Standard      : CMSIS
//-----------------------------------------------------------------------------
// Description   : <+description+>
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
// 2012-05-23      1.0      Sandor Szilvasi	Created
//-----------------------------------------------------------------------------

#include "joshua.h"

void Joshua_init ( const joshua_reg_t* conf	)
{
	// Initialize SPI1
	MSS_SPI_init( &g_mss_spi1 );
	MSS_SPI_configure_master_mode(
			&g_mss_spi1,
			MSS_SPI_SLAVE_0,
			MSS_SPI_MODE0, // TODO: value arbitrarily checked, revise it
			MSS_SPI_PCLK_DIV_2, // 20 MHz PCLK1 > 10 MHz SPI clock
			SPI_FRAME_SIZE_MAX2830
	);

	// TODO: Initialize the MAX2830 with min TX power to avoid glitches in the supply on power up

	// Configure MAX2830
	Joshua_write_register(0, MAX2830_REG0);
	Joshua_write_register(1, MAX2830_REG1);
	Joshua_write_register(2, MAX2830_REG2);
	Joshua_write_register(3, MAX2830_REG3);
	Joshua_write_register(4, MAX2830_REG4);
	Joshua_write_register(5, MAX2830_REG5);
	Joshua_write_register(6, MAX2830_REG6);
	Joshua_write_register(7, MAX2830_REG7);
	Joshua_write_register(8, MAX2830_REG8);
	Joshua_write_register(9, MAX2830_REG9);
	Joshua_write_register(10, MAX2830_REG10);
	Joshua_write_register(11, MAX2830_REG11);
	Joshua_write_register(12, MAX2830_REG12);
	Joshua_write_register(13, MAX2830_REG13);
	Joshua_write_register(14, MAX2830_REG14);
	Joshua_write_register(15, MAX2830_REG15);

	// Initialize GPIOs
	//MSS_GPIO_init();
	MSS_GPIO_config( MSS_GPIO_LD, MSS_GPIO_INPUT_MODE );
	MSS_GPIO_config( MSS_GPIO_SHDN, MSS_GPIO_OUTPUT_MODE );
	MSS_GPIO_config( MSS_GPIO_RXHP, MSS_GPIO_OUTPUT_MODE );
	MSS_GPIO_config( MSS_GPIO_ANTSEL, MSS_GPIO_OUTPUT_MODE );
	MSS_GPIO_config( MSS_GPIO_RXTX, MSS_GPIO_OUTPUT_MODE );

	MSS_GPIO_set_outputs( MSS_GPIO_get_outputs() | MSS_GPIO_SHDN_MASK );	// NO shutdown
	MSS_GPIO_set_outputs( MSS_GPIO_get_outputs() | MSS_GPIO_RXHP_MASK );	// N/A (since TX)
	MSS_GPIO_set_outputs( MSS_GPIO_get_outputs() | MSS_GPIO_ANTSEL_MASK );	// N/A (see RXTX)
	MSS_GPIO_set_outputs( MSS_GPIO_get_outputs() | MSS_GPIO_RXTX_MASK );	// TX

	Joshua_set_frequency(2500000);
	//Joshua_set_gain()
}

/*
uint32_t Joshua_read_register(uint8_t addr)
{
	uint32_t data;

	MSS_SPI_set_slave_select(
			&g_mss_spi1,
			MSS_SPI_SLAVE_0
	);

	MSS_SPI_clear_slave_select(
			&g_mss_spi1,
			MSS_SPI_SLAVE_0
	);

	return data;
}
*/

uint32_t Joshua_write_register(uint8_t addr, uint32_t data)
{
	//uint32_t rx_frame = 0;

	uint32_t tx_frame;

	tx_frame = addr & 0xF; // bytes [3:0] 4 LSB
	tx_frame |= (data & 0x3FFF) << 4; // bytes [18:4] 18 - 5 MSB

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

	return 0;
}

void Joshua_set_frequency( uint32_t f )
{
	// See Max2830 documentation page 24 for calculation

	uint32_t	f_LO = 20e6; // Frequency of the TCXO on the RF board
	uint8_t		RefFreqDivider = 1; // Either 1 or 2

	uint32_t	f_Comp;
	uint8_t		IntegerDivider; // 64<=  <=255
	uint32_t	FractionalDivider;

	f *= 1000; // kHz to Hz conversion

	f_Comp = f_LO / RefFreqDivider;

	IntegerDivider = (uint8_t) (f / f_Comp);
	if (IntegerDivider < 64)
		IntegerDivider = 64;

	FractionalDivider = (uint32_t) (((uint64_t) (f % f_Comp)) * 1048575 / f_Comp);

	//TODO Do we really have to set these every time?
	//Set_Fractional_N_PLL_Mode_Enable(1);			//Set 1 to enable the fractional-N PLL or set 0 to enable the integer-N PLL.
	//Set_Reference_Frequency_Divider_Ratio(0);		//Set to 0 to divide by 1. Set to 1 to divide by 2.

	//Actual frequency setup
	//	8-Bit Integer Portion of Main Divider. Programmable from 64 to 255.

	//	6 LSBs of 20-Bit Fractional Portion of Main Divider
	//	14 MSBs of 20-Bit Fractional Portion of Main Divider

	if (IntegerDivider < 64)
	{
		IntegerDivider = 64;
	}

	FractionalDivider = FractionalDivider & 0xFFFFF;

	Joshua_write_register(0x3, IntegerDivider | ((FractionalDivider & 0x3F) << 8));
	Joshua_write_register(0x4, (FractionalDivider >> 6));
}

