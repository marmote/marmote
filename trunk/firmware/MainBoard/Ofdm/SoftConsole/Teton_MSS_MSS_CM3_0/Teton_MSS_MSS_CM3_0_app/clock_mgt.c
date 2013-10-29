/*
 * clock_mgt.c
 *
 *  Created on: Aug 28, 2012
 *      Author: sszilvasi
 */

#include "clock_mgt.h"


#define RXCSEL_SHIFT	17
#define DYNCSEL_SHIFT	18
#define BYPASSC_SHIFT	22
#define GLMUXSEL_SHIFT 	24
#define GLMUXCFG_SHIFT 	26
#define MAINOSCEN_SHIFT 29

//#define STATASEL_MASK   (1 << 0)
//#define RXASEL_MASK 	(1 << 1)
//#define DYNASEL_MASK 	(1 << 2)
//#define BYPASSA_MASK	(1 << 6)
//#define STATCSEL_MASK	(1 << 16)
//#define RXCSEL_MASK 	(1 << 17)
//#define DYNCSEL_MASK	(1 << 18)
//#define BYPASSC_MASK	(1 << 22)

static CLK_SRC_Type currentMssClock = MAIN_OSC_CLK_SRC;


void SwitchMssClock(CLK_SRC_Type newMssClock)
{
	uint32_t mux_cr;

	switch (newMssClock)
	{
		case RC_OSC_CLK_SRC:
			break;

		case MAIN_OSC_CLK_SRC:


			// FIXME: It assumed that MAINOSC is enabled and PLL/OAMUX/BYPASSA
			//        are configured properly

			// Enable 20 MHz oscillator
			//SYSREG->MSS_CCC_DIV_CR |= (1 << MAINOSCEN_SHIFT);

			mux_cr = SYSREG->MSS_CCC_MUX_CR;

			// Configure Glitchless MUX to select GLC as MSS clock
			mux_cr &= ~(3 << GLMUXCFG_SHIFT);
			mux_cr &= ~(1 << GLMUXSEL_SHIFT);
			SYSREG->MSS_CCC_MUX_CR = mux_cr;

			break;

		case LP_OSC_CLK_SRC:

			// Enable 32 KHz crystal oscillator
			RTC->CTRL_STAT_REG |= CTRL_STAT_XTAL_EN;

			// Set 32 kHz Oscillator as CLKC source and bypass CLKC output divider
			mux_cr = SYSREG->MSS_CCC_MUX_CR;
			mux_cr |= (1 << RXCSEL_SHIFT) | (1 << DYNCSEL_SHIFT) | (1 << BYPASSC_SHIFT);
			SYSREG->MSS_CCC_MUX_CR = mux_cr;

			// Configure GLMUX to select GLC as MSS clock
			mux_cr &= ~(3 << GLMUXCFG_SHIFT);
			mux_cr |=  (1 << GLMUXSEL_SHIFT);
			SYSREG->MSS_CCC_MUX_CR = mux_cr;

			SystemCoreClock = 32768uL;
			break;
	}

	SystemCoreClockUpdate(); // Seems to be ineffective
}

CLK_SRC_Type GetMssClock(void)
{
	return currentMssClock;
}

__attribute__((__interrupt__)) void RTC_Match_IRQHandler( void )
{
	/* Clear RTC match interrupt. */
	MSS_RTC_clear_irq();
}
