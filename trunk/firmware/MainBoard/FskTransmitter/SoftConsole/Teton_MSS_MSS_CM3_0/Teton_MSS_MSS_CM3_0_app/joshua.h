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
#define MSS_GPIO_SHDN       	MSS_GPIO_3		// Shutdown (active-low)
#define MSS_GPIO_RXHP       	MSS_GPIO_4		// Receiver Baseband AC-Coupling High-Pass Corner Frequency
#define MSS_GPIO_ANTSEL     	MSS_GPIO_5		// Antenna Selection
#define MSS_GPIO_RXTX       	MSS_GPIO_28		// Rx/Tx Mode (Rx = 0, Tx = 1)


#define MSS_GPIO_LD_MASK		MSS_GPIO_2_MASK
#define MSS_GPIO_SHDN_MASK      MSS_GPIO_3_MASK
#define MSS_GPIO_RXHP_MASK      MSS_GPIO_4_MASK
#define MSS_GPIO_ANTSEL_MASK    MSS_GPIO_5_MASK
#define MSS_GPIO_RXTX_MASK      MSS_GPIO_28_MASK


/**
 * The number of bits in a MAX2830 SPI transaction.
 */
#define SPI_FRAME_SIZE_MAX2830 18

/**
 * Array representing the 14-bit values of the 16 MAX2830 registers.
 *
 * Note: As MAX2839 does not support register write the value of its
 *       registers is kept in this array as a reference. Register reads
 *       implicitly read values from this array.
 */
static uint16_t max2830_regs[16] =
{
		0x1740,
		0x119A,
		0x1003,
		0x0079,
		0x3666,
		0x00A0,
		0x0060,
		0x1022,
		0x2021,
		0x07B5,
		0x1DA4,
		0x007F,
		0x0140,
		0x0E92,
		0x0300,
		0x0145,
};


/**
 * The Joshua_init() function initializes the Joshua analog front-end module.
 * It initializes the necessary peripherals and uses the input configuration
 * to properly set up the MAX2830 chip through the SPI port. This function also
 * sets the GPIO pin controlling the MAX2830 chip.
 *
 * Note: - The Joshua_init() function assumes that MSS_GPIO_init() has been
 *         called previously.
 *       - Make sure that the GPIO #defines match the Libero design FPGA I/O pins.
 *       - The Joshua board is initialized with minimal transmit gain.
 *
 * @param conf
 *   The conf parameter points to a 16 element array of register address and value
 *   pairs.
 *
 *   Use NULL for the default configuration.
 *
 * @return
 *   This function does not return a value.
 */
void Joshua_init ( const uint16_t* conf );



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
uint32_t Joshua_read_register( uint8_t addr );



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


/**
 * The Joshua_calibrate() function calibrates the [RX/TX?] path. // FIXME
 *
 * Note: Tx calibration involves sine generation in the baseband and this
 *       feature is NOT IMPLMENTED YET.
 *
 * @param
 *   This function does not have a parameter.
 *
 * @return
 *   This function does not return a value.
 */
void Joshua_calibrate( void );

/**
 * The Joshua_get_gain() function reads the actual [TX?] gain and returns it in dB. // FIXME
 *
 * @param
 *   This function does not have a parameter.
 *
 * @return
 *   The [TX?] gain in dB. // FIXME
 */
uint32_t Joshua_get_gain( void );

/**
 * The Joshua_set_gain() function sets the actual [TX?] gain to the dB value given
 * as the parameter. // FIXME
 *
 * @param
 *   The requested [TX?] gain in dB. // FIXME
 *
 * @return
 *   This function does not return a value.
 */
void Joshua_set_gain( uint32_t bandwidth );



/**
 * The Joshua_get_frequency() function reads the local oscillator frequency
 * and returns it in Hz.
 *
 * @param
 *   This function does not have a parameter.
 *
 * @return
 *   The local oscillator frequency in Hz.
 */
uint32_t Joshua_get_frequency( void );

/**
 * The Joshua_set_frequency() function sets the local oscillator frequency to
 * the value specified in the parameter.
 *
 * Note: The frequency step resolution is 20 MHz.
 *
 * @param
 *   The requested local oscillator frequency in Hz.
 *
 * @return
 *   This function does not return a value.
 */
void Joshua_set_frequency( uint32_t bandwidth );



/**
 * The Joshua_get_bandwidth() function reads the baseband
 * filter cut-off frequency and returns it in Hz.
 *
 * @param
 *   This function does not have a parameter.
 *
 * @return
 *   The baseband filter cut-off frequency in Hz.
 */
uint32_t Joshua_get_bandwidth( void );


/**
 * The Joshua_set_bandwidth() function sets the baseband filter cut-off
 * frequency to the value specified in the parameter.
 *
 * Note: The bandwidth of the baseband filter can be set in coarse steps.
 *       Thus, the actually set frequency may differ from the requested.
 *       Use the Josuha_get_bandwidth() function to determine the actual
 *       value set.
 *
 * @param
 *   The requested baseband filter cut-off frequency in Hz.
 *
 * @return
 *   This function does not return a value.
 */
void Joshua_set_bandwidth( uint32_t bandwidth );


#endif /* JOSHUA_H_ */
