//-----------------------------------------------------------------------------
// Title         : Teton board header
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

#ifndef JOSHUA_H_
#define JOSHUA_H_


#include <a2fxxxm3.h>
#include <mss_gpio.h>
#include <mss_spi.h>

// TODO: Add GPIO pin definitions


//static const uint8_t SPI_FRAME_SIZE_MAX2830 = 18;
#define SPI_FRAME_SIZE_MAX2830 18

typedef struct joshua_reg
{
	uint8_t addr;
	uint8_t data;
} joshua_reg_t;

/*
joshua_reg_t default_conf[] =
{
		{255, 0}
};
*/


/**
 * The Joshua_init() function initializes the Joshua analog front-end module.
 * It initializes the necessary peripherals and uses the input configuration
 * to properly set up the MAX2830 chip through the SPI port. This function also
 * sets the GPIO pin controlling the MAX2830 chip.
 *
 * @param conf
 *   The conf parameter contains an array of register address and value
 *   pairs.
 *
 * @return
 *   This function does not return a value.
 */
void Joshua_init ( const joshua_reg_t* conf );



/**
 * The Joshua_read_register() function reads a MAX2830 register through the SPI
 * port.
 *
 * @param addr
 *   The address of the MAX2830 register. The valid address range is from 0 to 15.
 *
 * @return
 *   This function returns the value of the MAX2830 register at the address
 *   defined by the parameter addr.
 */
//uint32_t Joshua_read_register( uint8_t addr );



/**
 * The Joshua_read_register() function writes a MAX2830 register through the SPI
 * port. The register at the same address is also read back after the write operation.
 *
 * @param addr
 *   The address of the MAX2830 register. The valid address range is from 0 to 15.
 *
 * @param data
 *   The value to write to the MAX2830 register at address defined by addr.
 *
 * @return
 *   This function returns the value of the MAX2830 register at the address
 *   defined by the parameter addr. This value is read back after the write operation.
 */
uint32_t Joshua_write_register( uint8_t addr, uint32_t data );



#endif /* JOSHUA_H_ */
