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

uint32_t g_rate;

// General commands
uint32_t CmdHelp(uint32_t argc, char** argv);
uint32_t CmdStatus(uint32_t argc, char** argv);
uint32_t CmdLed(uint32_t argc, char** argv);
uint32_t CmdAfe(uint32_t argc, char** argv);
uint32_t CmdIQOffset(uint32_t argc, char** argv);

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
uint32_t CmdRxHp(uint32_t argc, char** argv);
uint32_t CmdMode(uint32_t argc, char** argv);
uint32_t CmdRssi(uint32_t argc, char** argv);
uint32_t CmdPa(uint32_t argc, char** argv);
//uint32_t CmdCal(uint32_t argc, char** argv);

// OFDM related
uint32_t CmdGain(uint32_t argc, char** argv);
uint32_t CmdPattern(uint32_t argc, char** argv);
uint32_t CmdMask(uint32_t argc, char** argv);
uint32_t CmdStart(uint32_t argc, char** argv);
uint32_t CmdStartPeriodic(uint32_t argc, char** argv);
uint32_t CmdStop(uint32_t argc, char** argv);
uint32_t CmdRate(uint32_t argc, char** argv);


#endif /* CMD_DEF_H_ */
