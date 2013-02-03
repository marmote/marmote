/*
 * cmd_def.h
 *
 *  Created on: Aug 2, 2012
 *      Author: sszilvasi
 */

#ifndef CMD_DEF_H_
#define CMD_DEF_H_


#include <string.h>
#include <stdlib.h>

#include <mss_rtc.h>
#include "clock_mgt.h"

#include "yellowstone.h"
#include "teton.h"
#include "joshua.h"

typedef struct _CMD_Type
{
	const char *CmdString;
	uint32_t (*CmdFunction)(uint32_t argc, char** argv);
} CMD_Type;


extern CMD_Type CMD_List[];

// General commands
uint32_t CmdHelp(uint32_t argc, char** argv);
uint32_t CmdLed(uint32_t argc, char** argv);
uint32_t CmdAfe(uint32_t argc, char** argv);

// Power management
uint32_t CmdSleep(uint32_t argc, char** argv);
uint32_t CmdClock(uint32_t argc, char** argv);
//uint32_t CmdFpga(uint32_t argc, char** argv);

// MAX 2830 commands
uint32_t CmdReg(uint32_t argc, char** argv);
uint32_t CmdFreq(uint32_t argc, char** argv);
uint32_t CmdTxGain(uint32_t argc, char** argv);
uint32_t CmdTxBw(uint32_t argc, char** argv);
uint32_t CmdRxGain(uint32_t argc, char** argv);
uint32_t CmdRxLna(uint32_t argc, char** argv);
uint32_t CmdRxVga(uint32_t argc, char** argv);
uint32_t CmdRxBw(uint32_t argc, char** argv);
uint32_t CmdMode(uint32_t argc, char** argv);
uint32_t CmdRssi(uint32_t argc, char** argv);
uint32_t CmdPa(uint32_t argc, char** argv);
//uint32_t CmdCal(uint32_t argc, char** argv);

// AFE2 baseband test
uint32_t CmdIQ(uint32_t argc, char** argv);
uint32_t CmdMux1(uint32_t argc, char** argv);
uint32_t CmdMux2(uint32_t argc, char** argv);


#endif /* CMD_DEF_H_ */
