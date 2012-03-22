//-----------------------------------------------------------------------------
// Title         : M6-RF315 board header
// Project       : Marmote Power Supply Board
//-----------------------------------------------------------------------------
// File          : m6_rf315.h
// Author        : Sandor Szilvasi
// Company       : Vanderbilt University, ISIS
// Created       : 2011-11-02 20:13
// Last update   : 2011-11-02 20:15
// Platform      : Marmote
// Target device : STM32F102CB
// Tool version  : ARM uVision 4 (v4.22.22.0)
// Standard      : CMSIS
//-----------------------------------------------------------------------------
// Description   : <+description+>
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
// 2012-02-24      1.0      Sandor Szilvasi	Created
//-----------------------------------------------------------------------------

#ifndef __M6_RF315_H
#define __M6_RF315_H

#include "stm32f10x.h"
#include "power_control.h"
#include "power_monitor.h"

// Global variables
static uint8_t status;


// Board - Initialize board peripherals and GPIOs with default values
void M6RF315_Init(void); // 


// LEDs
typedef enum 
{
  CON_LED_RX = 1,
  CON_LED_TX = 2
} CON_Led_TypeDef;

#define CON_LED_RX                  GPIO_Pin_6  // PB.6 - CON PIN14 (GREEN)
#define CON_LED_RX_GPIO_PORT        GPIOB       // GPIOB
#define CON_LED_RX_GPIO_CLK         RCC_APB2Periph_GPIOB

#define CON_LED_TX                  GPIO_Pin_7  // PB.7 - CON PIN16 (ORANGE)
#define CON_LED_TX_GPIO_PORT        GPIOB       // GPIOB
#define CON_LED_TX_GPIO_CLK         RCC_APB2Periph_GPIOB

void CON_LED_Init(void);
uint8_t CON_RX_LED_On(void);
uint8_t CON_RX_LED_Off(void);
uint8_t CON_RX_LED_Toggle(void);
uint8_t CON_TX_LED_On(void);
uint8_t CON_TX_LED_Off(void);
uint8_t CON_TX_LED_Toggle(void);


// CC1101 serial TX and RX data lines
#define CON_TXD_PIN    		    	GPIO_Pin_10 // PA.10 - CON PIN36
#define CON_TXD_GPIO_PORT    		GPIOA
#define CON_TXD_GPIO_CLK    		RCC_APB2Periph_GPIOA

#define CON_RXD_PIN    		    	GPIO_Pin_4	// PB.4 - CON PIN38
#define CON_RXD_GPIO_PORT    		GPIOB
#define CON_RXD_GPIO_CLK    		RCC_APB2Periph_GPIOB

void CON_TXRX_Init(void);
uint8_t CON_TXD_Set(void);
uint8_t CON_TXD_Clear(void);
uint8_t CON_RXD_Get(void);


// CC1101 SPI connection

#define CON_SPI_NSS_PIN               GPIO_Pin_4                     /* PA.4  */
#define CON_SPI_NSS_GPIO_PORT         GPIOA                          /* GPIOA */
#define CON_SPI_NSS_GPIO_CLK          RCC_APB2Periph_GPIOA 

#define CON_SPI_SCK_PIN               GPIO_Pin_5                     /* PA.5  */
#define CON_SPI_SCK_GPIO_PORT         GPIOA                          /* GPIOA */
#define CON_SPI_SCK_GPIO_CLK          RCC_APB2Periph_GPIOA  
#define CON_SPI_SCK_AF                GPIO_AF_SPI1

#define CON_SPI_MISO_PIN              GPIO_Pin_6                     /* PA.6 */
#define CON_SPI_MISO_GPIO_PORT        GPIOA                          /* GPIOA */
#define CON_SPI_MISO_GPIO_CLK         RCC_APB2Periph_GPIOA  
#define CON_SPI_MISO_AF               GPIO_AF_SPI1

#define CON_SPI_MOSI_PIN              GPIO_Pin_7                     /* PA.7  */
#define CON_SPI_MOSI_GPIO_PORT        GPIOA                          /* GPIOA */
#define CON_SPI_MOSI_GPIO_CLK         RCC_APB2Periph_GPIOA  
#define CON_SPI_MOSI_AF               GPIO_AF_SPI1

#define CON_SPI                       SPI1
#define CON_SPI_CLK                   RCC_APB2Periph_SPI1

void CON_SPI_Init(void);
void CON_SPI_WriteRegister(uint8_t addr, uint8_t data);
uint8_t CON_SPI_ReadRegister(uint8_t addr);
uint8_t CON_SPI_TestWrite(void);
uint8_t CON_SPI_TestRead(void);

#endif // __M6_RF315_H




