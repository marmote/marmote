#ifndef __CMD_DEF_H
#define __CMD_DEF_H

#include "power_board.h"

typedef struct _CMD_Type
{
	uint8_t* CmdString;
	uint8_t (*CmdFunction)(void);
} CMD_Type;

uint8_t LedOn()
{
	LED_On(LED2);
	return 0;
}

uint8_t LedOff()
{
	LED_Off(LED2);
	return 0;
}

// List of command words and associated functions
CMD_Type CMD_List[] =
{
	"led on",  LedOn,
	"led off", LedOff
};


#endif // __CMD_DEF_H
