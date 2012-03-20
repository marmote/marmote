#ifndef __CMD_DEF_H
#define __CMD_DEF_H

#include "power_board.h"
#include "m6_rf315.h"

#include "usb_fs.h"

char* argList[10];

typedef struct _CMD_Type
{
	uint8_t* CmdString;
	uint32_t (*CmdFunction)(uint32_t argc, char** argv);
} CMD_Type;

uint8_t LED1_Enabled = 1; // Power supply TEST ONLY

//uint8_t PrintHelpMsg(void);
//
//uint8_t LedOn(void)	;
//uint8_t LedOff(void);
//
//uint8_t CMD_PowerOn(void);
//uint8_t CMD_PowerOff(void);

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

uint8_t CMD_PowerOn(void)
{
	LED_On(LED2);
	POW_EnableMasterSwitch();
	return 0;
}

uint8_t CMD_PowerOff(void)
{
	LED_Off(LED2);
	POW_DisableMasterSwitch();
	return 0;
}

	 */

uint32_t CmdHelp(uint32_t argc, char** argv)
{
	// TODO: print help message
	LED_Toggle(LED1);
	return 0;
}

uint32_t CmdLed(uint32_t argc, char** argv)
{
	if (argc != 2)
		// TODO: print hint
		return 1;
	
	// TODO: make it work for both LEDs
	if (strcmp(*argv, "on"))
	{			
		LED_On(LED2);
		return 0;
	}

	if (strcmp(*argv, "off"))
	{			
		LED_Off(LED2);
		return 0;
	}

	return 0;
}

// List of command words and associated functions

CMD_Type CMD_List[] =
{
	"help", CmdHelp,
	"led",  CmdLed
	/*,
	"led1 on",  Led1On,
	"led1 off", Led1Off,
	"led2 on",  Led2On,
	"led2 off", Led2Off,
	"pwr on", CMD_PowerOn,
	"pwr off", CMD_PowerOff,
	"txled on", CON_TX_LED_On,
	"txled off", CON_TX_LED_Off,
	"rxled on", CON_RX_LED_On,
	"rxled off", CON_RX_LED_Off,
	"txd on", CON_TXD_Set,
	"txd off", CON_TXD_Clear,
	"spiw", CON_SPI_TestWrite,
	"spir", CON_SPI_TestRead*/
//	"mon on", CMD_MonitorOn,
//	"mon off", CMD_MonitorOff
};


				   /*
uint8_t PrintHelpMsg(void)
{
	uint8_t cmdIndex;

    USB_SendString("\nAvailable commands:\n\n");

	for (cmdIndex = 0; cmdIndex < sizeof(CMD_List)/sizeof(CMD_Type); cmdIndex++)
	{
		USB_SendString((char*)CMD_List[cmdIndex].CmdString);
		USB_SendString("\n");
	}

    return 0;
}
*/

#endif // __CMD_DEF_H
