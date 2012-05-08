//-----------------------------------------------------------------------------
// Title         : Power Board Header
// Project       : Marmote Power Supply Board
//-----------------------------------------------------------------------------
// File          : power_board.h
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
// 2011-11-02      1.0      Sandor Szilvasi	Created
//-----------------------------------------------------------------------------

#ifndef __POWER_BOARD_H
#define __POWER_BOARD_H

#include "stm32f10x.h"
#include "power_control.h"
#include "power_monitor.h"

//uint16_t Stream_Buf[48];

//extern uint8_t LED1_Enabled; // Power supply TEST ONLY
static uint8_t LED1_Enabled; // Power supply TEST ONLY

// Board - Initialize board peripherals and GPIOs with default values
void Board_Init(void); // 


// Timer

void Init_Timer(void);
void Delay(uint32_t dlyTicks);

//----------------------------- REV B -------------------------------

#ifndef REV_A

// SmartFusion connector

typedef enum _CON_GPIO_TypeDef
{
    CON_GPIO0 = 1,
    CON_GPIO1 = 2,
    CON_GPIO2 = 4,
    CON_GPIO3 = 8,
    CON_GPIO4 = 16
} CON_GPIO_TypeDef;


// * means limited IO capabilities

#define CON_GPIO0_PIN    		GPIO_Pin_14 // PC.14* - CON PIN17
#define CON_GPIO0_GPIO_PORT    	GPIOC
#define CON_GPIO0_GPIO_CLK    	RCC_APB2Periph_GPIOC

#define CON_GPIO1_PIN    		GPIO_Pin_15 // PC.15* - CON PIN19
#define CON_GPIO1_GPIO_PORT    	GPIOC
#define CON_GPIO1_GPIO_CLK    	RCC_APB2Periph_GPIOC

#define CON_GPIO2_PIN    		GPIO_Pin_10 // PA.10 - CON PIN21
#define CON_GPIO2_GPIO_PORT    	GPIOA
#define CON_GPIO2_GPIO_CLK    	RCC_APB2Periph_GPIOA

#define CON_GPIO3_PIN    		GPIO_Pin_9	// PA.9 - CON PIN23
#define CON_GPIO3_GPIO_PORT    	GPIOA
#define CON_GPIO3_GPIO_CLK    	RCC_APB2Periph_GPIOA

#define CON_GPIO4_PIN    		GPIO_Pin_5	// PB.5 - CON PIN25
#define CON_GPIO4_GPIO_PORT    	GPIOB
#define CON_GPIO4_GPIO_CLK    	RCC_APB2Periph_GPIOB

void CON_GPIO_Init(void);
void CON_GPIO_Set(uint32_t gpio);
void CON_GPIO_Clear(uint32_t gpio);


// SmartFusion connector SPI

#define CON_SPI_NSS_PIN               GPIO_Pin_4                     // PA.4 - CON PIN24
#define CON_SPI_NSS_GPIO_PORT         GPIOA                          // GPIOA
#define CON_SPI_NSS_GPIO_CLK          RCC_APB2Periph_GPIOA 

#define CON_SPI_SCK_PIN               GPIO_Pin_5                     // PA.5 - CON PIN18
#define CON_SPI_SCK_GPIO_PORT         GPIOA                          // GPIOA
#define CON_SPI_SCK_GPIO_CLK          RCC_APB2Periph_GPIOA  

#define CON_SPI_SCK_AF                GPIO_AF_SPI1
#define CON_SPI_MISO_PIN              GPIO_Pin_6                     // PA.6 - CON PIN20
#define CON_SPI_MISO_GPIO_PORT        GPIOA                          // GPIOA
#define CON_SPI_MISO_GPIO_CLK         RCC_APB2Periph_GPIOA  

#define CON_SPI_MISO_AF               GPIO_AF_SPI1
#define CON_SPI_MOSI_PIN              GPIO_Pin_7                     // PA.7 - CON PIN22
#define CON_SPI_MOSI_GPIO_PORT        GPIOA                          // GPIOA
#define CON_SPI_MOSI_GPIO_CLK         RCC_APB2Periph_GPIOA  

#define CON_SPI_MOSI_AF               GPIO_AF_SPI1
#define CON_SPI                       SPI1
#define CON_SPI_CLK                   RCC_APB2Periph_SPI1

void CON_SPI_Init(void);
void CON_SPI_SendData(uint16_t data);


// SmartFusion connector I2C

#define CON_I2C_SCL_PIN             GPIO_Pin_6  // PB.6 - CON PIN26
#define CON_I2C_SCL_GPIO_PORT       GPIOB       // GPIOB
#define CON_I2C_SCL_GPIO_CLK        RCC_APB2Periph_GPIOB

#define CON_I2C_SDA_PIN             GPIO_Pin_7  // PB.7 - CON PIN28
#define CON_I2C_SDA_GPIO_PORT       GPIOB       // GPIOB
#define CON_I2C_SDA_GPIO_CLK        RCC_APB2Periph_GPIOB

#define CON_I2C                     I2C1
#define CON_I2C_CLK                 RCC_APB1Periph_I2C1

void CON_I2C_Init(void);
void CON_I2C_SendData(uint8_t address, uint8_t data);

//--------------------------- REV A END -----------------------------




//----------------------------- REV A -------------------------------

#else // REV_A


// SmartFusion connector

typedef enum _CON_GPIO_TypeDef
{
    CON_GPIO0 = 1,
    CON_GPIO1 = 2,
    CON_GPIO2 = 4,
    CON_GPIO3 = 8,
    CON_GPIO4 = 16
} CON_GPIO_TypeDef;

// * means limited IO capabilities
#define CON_GPIO0_PIN    		GPIO_Pin_14 // PC.14* - CON PIN30
#define CON_GPIO0_GPIO_PORT    	GPIOC
#define CON_GPIO0_GPIO_CLK    	RCC_APB2Periph_GPIOC

#define CON_GPIO1_PIN    		GPIO_Pin_15 // PC.15* - CON PIN32
#define CON_GPIO1_GPIO_PORT    	GPIOC
#define CON_GPIO1_GPIO_CLK    	RCC_APB2Periph_GPIOC

#define CON_GPIO2_PIN    		GPIO_Pin_9	// PA.9 - CON PIN34
#define CON_GPIO2_GPIO_PORT    	GPIOA
#define CON_GPIO2_GPIO_CLK    	RCC_APB2Periph_GPIOA

#define CON_GPIO3_PIN    		GPIO_Pin_10 // PA.10 - CON PIN36
#define CON_GPIO3_GPIO_PORT    	GPIOA
#define CON_GPIO3_GPIO_CLK    	RCC_APB2Periph_GPIOA

#define CON_GPIO4_PIN    		GPIO_Pin_4	// PB.4 - CON PIN38
#define CON_GPIO4_GPIO_PORT    	GPIOB
#define CON_GPIO4_GPIO_CLK    	RCC_APB2Periph_GPIOB

void CON_GPIO_Init(void);
void CON_GPIO_Set(uint32_t gpio);
void CON_GPIO_Clear(uint32_t gpio);


// SmartFusion connector SPI


//#define CON_SPI_NSS_PIN               GPIO_Pin_4                     /* PA.4  */
//#define CON_SPI_NSS_GPIO_PORT         GPIOA                          /* GPIOA */
//#define CON_SPI_NSS_GPIO_CLK          RCC_APB2Periph_GPIOA 
//
//#define CON_SPI_SCK_PIN               GPIO_Pin_5                     /* PA.5  */
//#define CON_SPI_SCK_GPIO_PORT         GPIOA                          /* GPIOA */
//#define CON_SPI_SCK_GPIO_CLK          RCC_APB2Periph_GPIOA  
//
//#define CON_SPI_SCK_AF                GPIO_AF_SPI1
//#define CON_SPI_MISO_PIN              GPIO_Pin_6                     /* PA.6 */
//#define CON_SPI_MISO_GPIO_PORT        GPIOA                          /* GPIOA */
//#define CON_SPI_MISO_GPIO_CLK         RCC_APB2Periph_GPIOA  
//
//#define CON_SPI_MISO_AF               GPIO_AF_SPI1
//#define CON_SPI_MOSI_PIN              GPIO_Pin_7                     /* PA.7  */
//#define CON_SPI_MOSI_GPIO_PORT        GPIOA                          /* GPIOA */
//#define CON_SPI_MOSI_GPIO_CLK         RCC_APB2Periph_GPIOA  
//
//#define CON_SPI_MOSI_AF               GPIO_AF_SPI1
//#define CON_SPI                       SPI1
//#define CON_SPI_CLK                   RCC_APB2Periph_SPI1
//
//void CON_SPI_Init(void);
//void CON_SPI_SendData(uint16_t data);


// SmartFusion connector I2C

#define CON_I2C_SCL_PIN             GPIO_Pin_6  // PB.6
#define CON_I2C_SCL_GPIO_PORT       GPIOB       // GPIOB
#define CON_I2C_SCL_GPIO_CLK        RCC_APB2Periph_GPIOB

#define CON_I2C_SDA_PIN             GPIO_Pin_7  // PB.7
#define CON_I2C_SDA_GPIO_PORT       GPIOB       // GPIOB
#define CON_I2C_SDA_GPIO_CLK        RCC_APB2Periph_GPIOB

#define CON_I2C                     I2C1
#define CON_I2C_CLK                 RCC_APB1Periph_I2C1

void CON_I2C_Init(void);
void CON_I2C_SendData(uint8_t address, uint8_t data);

#endif // REV_A

#endif // __POWER_BOARD_H



