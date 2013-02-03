//-----------------------------------------------------------------------------
// Title         : Max19706 firmware source
// Project       : Marmote SDR
//-----------------------------------------------------------------------------
// File          : max19706.h
// Author        : Sandor Szilvasi
// Company       : Vanderbilt University, ISIS
// Created       : 2013-02-02 18:01
// Last update   : 2013-02-02 18:15
// Platform      : Marmote
// Target device : Actel A2F500M3G
// Tool version  : CoreConsole v3.3
// Standard      : CMSIS
//-----------------------------------------------------------------------------
// Description   : Firmware for the Max19706 AFE chip found on the
//                 Marmote Teton module.
//-----------------------------------------------------------------------------
// Copyright (c) 2006-2013, Vanderbilt University
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
// 2013-02-02      1.0      Sandor Szilvasi	Created
//-----------------------------------------------------------------------------


#include "max19706.h"

void Max19706_init ( Max19706_instance_t AFEx )
{
	mss_spi_slave_t spi_slave;

	if ( AFEx == MAX19706_AFE1 )
	{
		spi_slave = MSS_SPI_SLAVE_1;
	}

	if ( AFEx == MAX19706_AFE2 )
	{
		spi_slave = MSS_SPI_SLAVE_2;
	}

	// Initialize SPI1 peripheral
	MSS_SPI_init( &g_mss_spi1 );
//	MSS_SPI_configure_master_mode(
//			&g_mss_spi1,
//			spi_slave,
//			MSS_SPI_MODE0,
//			MSS_SPI_PCLK_DIV_2, // 20 MHz PCLK1 > 10 MHz SPI clock
//			SPI_FRAME_SIZE_MAX19706
//	);

	// Set common mode
	Max19706_set_dac_cm( AFEx, MAX19706_DAC_CM_1_20V );
}

uint16_t Max19706_read_register( Max19706_instance_t AFEx, uint8_t addr )
{
	// TBD
	return 0;
}

void Max19706_write_register( Max19706_instance_t AFEx, uint8_t addr, uint16_t data )
{
	uint32_t tx_frame;
	mss_spi_slave_t spi_slave;

	if ( addr > 8 )
	{
		return;
	}

	if ( AFEx == MAX19706_AFE1 )
	{
		spi_slave = MSS_SPI_SLAVE_1;
	}

	if ( AFEx == MAX19706_AFE2 )
	{
		spi_slave = MSS_SPI_SLAVE_2;
	}

	tx_frame = addr & 0xF; // bits [3:0] 4 LSB
	tx_frame |= (data & 0xFFF) << 4; // bits [15:4] 16 - 5 MSB

	MSS_SPI_configure_master_mode(
			&g_mss_spi1,
			spi_slave,
			MSS_SPI_MODE0,
			MSS_SPI_PCLK_DIV_2, // 20 MHz PCLK1 > 10 MHz SPI clock
			SPI_FRAME_SIZE_MAX19706
	);

	// Initiate SPI transmission
	MSS_SPI_set_slave_select(
			&g_mss_spi1,
			spi_slave
	);

	MSS_SPI_transfer_frame(
			&g_mss_spi1,
			tx_frame
	);

	MSS_SPI_clear_slave_select(
			&g_mss_spi1,
			spi_slave
	);
}

Max19706_DAC_COMSEL_t Max19706_get_dac_cm( Max19706_instance_t AFEx )
{
	// TBD
	return 0;
}

void Max19706_set_dac_cm( Max19706_instance_t AFEx, Max19706_DAC_COMSEL_t cm )
{
	Max19706_write_register( AFEx, 0x06u, cm );
}

