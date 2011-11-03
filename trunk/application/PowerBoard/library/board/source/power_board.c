//-----------------------------------------------------------------------------
// Title         : <+title+>
// Project       : Power Board
//-----------------------------------------------------------------------------
// File          : power_board.c
// Author        : Sandor Szilvasi
// Company       : Vanderbilt University, ISIS
// Created       : 2011-11-03 14:45
// Last update   : 2011-11-03 14:45
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
// 2011-11-03      1.0      Sandor Szilvasi	Created
//-----------------------------------------------------------------------------

#include "power_board.h"

void LED_Init(void)
{
	// Enable peripheral clock
	RCC->APB2ENR |= RCC_APB2ENR_AFIOEN;
	RCC->APB2ENR |= RCC_APB2ENR_IOPAEN;
	RCC->APB2ENR |= RCC_APB2ENR_IOPBEN;

    // PA15 GPIO remap for LED1
    AFIO->MAPR |= AFIO_MAPR_SWJ_CFG_JTAGDISABLE;

	// Configure LEDs to open-drain (CNF[1:0] = 01), 2 MHz mode (MODE[1:0] = 10)
    GPIOA->BSRR = POWER_BOARD_LED1_Msk;
    GPIOA->CRH &= 0x0FFFFFFFUL;
    GPIOA->CRH |= 0x60000000UL;

	GPIOB->BSRR = POWER_BOARD_LED2_Msk;
	GPIOB->CRL = (uint32_t)0x06 << 8;
}

void LED_On (uint32_t led)
{
    if (led & LED1)
    {
        GPIOA->BRR = POWER_BOARD_LED1_Msk;
    }

    if (led & LED2)
    {
        GPIOB->BRR = POWER_BOARD_LED2_Msk;
    }
}

void LED_Off (uint32_t led)
{
    if (led & LED1)
    {
        GPIOA->BSRR = POWER_BOARD_LED1_Msk;
    }

    if (led & LED2)
    {
        GPIOB->BSRR = POWER_BOARD_LED2_Msk;
    }
}

void LED_Toggle (uint32_t led)
{
    if (led & LED1)
    {
        if (GPIOA->IDR & POWER_BOARD_LED1_Msk)
        {
            GPIOA->BRR = POWER_BOARD_LED1_Msk;
        }
        else
        {
            GPIOA->BSRR = POWER_BOARD_LED1_Msk;
        }
    }

    if (led & LED2)
    {
        if (GPIOB->IDR & POWER_BOARD_LED2_Msk)
        {
            GPIOB->BRR = POWER_BOARD_LED2_Msk;
        }
        else
        {
            GPIOB->BSRR = POWER_BOARD_LED2_Msk;
        }
    }
}


/*
void SF_GPIO_Init(void)
{
	// Enable peripheral clocks
	RCC->APB2ENR |= RCC_APB2ENR_IOPAEN;
	RCC->APB2ENR |= RCC_APB2ENR_IOPBEN;
	RCC->APB2ENR |= RCC_APB2ENR_IOPCEN;

	GPIO_InitTypeDef GPIO_InitStructure; 

    // PC14, PC15, PA9, PA10, PB4
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_8; 
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_PP; 
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz; 
	GPIO_Init(GPIOA, &GPIO_InitStructure); 
}
*/

