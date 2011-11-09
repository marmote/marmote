//-----------------------------------------------------------------------------
// Title         : Power Monitor Functions Header
// Project       : Power Board
//-----------------------------------------------------------------------------
// File          : power_monitor.h
// Author        : Sandor Szilvasi
// Company       : Vanderbilt University, ISIS
// Created       : 2011-11-04 10:40
// Last update   : 2011-11-04 10:40
// Platform      : Marmote
// Target device : STM32F102CB
// Tool version  : ARM uVision 4 (v4.22.22.0)
// Standard      : CMSIS
//-----------------------------------------------------------------------------
// Description   : Header file for monitoring the battery and the power rails.
// That is to communicate with the battery gauge IC and handling the ADCs.
//-----------------------------------------------------------------------------
// Copyright (c) 2006-2011, Vanderbilt University
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
// 2011-11-04      1.0      Sandor Szilvasi	Created
//-----------------------------------------------------------------------------

#ifndef __POWER_MONITOR_H
#define __POWER_MONITOR_H

#include "stm32f10x.h"
#include "stm32f10x_i2c.h"

#include "power_board.h" // FIXME: for LED only - this line should be removed later


// Battery Gauge I2C (I2C2)

#define BAT_I2C_SCL_PIN             GPIO_Pin_10 // PB.10
#define BAT_I2C_SCL_GPIO_PORT       GPIOB       // GPIOB
#define BAT_I2C_SCL_GPIO_CLK        RCC_AHBPeriph_GPIOB

#define BAT_I2C_SDA_PIN             GPIO_Pin_11	// PB.11
#define BAT_I2C_SDA_GPIO_PORT       GPIOB       // GPIOB
#define BAT_I2C_SDA_GPIO_CLK        RCC_AHBPeriph_GPIOB

#define BAT_I2C                     I2C2
#define BAT_I2C_CLK                 RCC_APB1Periph_I2C2

#define BAT_I2C_ADDRESS				(0x64U << 1) // 1100100X
//#define BAT_I2C_ADDRESS				(0x65U << 1) // 1100101X (for testing NACK only)

typedef enum BAT_RegisterAddress_Type
{
	STATUS 						= 0x00, // R
	CONTROL 					= 0x01, // R/W
	ACCUMULATED_CHARGE_MSB 		= 0x02, // R/W
	ACCUMULATED_CHARGE_LSB 		= 0x03, // R/W
	CHARGE_THRESHOLD_HIGH_MSB 	= 0x04, // R/W
	CHARGE_THRESHOLD_HIGH_LSB 	= 0x05, // R/W
	CHARGE_THRESHOLD_LOW_MSB 	= 0x06, // R/W
	CHARGE_THRESHOLD_LOW_LSB 	= 0x07, // R/W
	VOLTAGE_MSB 				= 0x08, // R
	VOLTAGE_LSB 				= 0x09, // R
	VOLTAGE_THRESHOLD_HIGH 		= 0x0A, // R/W
	VOLTAGE_THRESHOLD_LOW 		= 0x0B, // R/W
	TEMPERATURE_MSB 			= 0x0C, // R
	TEMPERATURE_LSB 			= 0x0D, // R
	TEMPERATURE_THRESHOLD_HIGH 	= 0x0E, // R/W
	TEMPERATURE_THRESHOLD_LOW 	= 0x0F  // R/W
} BAT_RegisterAddress_Type;

void BAT_I2C_Init(void);
void BAT_WriteRegister(uint8_t address, uint8_t data);
uint8_t BAT_ReadRegister(uint8_t address);


// SD card SPI (SPI2)

#define SD_SPI_NSS_PIN               GPIO_Pin_12                    /* PB.12  */
#define SD_SPI_NSS_GPIO_PORT         GPIOB                          /* GPIOB */
#define SD_SPI_NSS_GPIO_CLK          RCC_AHBPeriph_GPIOB 

#define SD_SPI_SCK_PIN               GPIO_Pin_13                    /* PB.13  */
#define SD_SPI_SCK_GPIO_PORT         GPIOB                          /* GPIOB */
#define SD_SPI_SCK_GPIO_CLK          RCC_AHBPeriph_GPIOB  
//#define SD_SPI_SCK_SOURCE            GPIO_PinSource13
#define SD_SPI_SCK_AF                GPIO_AF_SPI2
#define SD_SPI_MISO_PIN              GPIO_Pin_14                    /* PB.14 */
#define SD_SPI_MISO_GPIO_PORT        GPIOB                          /* GPIOB */
#define SD_SPI_MISO_GPIO_CLK         RCC_AHBPeriph_GPIOB  
//#define SD_SPI_MISO_SOURCE           GPIO_PinSource14
#define SD_SPI_MISO_AF               GPIO_AF_SPI2
#define SD_SPI_MOSI_PIN              GPIO_Pin_15                    /* PB.15  */
#define SD_SPI_MOSI_GPIO_PORT        GPIOB                          /* GPIOB */
#define SD_SPI_MOSI_GPIO_CLK         RCC_AHBPeriph_GPIOB  
//#define SD_SPI_MOSI_SOURCE           GPIO_PinSource15
#define SD_SPI_MOSI_AF               GPIO_AF_SPI2
#define SD_SPI                       SPI2
#define SD_SPI_CLK                   RCC_APB1Periph_SPI2

void SD_SPI_Init(void);
void SD_SPI_SendData(uint16_t data);

#endif // __POWER_MONITOR_H
