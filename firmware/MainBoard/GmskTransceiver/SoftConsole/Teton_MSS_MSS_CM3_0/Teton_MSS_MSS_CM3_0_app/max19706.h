//-----------------------------------------------------------------------------
// Title         : Max19706 firmware header
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


#ifndef MAX19706_H_
#define MAX19706_H_


#include <mss_gpio.h>
#include <mss_spi.h>

//#define MSS_GPIO_SPI1_SS_AFE1  	MSS_GPIO_x		// AFE1 slave select
//#define MSS_GPIO_SPI1_SS_AFE2  	MSS_GPIO_x		// AFE2 slave select
//
//#define MSS_GPIO_SPI1_SS_AFE1_MASK	MSS_GPIO_x_MASK
#define MSS_GPIO_SPI1_SS_AFE2_MASK	MSS_GPIO_x_MASK


/**
 * The possible common mode values in the MAX19706.
 */
typedef enum __Max19706_DAC_COMSEL_t
{
	MAX19706_DAC_CM_1_35V	= 0,
	MAX19706_DAC_CM_1_20V	= 1,
	MAX19706_DAC_CM_1_05V	= 2,
	MAX19706_DAC_CM_0_90V	= 3,
} Max19706_DAC_COMSEL_t;

/**
 * The number of bits in a MAX19706 SPI transaction.
 */
#define SPI_FRAME_SIZE_MAX19706 16

typedef enum __Max19706_instance_t
{
	MAX19706_AFE1,
	MAX19706_AFE2
} Max19706_instance_t;


/**
 * Array representing the 16-bit values of the nine MAX19706 registers.
 */
//static uint16_t max19706_regs[9] =
//{
//		MAX19706_DAC_CM_1_20V
//};




/**
 * The Max19706_init() function initializes the Max19706 analog front-end chip.
 * It sets the common mode voltage to the defaule value (TBD).
 *
 * Note: - The Max19706_init() function assumes that MSS_GPIO_init() has been
 *         called previously.
 *       - Make sure that the GPIO #defines match the Libero design FPGA I/O pins.
 *       - The common mode is initialized to (TBD).
 *
 * @param
 *   This function does not have a parameter.
 *
 * @return
 *   This function does not return a value.
 */
void Max19706_init ( Max19706_instance_t AFEx );




/**
 * The Max19706_read_register() function returns the actual content of a Max19706 register.
 *
 * @param addr
 *   The address of the Max19706 register. The valid address range is from 0 to 8.
 *
 * @return
 *   This function returns the value of the Max19706 register at the address
 *   defined by the parameter addr.
 */
uint16_t Max19706_read_register( Max19706_instance_t AFEx, uint8_t addr );



/**
 * The Max19706_write_register() function writes a Max19706 register through the SPI
 * port and updates the local copy of the register value.
 *
 * @param addr
 *   The address of the Max19706 register. The valid address range is from 0 to 8.
 *
 * @param data
 *   The value to write to the Max19706 register at address defined by addr.
 *
 * @return
 *   This function does not return a value.
 */
void Max19706_write_register( Max19706_instance_t AFEx, uint8_t addr, uint16_t data );



/**
 * The Max19706_get_dac_cm() function reads the common mode value
 * and returns it in mV.
 *
 * @param AFEx
 *   The AFE instance to get the DAC CM value from.
 *
 * @return
 *   The common mode value in mV.
 */
Max19706_DAC_COMSEL_t Max19706_get_dac_cm( Max19706_instance_t AFEx );

/**
 * The Max19706_set_frequency() function sets the common mode value specified
 * in the parameter.
 *
 * @param freq
 *   The requested local oscillator frequency in Hz.
 *
 * @return
 *   This function does not return a value.
 */
void Max19706_set_dac_cm( Max19706_instance_t AFEx, Max19706_DAC_COMSEL_t cm );



#endif /* MAX19706_H_ */
