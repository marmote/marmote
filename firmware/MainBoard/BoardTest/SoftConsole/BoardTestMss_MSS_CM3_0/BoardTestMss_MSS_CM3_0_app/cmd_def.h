/*
 * cmd_def.h
 *
 *  Created on: Aug 2, 2012
 *      Author: sszilvasi
 */

#ifndef CMD_DEF_H_
#define CMD_DEF_H_


#include <string.h>
#include "yellowstone.h"

typedef struct _CMD_Type
{
	const char *CmdString;
	uint32_t (*CmdFunction)(uint32_t argc, char** argv);
} CMD_Type;


extern CMD_Type CMD_List[];

uint32_t CmdHelp(uint32_t argc, char** argv);
uint32_t CmdLed(uint32_t argc, char** argv);

#endif /* CMD_DEF_H_ */
