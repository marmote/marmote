//-----------------------------------------------------------------------------
// Title         : Power Monitor Functions Header
// Project       : Power Board
//-----------------------------------------------------------------------------
// File          : power_monitor.h
// Author        : Sandor Szilvasi
// Company       : Vanderbilt University, ISIS
// Created       : 2011-11-04 10:40
// Last update   : 2011-11-17 17:45
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
#include "stm32f10x_tim.h"
#include "stm32f10x_adc.h"
#include "stm32f10x_i2c.h"
#include "stm32f10x_spi.h"
#include "misc.h"

					 
// For USB logger demo only - START
#include "usb_lib.h"
#include "usb_desc.h"
#include "stdio.h"
#include "string.h"
//#include "usb_fs.h"
// For USB logger demo only - END


// LEDs

typedef enum 
{
  LED1 = 1,
  LED2 = 2
} Led_TypeDef;

#define LED_LED1_PIN    			GPIO_Pin_15	// PA.15    
#define LED_LED1_GPIO_PORT  		GPIOA		// GPIOA
#define LED_LED1_GPIO_CLK   		RCC_APB2Periph_GPIOA
#define LED_LED2_PIN				GPIO_Pin_2	// PB.2
#define LED_LED2_GPIO_PORT  		GPIOB		// GPIOB
#define LED_LED2_GPIO_CLK   		RCC_APB2Periph_GPIOB


// ADC (ADC1)

#define ADC_CLK        				RCC_APB2Periph_ADC1

typedef enum
{
	ADC_CH_V_SUP 	= ADC_Channel_9,
	ADC_CH_I_SUP 	= ADC_Channel_8,
	ADC_CH_I_D3V3 	= ADC_Channel_0,
	ADC_CH_I_A3V3	= ADC_Channel_3,
	ADC_CH_I_D1V5	= ADC_Channel_1,
	ADC_CH_I_A1V5	= ADC_Channel_2
} ADC_Channel_TypeDef;


/*-------------------------------------------------------------------*/
/*                               Battery                             */
/*-------------------------------------------------------------------*/

// Battery charge pin

#define BAT_CHRG_PIN                GPIO_Pin_9  // PB.9
#define BAT_CHRG_GPIO_PORT          GPIOB       // GPIOB
#define BAT_CHRG_GPIO_CLK           RCC_APB2Periph_GPIOB

#define BAT_AL_PIN                  GPIO_Pin_4  // PB.4
#define BAT_AL_GPIO_PORT            GPIOB       // GPIOB
#define BAT_AL_GPIO_CLK             RCC_APB2Periph_GPIOB

// Battery Gauge I2C (I2C2)

#define BAT_I2C_SCL_PIN             GPIO_Pin_10 // PB.10
#define BAT_I2C_SCL_GPIO_PORT       GPIOB       // GPIOB
#define BAT_I2C_SCL_GPIO_CLK        RCC_APB2Periph_GPIOB

#define BAT_I2C_SDA_PIN             GPIO_Pin_11	// PB.11
#define BAT_I2C_SDA_GPIO_PORT       GPIOB       // GPIOB
#define BAT_I2C_SDA_GPIO_CLK        RCC_APB2Periph_GPIOB

#define BAT_I2C                     I2C2
#define BAT_I2C_CLK                 RCC_APB1Periph_I2C2

#define BAT_I2C_ADDRESS	            (0x64u << 1) // 1100100X

typedef enum _BAT_RegisterAddress_Type
{
    BAT_STATUS                      = 0x00, // R
    BAT_CONTROL                     = 0x01, // R/W
    BAT_ACCUMULATED_CHARGE_MSB      = 0x02, // R/W
    BAT_ACCUMULATED_CHARGE_LSB      = 0x03, // R/W
    BAT_CHARGE_THRESHOLD_HIGH_MSB   = 0x04, // R/W
    BAT_CHARGE_THRESHOLD_HIGH_LSB   = 0x05, // R/W
    BAT_CHARGE_THRESHOLD_LOW_MSB    = 0x06, // R/W
    BAT_CHARGE_THRESHOLD_LOW_LSB    = 0x07, // R/W
    BAT_VOLTAGE_MSB                 = 0x08, // R
    BAT_VOLTAGE_LSB                 = 0x09, // R
    BAT_VOLTAGE_THRESHOLD_HIGH      = 0x0A, // R/W
    BAT_VOLTAGE_THRESHOLD_LOW       = 0x0B, // R/W
    BAT_TEMPERATURE_MSB             = 0x0C, // R
    BAT_TEMPERATURE_LSB             = 0x0D, // R
    BAT_TEMPERATURE_THRESHOLD_HIGH  = 0x0E, // R/W
    BAT_TEMPERATURE_THRESHOLD_LOW   = 0x0F  // R/W
} BAT_RegisterAddress_Type;

#define LOW_BATTERY_THRESHOLD   3400 // mV


// SD card SPI (SPI2)

#define SD_SPI_NSS_PIN               GPIO_Pin_12                    /* PB.12 */
#define SD_SPI_NSS_GPIO_PORT         GPIOB                          /* GPIOB */
#define SD_SPI_NSS_GPIO_CLK          RCC_APB2Periph_GPIOB 

#define SD_SPI_SCK_PIN               GPIO_Pin_13                    /* PB.13 */
#define SD_SPI_SCK_GPIO_PORT         GPIOB                          /* GPIOB */
#define SD_SPI_SCK_GPIO_CLK          RCC_APB2Periph_GPIOB  
#define SD_SPI_SCK_AF                GPIO_AF_SPI2

#define SD_SPI_MISO_PIN              GPIO_Pin_14                    /* PB.14 */
#define SD_SPI_MISO_GPIO_PORT        GPIOB                          /* GPIOB */
#define SD_SPI_MISO_GPIO_CLK         RCC_APB2Periph_GPIOB  

#define SD_SPI_MISO_AF               GPIO_AF_SPI2
#define SD_SPI_MOSI_PIN              GPIO_Pin_15                    /* PB.15 */
#define SD_SPI_MOSI_GPIO_PORT        GPIOB                          /* GPIOB */
#define SD_SPI_MOSI_GPIO_CLK         RCC_APB2Periph_GPIOB  
#define SD_SPI_MOSI_AF               GPIO_AF_SPI2

#define SD_SPI                       SPI2
#define SD_SPI_CLK                   RCC_APB1Periph_SPI2


//__IO uint16_t ADC1ConvertedValue = 0;

void BAT_CHRG_Init(void);
uint8_t BAT_IsCharging(void);

void PowerMonitor_Init(void);
void Logger_Init(void);

void LED_Init(void);
void LED_On (uint32_t led);
void LED_Off (uint32_t led);
void LED_Toggle (uint32_t led);


void ADCM_Init(void); // TODO: rename this function or move to monitor_init

uint16_t MON_ReadAdc(ADC_Channel_TypeDef adc_ch);


static void BAT_I2C_Init(void);

void BAT_WriteRegister(BAT_RegisterAddress_Type addr, uint16_t data);
uint16_t BAT_ReadRegister(BAT_RegisterAddress_Type addr);
uint8_t BAT_AlarmAsserted(void);


/*
uint16_t BAT_ReadVoltage();
uint16_t BAT_ReadTemperature();
uint16_t BAT_ReadAccumulatedCharge();
*/

void SD_SPI_Init(void);
void SD_SPI_SendData(uint16_t data);

#endif // __POWER_MONITOR_H
