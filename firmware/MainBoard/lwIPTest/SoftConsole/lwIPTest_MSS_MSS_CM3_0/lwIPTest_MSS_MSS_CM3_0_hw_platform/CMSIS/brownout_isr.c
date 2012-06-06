/*******************************************************************************
 * (c) Copyright 2010 Actel Corporation.  All rights reserved.
 * 
 *
 * SVN $Revision: 3975 $
 * SVN $Date: 2011-11-16 14:17:46 +0000 (Wed, 16 Nov 2011) $
 */
#include "a2fxxxm3.h"

/*-------------------------------------------------------------------------*//**
 *
 */
#define SYS_RESET_REQUEST       0x05FA0004uL

#define BROWNOUT_SYNCN_MASK     0x00000003uL
#define NO_BROWNOUT             0x00000003uL

#define STABLE_SUPPLY_DELAY     100

#define CLKC_SOURCE_MASK        0x00070000uL
#define CLKC_SOURCE_VALUE       0x00070000uL

#define GLC_DIV_MASK            0x003F0000ul
#define GLC_DIV_VALUE           0x003C0000ul

#define GLMUX_MASK              0x0F000000uL
#define GLMUX_VALUE             0x01000000uL

/*-------------------------------------------------------------------------*//**
 *
 */
#if defined(__GNUC__)
__attribute__((__interrupt__)) void BrownOut_1_5V_IRQHandler( void )
#elif defined(__CC_ARM)
void BrownOut_1_5V_IRQHandler( void ) __irq
#elif defined( __ICCARM__ )
__irq void BrownOut_1_5V_IRQHandler( void )
#else
void BrownOut_1_5V_IRQHandler( void )
#endif
{
    uint32_t delay_count;
    uint32_t brownout_status;
	
    /*
     * Reduce frequency to 3MHz.
     * 	1) Select RC oscillator as CLKC clock source.
     *  2) Set divider to maximum allowed value (divide by 28).
     *  3) Set glitchless mux to use CLKC as MSS clock source.
     */
    SYSREG->MSS_CCC_MUX_CR = (SYSREG->MSS_CCC_MUX_CR & ~CLKC_SOURCE_MASK) | CLKC_SOURCE_VALUE;
    SYSREG->MSS_CCC_DIV_CR = (SYSREG->MSS_CCC_DIV_CR & ~GLC_DIV_MASK) | GLC_DIV_VALUE;
    SYSREG->MSS_CCC_MUX_CR = (SYSREG->MSS_CCC_MUX_CR & ~GLMUX_MASK) | GLMUX_VALUE;
	
    /*
     * Wait for supplies to become stable.
     */
    delay_count = STABLE_SUPPLY_DELAY;
    do
    {
        brownout_status = SYSREG->DEVICE_SR & BROWNOUT_SYNCN_MASK;
        if ( NO_BROWNOUT == brownout_status )
        {
            --delay_count;
        }
        else
        {
            delay_count = STABLE_SUPPLY_DELAY;
        }
    } while ( delay_count != 0 );
	
    /*
     * Issue system reset request.
     */
    SCB->AIRCR = SYS_RESET_REQUEST;
}
