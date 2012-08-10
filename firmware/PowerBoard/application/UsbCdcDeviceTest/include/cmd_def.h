#ifndef __CMD_DEF_H
#define __CMD_DEF_H


// TODO: separate basic commands from 'connected-board-specific' commands

#include <stdlib.h>

#include "power_board.h"
#include "teton.h"

#include "usb_fs.h"

typedef enum _ENV_Enum_Type
{
	ENV_NONE	 	= 0,
	ENV_ALL	 		= 1,
	ENV_Yellowstone	= 2,
	ENV_Teton		= 4
} ENV_Enum_Type;

typedef struct _CMD_Type
{
	const char* CmdString;
	uint32_t (*CmdFunction)(uint32_t argc, char** argv);
	uint32_t CmdEnv; // Environments the command available in
} CMD_Type;

typedef struct _ENV_Type
{
	const char* envString;
	ENV_Enum_Type envEnum;
} ENV_Type;

				   
extern CMD_Type CMD_List[];
extern ENV_Type ENV_List[];

extern ENV_Enum_Type activeEnv;

uint32_t CmdHelp(uint32_t argc, char** argv);
uint32_t CmdEnv(uint32_t argc, char** argv);
uint32_t CmdLed(uint32_t argc, char** argv);
uint32_t CmdPwr(uint32_t argc, char** argv);
uint32_t CmdReg(uint32_t argc, char** argv);
uint32_t CmdTeton(uint32_t argc, char** argv);


#endif // __CMD_DEF_H
