//-----------------------------------------------------------------------------
// Title         : M6-RF315 board C file
// Project       : Marmote Power Supply Board
//-----------------------------------------------------------------------------
// File          : m6_rf315.c
// Author        : Sandor Szilvasi
// Company       : Vanderbilt University, ISIS
// Created       : 2012-03-01 17:08
// Last update   : 2012-03-01 17:08
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
// 2012-03-01      1.0      Sandor Szilvasi	Created
//-----------------------------------------------------------------------------

#include "m6_rf315.h"

void M6RF315_Init(void)
{
    CON_LED_Init();
    // TODO: Init CC1101
    // TODO: Init serial data GPIOs
}

void CON_LED_Init(void)
{
	GPIO_InitTypeDef GPIO_InitStructure; 

	// Enable peripheral clocks
	RCC->APB2ENR |= (CON_LED_RX_GPIO_CLK | CON_LED_TX_GPIO_CLK);
	//RCC->APB2ENR |= RCC_APB2ENR_IOPBEN;

    // RX LED - PB.6
	GPIO_InitStructure.GPIO_Pin = CON_LED_RX; 
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP; 
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz; 
	GPIO_Init(CON_LED_RX_GPIO_PORT, &GPIO_InitStructure); 

    // TX LED - PB.7
	GPIO_InitStructure.GPIO_Pin = CON_LED_TX; 
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP; 
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz; 
	GPIO_Init(CON_LED_TX_GPIO_PORT, &GPIO_InitStructure); 
}


void CON_RX_LED_On(void)
{
    CON_LED_RX_GPIO_PORT->BRR = CON_LED_RX;
}

void CON_RX_LED_Off(void)
{
    CON_LED_RX_GPIO_PORT->BSRR = CON_LED_RX;
}

void CON_RX_LED_Toggle(void)
{
    // TODO
    //CON_LED_RX_GPIO_PORT->BRR = CON_LED_RX;
}

void CON_TX_LED_On(void)
{
    CON_LED_TX_GPIO_PORT->BRR = CON_LED_TX;
}

void CON_TX_LED_Off(void)
{
    CON_LED_TX_GPIO_PORT->BSRR = CON_LED_TX;
}

void CON_TX_LED_Toggle(void)
{
    // TODO
    //CON_LED_TX_GPIO_PORT->BRR = CON_LED_TX;
}

void CON_TXRX_Init(void)
{
    // TODO
}

void CON_TXD_Set(uint32_t value)
{
    // TODO
}

void CON_TXD_Clear(uint32_t value)
{
    // TODO
}

uint8_t CON_RXD_Get(void)
{
    // TODO
	return 0;
}


void CON_SPI_Init(void)
{
    // TODO
}
void CON_SPI_SendData(uint16_t data)
{
    // TODO
}

