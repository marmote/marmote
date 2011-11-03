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

// Board - Initialize board peripherals and GPIOs with default values
void Board_Init(void); // 


// LEDs

typedef enum 
{
  LED1 = 1,
  LED2 = 2
} Led_TypeDef;

#define POWER_BOARD_LED1_Pos    15    
#define POWER_BOARD_LED1_Msk    (0x1UL << POWER_BOARD_LED1_Pos)
#define POWER_BOARD_LED2_Pos    2    
#define POWER_BOARD_LED2_Msk    (0x1UL << POWER_BOARD_LED2_Pos)

void LED_Init(void);
void LED_On (uint32_t led);
void LED_Off (uint32_t led);
void LED_Toggle (uint32_t led);

// SmartFusion connector

#define SF_CON_GPIO_PIN30 // !
#define SF_CON_GPIO_PIN32 // !
#define SF_CON_GPIO_PIN34
#define SF_CON_GPIO_PIN36
#define SF_CON_GPIO_PIN38

void SF_GPIO_Init(void);

#endif // __POWER_BOARD_H


