//-----------------------------------------------------------------------------
// Title         : Power Control Functions Header
// Project       : Power Board
//-----------------------------------------------------------------------------
// File          : power_control.h
// Author        : Sandor Szilvasi
// Company       : Vanderbilt University, ISIS
// Created       : 2011-11-04 10:41
// Last update   : 2011-11-04 10:41
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
//-----------------------------------------------------------------------------

#ifndef __POWER_CONTROL_H
#define __POWER_CONTROL_H

#include "stm32f10x.h"

// PC13
#define USB_SUSP_Prt	GPIOC
#define USB_SUSP_Pos	13
#define USB_SUSP_Msk	(0x1UL << USB_SUSP_Pos)

// PB8
#define USB_HPWR_Prt	GPIOB
#define USB_HPWR_Pos	 8
#define USB_HPWR_Msk	(0x1UL << USB_HPWR_Pos)

// PB9
#define WALL_PWRGD_Prt	GPIOB
#define WALL_PWRGD_Pos	 9
#define WALL_PWRGD_Msk	(0x1UL << WALL_PWRGD_Pos)


#ifdef MASTER_SWITCH_ZERO_RESISTOR_NOT_POPULATED
// Use pin as MCO (AF) output

//#elif
// Use pin GPIO as master switch 

#endif

void PowerControl_Init(void);

void USB_EnableSuspendMode(void);
void USB_DisableSuspendMode(void);

void USB_EnableHighPowerMode(void);
void USB_DisableHighPowerMode(void);

uint8_t WALL_IsPowerGood(void);


#endif // __POWER_CONTROL_H

