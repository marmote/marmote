/*
 * commands.h
 *
 *  Created on: May 31, 2012
 *      Author: sszilvasi
 */

#ifndef CMD_DEFS_H_
#define CMD_DEFS_H

#include <mss_uart.h>
#include <mss_gpio.h>

#include <string.h>
#include <stdio.h>


#include "joshua.h"
#include "fsk_tx.h"


#define MSS_GPIO_AFE1_SHDN_MASK MSS_GPIO_0_MASK
#define MSS_GPIO_LED1_MASK MSS_GPIO_1_MASK



uint32_t CmdHelp(uint32_t argc, char** argv);
uint32_t CmdLed(uint32_t argc, char** argv);
uint32_t CmdAfe(uint32_t argc, char** argv);
uint32_t CmdFsk(uint32_t argc, char** argv);
uint32_t CmdTx(uint32_t argc, char** argv);
uint32_t CmdAmpl(uint32_t argc, char** argv);
uint32_t CmdIQ(uint32_t argc, char** argv);
uint32_t CmdPath(uint32_t argc, char** argv);
uint32_t CmdIfFreq(uint32_t argc, char** argv);
// MAX 2830 related
uint32_t CmdReg(uint32_t argc, char** argv);
uint32_t CmdFreq(uint32_t argc, char** argv);
uint32_t CmdGain(uint32_t argc, char** argv);
uint32_t CmdLpf(uint32_t argc, char** argv);
uint32_t CmdMode(uint32_t argc, char** argv);


typedef struct cmd_struct
{
	char* CmdString;
	uint32_t (*CmdFunction)(uint32_t argc, char** argv);
} cmd_t;

extern cmd_t cmd_list[];


#endif /* CMD_DEFS_H */
