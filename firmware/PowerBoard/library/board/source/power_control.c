//-----------------------------------------------------------------------------
// Title         : Power Control Functions Source
// Project       : Power Board
//-----------------------------------------------------------------------------
// File          : power_control.c
// Author        : Sandor Szilvasi
// Company       : Vanderbilt University, ISIS
// Created       : 2011-11-04 11:01
// Last update   : 2011-11-17 18:32
// Platform      : Marmote
// Target device : STM32F102CB
// Tool version  : ARM uVision 4 (v4.22.22.0)
// Standard      : CMSIS
//-----------------------------------------------------------------------------
// Description   : C source file for the power management functionalities
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
// Date            Version  Author              Description
// 2011-11-04      1.0      Sandor Szilvasi     Created
// 2011-11-17      1.1      Sandor Szilvasi     Cleanup
//-----------------------------------------------------------------------------

#include "power_control.h"

void PowerControl_Init(void)
{
    GPIO_InitTypeDef GPIO_InitStructure; 

    // Enable GPIO register clocks
    RCC_APB2PeriphClockCmd( USB_SUSP_GPIO_CLK |
                            USB_HPWR_GPIO_CLK |
                            MASTER_SWITCH_GPIO_CLK,
                            ENABLE);

    // USB_SUSP (PC13)
    USB_SUSP_GPIO_PORT->BRR = USB_SUSP_PIN;

    GPIO_InitStructure.GPIO_Pin = USB_SUSP_PIN; 
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP; 
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz; 
    GPIO_Init(USB_SUSP_GPIO_PORT, &GPIO_InitStructure); 
    
    // USB_HPWR (PB8)
    USB_HPWR_GPIO_PORT->BRR = USB_HPWR_PIN;

    GPIO_InitStructure.GPIO_Pin = USB_HPWR_PIN; 
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP; 
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz; 
    GPIO_Init(USB_HPWR_GPIO_PORT, &GPIO_InitStructure); 

#ifndef MASTER_SWITCH_ZERO_RESISTOR_NOT_POPULATED
    // MASTER_SWITCH
    GPIO_InitStructure.GPIO_Pin = MASTER_SWITCH_PIN; 
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP; 
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz; 
    GPIO_Init(MASTER_SWITCH_GPIO_PORT, &GPIO_InitStructure); 
#endif
}

#ifdef MASTER_SWITCH_ZERO_RESISTOR_NOT_POPULATED
void RCC_MCO_Init(void)
{
    GPIO_InitTypeDef GPIO_InitStructure; 

    // Enable GPIO clock
    RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA, ENABLE); 

    GPIO_InitStructure.GPIO_Pin = GPIO_Pin_8; 
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_PP; 
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz; 
    GPIO_Init(GPIOA, &GPIO_InitStructure); 

    // Enable AFIO clock
    RCC_APB2PeriphClockCmd(RCC_APB2Periph_AFIO, ENABLE)
    
    // Note: Set breakpoints here to check MCO output
    RCC_MCOConfig(RCC_MCO_HSI);
//  RCC_MCOConfig(RCC_MCO_HSE);
//    RCC_MCOConfig(RCC_MCO_PLLCLK_Div2);
//    RCC_MCOConfig(RCC_MCO_SYSCLK); 
}
#endif

void USB_EnableSuspendMode(void)
{
    USB_SUSP_GPIO_PORT->BSRR = USB_SUSP_PIN;
}

void USB_DisableSuspendMode(void)
{
    USB_SUSP_GPIO_PORT->BRR = USB_SUSP_PIN;
}

void USB_EnableHighPowerMode(void)
{
    USB_HPWR_GPIO_PORT->BSRR = USB_HPWR_PIN;
}

void USB_DisableHighPowerMode(void)
{
    USB_HPWR_GPIO_PORT->BRR = USB_HPWR_PIN;
}

void POW_EnableMasterSwitch(void)
{
    MASTER_SWITCH_GPIO_PORT->BSRR = MASTER_SWITCH_PIN;
}

void POW_DisableMasterSwitch(void)
{
    MASTER_SWITCH_GPIO_PORT->BRR = MASTER_SWITCH_PIN;
}

