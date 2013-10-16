//-----------------------------------------------------------------------------
// Title         : M6-RF315 board C file
// Project       : Marmote Power Supply Board
//-----------------------------------------------------------------------------
// File          : power_board.c
// Author        : Sandor Szilvasi
// Company       : Vanderbilt University, ISIS
// Created       : 2011-11-03 14:45
// Last update   : 2013-10-03 10:45
// Platform      : Marmote
// Target device : STM32F102CB
// Tool version  : ARM uVision 4 (v4.70.0.0)
// Standard      : CMSIS
//-----------------------------------------------------------------------------
// Description   : <+description+>
//-----------------------------------------------------------------------------
// Copyright (c) 2006-2013, Vanderbilt University
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
// Date            Version  Author          Description
// 2011-11-03      1.0      Sandor Szilvasi Created
//-----------------------------------------------------------------------------

#include "power_board.h"
#include "power_monitor.h"

volatile uint32_t ms_ticks;
static uint32_t tick_ctr;

void SysTick_Handler(void)
{
    ms_ticks++;

    if (ms_ticks == 124)
    {
        ms_ticks = 0;        
        tick_ctr = (tick_ctr < 7) ? tick_ctr + 1 : 0;

        if (BAT_IsCharging())
        {
            if (tick_ctr == 0)
            {
                LED_On(LED2);
            }
            if (tick_ctr == 4)
            {
                LED_Off(LED2);
            }
            return;
        }
        
        if (BAT_AlarmAsserted())
        {
            if (tick_ctr == 0)
            {
                LED_On(LED2);
            }
            if (tick_ctr == 1)
            {
                LED_Off(LED2);
            }            
            return;
        }
        
        LED_Off(LED2);
    }
}

void Delay (uint32_t dly_ticks)
{
    uint32_t cur_ticks = ms_ticks;

    while ((ms_ticks - cur_ticks) < dly_ticks);
}

