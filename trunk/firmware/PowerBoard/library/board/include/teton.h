//-----------------------------------------------------------------------------
// Title         : Teton (Main) board header
// Project       : Marmote Yellowstone (Power Supply) Board Firmware
//-----------------------------------------------------------------------------
// File          : teton.h
// Author        : Sandor Szilvasi
// Company       : Vanderbilt University, ISIS
// Created       : 2012-07-30
// Last update   : 2012-07-30 14:00
// Platform      : Marmote
// Target device : STM32F102CB
// Tool version  : ARM uVision 4 (v4.22.22.0)
// Standard      : CMSIS
//-----------------------------------------------------------------------------
// Description   : Header file for the Marmote Teton (Main) board with GPIO
//                 pin definitions and SPI interface.
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
// 2012-07-30      1.0      Sandor Szilvasi	Created
//-----------------------------------------------------------------------------

#ifndef __TETON_H
#define __TETON_H

#include "stm32f10x.h"
#include "misc.h"
#include "stm32f10x_spi.h"
#include "usb_fs.h"


/*
 * Initialize SPI peripheral and GPIO pins with default values
 */
void Teton_Init(void);

// GPIOs
#define CON_SGPIO2_PIN              GPIO_Pin_14 // PC.14 - CON PIN 17
#define CON_SGPIO2_GPIO_PORT        GPIOC       // GPIOC
#define CON_SGPIO2_GPIO_CLK         RCC_APB2Periph_GPIOC

#define CON_SGPIO3_PIN              GPIO_Pin_15 // PC.15 - CON PIN 19
#define CON_SGPIO3_GPIO_PORT        GPIOC       // GPIOC
#define CON_SGPIO3_GPIO_CLK         RCC_APB2Periph_GPIOC

// UART (not used; configured as GPIO input)
#define CON_SGPIO4_PIN              GPIO_Pin_10 // PA.10 - CON PIN 21 (UART_RX)
#define CON_SGPIO4_GPIO_PORT        GPIOA       // GPIOA
#define CON_SGPIO4_GPIO_CLK         RCC_APB2Periph_GPIOA

#define CON_SGPIO5_PIN              GPIO_Pin_9  // PA.9  - CON PIN 23 (UART_TX)
#define CON_SGPIO5_GPIO_PORT        GPIOA       // GPIOA
#define CON_SGPIO5_GPIO_CLK         RCC_APB2Periph_GPIOA

// I2C (not implemented yet; configured as GPIO input)
#define CON_ALERT_PIN               GPIO_Pin_5  // PB.5  - CON PIN 25
#define CON_ALERT_GPIO_PORT         GPIOB       // GPIOB
#define CON_ALERT_GPIO_CLK          RCC_APB2Periph_GPIOB

#define CON_I2C_SCL_PIN             GPIO_Pin_6  // PB.6  - CON PIN 26
#define CON_I2C_SCL_GPIO_PORT       GPIOB       // GPIOB
#define CON_I2C_SCL_GPIO_CLK        RCC_APB2Periph_GPIOB

#define CON_I2C_SDA_PIN             GPIO_Pin_7  // PB.7  - CON PIN 28
#define CON_I2C_SDA_GPIO_PORT       GPIOB       // GPIOB
#define CON_I2C_SDA_GPIO_CLK        RCC_APB2Periph_GPIOB

// SPI
#define CON_SPI_NSS_PIN             GPIO_Pin_4  // PA.4  - CON PIN 24
#define CON_SPI_NSS_GPIO_PORT       GPIOA       // GPIOA
#define CON_SPI_NSS_GPIO_CLK        RCC_APB2Periph_GPIOA 

#define CON_SPI_SCK_PIN             GPIO_Pin_5  // PA.5  - CON PIN 18
#define CON_SPI_SCK_GPIO_PORT       GPIOA       // GPIOA
#define CON_SPI_SCK_GPIO_CLK        RCC_APB2Periph_GPIOA  
#define CON_SPI_SCK_AF              GPIO_AF_SPI1

#define CON_SPI_MISO_PIN            GPIO_Pin_6  // PA.6  - CON PIN 22
#define CON_SPI_MISO_GPIO_PORT      GPIOA       // GPIOA
#define CON_SPI_MISO_GPIO_CLK       RCC_APB2Periph_GPIOA  
#define CON_SPI_MISO_AF             GPIO_AF_SPI1

#define CON_SPI_MOSI_PIN            GPIO_Pin_7  // PA.7  - CON PIN 20
#define CON_SPI_MOSI_GPIO_PORT      GPIOA       // GPIOA
#define CON_SPI_MOSI_GPIO_CLK       RCC_APB2Periph_GPIOA  
#define CON_SPI_MOSI_AF             GPIO_AF_SPI1

#define CON_SPI                     SPI1
#define CON_SPI_CLK                 RCC_APB2Periph_SPI1
#define CON_SPI_IRQn		        SPI1_IRQn

void CON_GPIO_Init(void);
void CON_SPI_Init(void);
void CON_SPI_Write(const uint8_t* data, uint8_t len);
void CON_SPI_WriteRegister(uint8_t addr, uint8_t data);
uint8_t CON_SPI_ReadRegister(uint8_t addr);

#endif // __TETON_H




