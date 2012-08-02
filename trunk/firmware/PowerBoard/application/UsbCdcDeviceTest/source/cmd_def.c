#include "cmd_def.h"

/*
uint8_t LedOn(void)
{
	LED_On(LED2);
	return 0;
}

uint8_t LedOff(void)
{
	LED_Off(LED2);
	return 0;
}

uint8_t PrintHelpMsg(void)
{
    USB_SendMsg("\nhelp mess\n", 11);
    return 0;
}

uint8_t CMD_PowerOn(void)
{
	LED_On(LED2);
	return 0;
}

uint8_t CMD_PowerOff(void)
{
	LED_Off(LED2);
	return 0;
}
*/

// List of command words and associated functions
extern CMD_Type CMD_List[] =
{
	"help", CmdHelp,
	"led",  CmdLed,
	"pwr",  CmdPwr,
	"reg",  CmdReg,
	"t",    CmdTeton,
//	"ccreg",  CmdCcReg,
//	"mon on", CMD_MonitorOn,
//	"mon off", CMD_MonitorOff
	NULL,   NULL
};



uint32_t CmdHelp(uint32_t argc, char** argv)
{
	CMD_Type* cmdListItr = CMD_List;
	
	USB_SendString("\nAvailable commands:\n");
	
	while (cmdListItr->CmdString)
	{
		USB_SendMsg("\n  ", 3);
		USB_SendString((const char*)cmdListItr->CmdString);
		cmdListItr++;
	}
	USB_SendMsg("\n", 1);
	
	return 0;
}


uint32_t CmdLed(uint32_t argc, char** argv)
{
	if (argc == 2)
	{
		if (!strcmp(*(argv+1), "on"))
		{			
			LED_On(LED2);
			USB_SendString("\nLED is ON");
			return 0;
		}
	
		if (!strcmp(*(argv+1), "off"))
		{			
			LED_Off(LED2);
			USB_SendString("\nLED is OFF");
			return 0;
		}
	}

	// Send help message
  	USB_SendString("\nUsage: led [on | off]");
	return 1;
}

uint32_t CmdPwr(uint32_t argc, char** argv)
{	
	if (argc == 2) {
		if (!strcmp(*(argv+1), "on"))
		{			
			LED_On(LED2);
			POW_EnableMasterSwitch();
			USB_SendString("\npower is ON");
			return 0;
		}
	
		if (!strcmp(*(argv+1), "off"))
		{			
			LED_Off(LED2);
			POW_DisableMasterSwitch();
			USB_SendString("\npower is OFF");
			return 0;
		}
	}

	// Send help message
  	USB_SendString("\nUsage: pwr [on | off]");
	return 1;
}

uint32_t CmdReg(uint32_t argc, char** argv)
{		
	uint8_t addr, data;
	char msg[32];

	if (argc == 2 || argc == 3)
	{
		// Parse first paramter
		addr = atoi(*(argv+1));

		if (addr || !strcmp(*(argv+1), "0"))
		{
			// Register read (only)
			if (argc == 2)
			{
				data = CON_SPI_ReadRegister(addr);
				USB_SendString("\nreg read");

				// Print register value
				sprintf(msg, "\n%3d: %3d", addr, data);
				USB_SendString(msg);
				return 0;
			}

			// Parse second parameter
			data = atoi(*(argv+2));
			if (data || !strcmp(*(argv+2), "0"))
			{
				CON_SPI_WriteRegister(addr, data);
				USB_SendString("\nreg written");

				// Print register value
				sprintf(msg, "\n%3d: %3d (w)", addr, data);
				USB_SendString(msg);
				
				// Read back register value here
				data = CON_SPI_ReadRegister(addr);
				sprintf(msg, "\n%3d: %3d (r)", addr, data);
				USB_SendString(msg);
				return 0;
			}
		}
	}
			
	// Send help message
	USB_SendString("\nUsage: reg <addr> [<new value>]");
	return 1;	
}

uint32_t CmdTeton(uint32_t argc, char** argv)
{	
	if (argc == 2) {
		//if ( strlen(*(argv+1)) == 1 )		
		{
			char buf[32];
			uint8_t arg_len;
			
			arg_len = strlen(*(argv+1)) < 32-1 ? strlen(*(argv+1)) : 32-1;
			strncpy( buf, *(argv+1), arg_len );
			buf[arg_len] = '\n';

			CON_SPI_Write( (const uint8_t*)buf, arg_len+1 );
			return 0;
		}
		
		/*
		if (!strcmp(*(argv+1), "on"))
		{			
			LED_On(LED2);
			CON_SGPIO3_GPIO_PORT->BSRR = CON_SGPIO3_PIN;
			CON_SGPIO2_GPIO_PORT->BRR = CON_SGPIO2_PIN;
			USB_SendString("\nSF IRQ line asserted");
			return 0;
		}
	
		if (!strcmp(*(argv+1), "off"))
		{			
			LED_Off(LED2);
			CON_SGPIO3_GPIO_PORT->BRR = CON_SGPIO3_PIN;
			CON_SGPIO2_GPIO_PORT->BSRR = CON_SGPIO2_PIN;
			USB_SendString("\nSF IRQ line deasserted");
			return 0;
		}
		*/
	}

	// Send help message
  	USB_SendString("\nUsage: t <msg to forward>");
	return 1;
}


//uint32_t CmdCcReg(uint32_t argc, char** argv)
//{		
//	uint8_t addr, data;
//	char msg[32];
//
//	if (argc == 2 || argc == 3)
//	{
//		// Parse first paramter (check if it's a valid number)
//		addr = atoi(*(argv+1));
//
//		if (addr || !strcmp(*(argv+1), "0"))
//		{
//			if (argc == 2)
//			{
//				data = CON_SPI_ReadRegister(addr);
//				USB_SendString("\nreg read");
//				// Print register value
//				//itoa(data, msg, 10);
//				sprintf(msg, "\n%3d: %3d", addr, data);
//				//USB_SendString("\n");
//				USB_SendString(msg);
//				return 0;
//			}
//
//			// Parse second parameter
//			data = atoi(*(argv+2));
//			if (data || !strcmp(*(argv+2), "0"))
//			{
//				CON_SPI_WriteRegister(addr, data);
//				USB_SendString("\nreg written");
//				sprintf(msg, "\n%3d: %3d (w)", addr, data);
//				USB_SendString(msg);
//				
//				// Read back register value here
//				data = CON_SPI_ReadRegister(addr);
//				// Print new register value		  
//				sprintf(msg, "\n%3d: %3d (r)", addr, data);
//				USB_SendString(msg);
//				//itoa(data, msg, 10);
//				return 0;
//			}
//		}
//	}
//			
//	// Send help message
//	USB_SendString("\nUsage: reg <addr> [<new value>]");
//	return 1;	
//}
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


