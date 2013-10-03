//-----------------------------------------------------------------------------
// Title         : Power Control Functions Header
// Project       : Power Board
//-----------------------------------------------------------------------------
// File          : power_control.h
// Author        : Sandor Szilvasi
// Company       : Vanderbilt University, ISIS
// Created       : 2011-11-04 10:41
// Last update   : 2011-11-17 17:55
// Platform      : Marmote
// Target device : STM32F102CB
// Tool version  : ARM uVision 4 (v4.22.22.0)
// Standard      : CMSIS
//-----------------------------------------------------------------------------
// Description   : C header file for the power management functionalities
// regarding the USB, 5V WALL and Li-Ion battery of the Marmote Power Board.
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
// 2011-11-17      1.1      Sandor Szilvasi	Cleanup
//-----------------------------------------------------------------------------

#ifndef __POWER_CONTROL_H
#define __POWER_CONTROL_H

#include "stm32f10x.h"


#define USB_SUSP_PIN			GPIO_Pin_13	// PC.13
#define USB_SUSP_GPIO_PORT		GPIOC
#define USB_SUSP_GPIO_CLK		RCC_APB2Periph_GPIOC

#define USB_HPWR_PIN			GPIO_Pin_8	// PB.8
#define USB_HPWR_GPIO_PORT		GPIOB
#define USB_HPWR_GPIO_CLK		RCC_APB2Periph_GPIOB

#define WALL_PWRGD_PIN			GPIO_Pin_9	// PB.9
#define WALL_PWRGD_GPIO_PORT	GPIOB
#define WALL_PWRGD_GPIO_CLK		RCC_APB2Periph_GPIOB


#ifndef MASTER_SWITCH_ZERO_RESISTOR_NOT_POPULATED
// Use pin GPIO as master switch 
#define MASTER_SWITCH_GPIO_PORT		GPIOA
#define MASTER_SWITCH_PIN           GPIO_Pin_8	// PA.8
#define MASTER_SWITCH_GPIO_CLK      RCC_APB2Periph_GPIOA
#else
// Use pin as MCO (AF) output
void RCC_MCO_Init(void);
#endif

void PowerControl_Init(void);

void USB_EnableSuspendMode(void);
void USB_DisableSuspendMode(void);

void USB_EnableHighPowerMode(void);
void USB_DisableHighPowerMode(void);

void POW_EnableMasterSwitch(void);
void POW_DisableMasterSwitch(void);


#endif // __POWER_CONTROL_H

