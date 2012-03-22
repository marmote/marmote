#ifndef __CMD_DEF_H
#define __CMD_DEF_H


// TODO: separate basic commands from 'connected-board-specific' commands

#include <stdlib.h>

#include "power_board.h"
#include "m6_rf315.h"

#include "usb_fs.h"

//char* argList[10];

typedef struct _CMD_Type
{
	uint8_t* CmdString;
	uint32_t (*CmdFunction)(uint32_t argc, char** argv);
} CMD_Type;

//uint8_t LED1_Enabled = 1; // Power supply TEST ONLY

extern CMD_Type CMD_List[];

uint32_t CmdHelp(uint32_t argc, char** argv);
uint32_t CmdLed(uint32_t argc, char** argv);
uint32_t CmdPwr(uint32_t argc, char** argv);
uint32_t CmdCcReg(uint32_t argc, char** argv);


   /*
uint8_t Led1On(void)
{
	LED1_Enabled = 1;
	return 0;
}

uint8_t Led1Off(void)
{
	LED1_Enabled = 0;
	return 0;
}

uint8_t Led2On(void)
{
	LED_On(LED2);
	return 0;
}

uint8_t Led2Off(void)
{
	LED_Off(LED2);
	return 0;
}			 

	 */




#endif // __CMD_DEF_H
