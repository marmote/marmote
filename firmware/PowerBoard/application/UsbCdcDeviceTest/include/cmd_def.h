#ifndef __CMD_DEF_H
#define __CMD_DEF_H


// TODO: separate basic commands from 'connected-board-specific' commands

#include <stdlib.h>

#include "power_board.h"
#include "teton.h"

 #include "usb_fs.h"


typedef struct _CMD_Type
{
	uint8_t* CmdString;
	uint32_t (*CmdFunction)(uint32_t argc, char** argv);
} CMD_Type;


extern CMD_Type CMD_List[];

uint32_t CmdHelp(uint32_t argc, char** argv);
uint32_t CmdLed(uint32_t argc, char** argv);
uint32_t CmdPwr(uint32_t argc, char** argv);
uint32_t CmdReg(uint32_t argc, char** argv);


#endif // __CMD_DEF_H
