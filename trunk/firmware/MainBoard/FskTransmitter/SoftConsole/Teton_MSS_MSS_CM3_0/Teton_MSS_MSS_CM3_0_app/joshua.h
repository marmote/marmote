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



#define MSS_GPIO_LD         	MSS_GPIO_2		// Lock-Detect
#define MSS_GPIO_SHDN       	MSS_GPIO_3		// Shutdown
#define MSS_GPIO_RXHP       	MSS_GPIO_4		// Receiver Baseband AC-Coupling High-Pass Corner Frequency
#define MSS_GPIO_ANTSEL     	MSS_GPIO_5		// Antenna Selection
#define MSS_GPIO_RXTX       	MSS_GPIO_28		// Rx/Tx Mode (Rx = 0, Tx = 1)


#define MSS_GPIO_LD_MASK		MSS_GPIO_2_MASK
#define MSS_GPIO_SHDN_MASK      MSS_GPIO_3_MASK
#define MSS_GPIO_RXHP_MASK      MSS_GPIO_4_MASK
#define MSS_GPIO_ANTSEL_MASK    MSS_GPIO_5_MASK
#define MSS_GPIO_RXTX_MASK      MSS_GPIO_28_MASK


//According to the recommended values in the table above
#define MAX2830_REG0	0x00001740
#define MAX2830_REG1	0x0000119A
#define MAX2830_REG2	0x00001003
#define MAX2830_REG3	0x00000079
#define MAX2830_REG4	0x00003666
#define MAX2830_REG5	0x000000A0
#define MAX2830_REG6	0x00000060
#define MAX2830_REG7	0x00001022
#define MAX2830_REG8	0x00002021
#define MAX2830_REG9	0x000007B5
#define MAX2830_REG10	0x00001DA4
#define MAX2830_REG11	0x0000007F
#define MAX2830_REG12	0x00000140
//#define MAX2830_REG12	0x0000017F
#define MAX2830_REG13	0x00000E92
#define MAX2830_REG14	0x00000300
#define MAX2830_REG15	0x00000145


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


void Joshua_set_frequency( uint32_t freq );



#endif /* JOSHUA_H_ */
