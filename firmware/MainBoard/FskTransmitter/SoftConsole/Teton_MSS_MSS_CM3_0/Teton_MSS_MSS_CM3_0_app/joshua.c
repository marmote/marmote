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
	// Initialize GPIOs

	// Initialize SPI1
	MSS_SPI_init( &g_mss_spi1 );

	MSS_SPI_configure_master_mode(
			&g_mss_spi1,
			MSS_SPI_SLAVE_0,
			MSS_SPI_MODE0, // TODO: value arbitrarily checked, revise it
			MSS_SPI_PCLK_DIV_2, // 20 MHz PCLK1 > 10 MHz SPI clock
			SPI_FRAME_SIZE_MAX2830
	);

	//MSS_SPI_enable();
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
