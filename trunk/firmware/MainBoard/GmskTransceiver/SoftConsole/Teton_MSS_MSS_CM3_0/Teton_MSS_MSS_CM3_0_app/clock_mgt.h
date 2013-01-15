/*
 * clock_mgt.h
 *
 *  Created on: Aug 28, 2012
 *      Author: sszilvasi
 */

#ifndef CLOCK_MGT_H_
#define CLOCK_MGT_H_

#include <a2fxxxm3.h>
#include <mss_rtc.h>

#define CTRL_STAT_XTAL_EN           0x01u

typedef enum
{
	RC_OSC_CLK_SRC,
	MAIN_OSC_CLK_SRC,
	LP_OSC_CLK_SRC
} CLK_SRC_Type;

void SwitchMssClock(CLK_SRC_Type newMssClock);
CLK_SRC_Type GetMssClock(void);

#endif /* CLOCK_MGT_H_ */
