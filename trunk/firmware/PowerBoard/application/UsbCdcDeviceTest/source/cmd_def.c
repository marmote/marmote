#include "cmd_def.h"


// List of command words and associated functions
extern CMD_Type CMD_List[] =
{
	"env",	CmdEnv, 	ENV_Yellowstone | ENV_Teton,
	"help", CmdHelp,	ENV_Yellowstone,	
	"led",  CmdLed,	   	ENV_Yellowstone,
	"pwr",  CmdPwr,		ENV_Yellowstone,
//	"t",    CmdTeton,
//	"mon on", CMD_MonitorOn,
//	"mon off", CMD_MonitorOff
	NULL,   NULL,		ENV_NONE,
};

extern ENV_Type ENV_List[] =
{
	{"ys", 	ENV_Yellowstone},
	{"t",	ENV_Teton},
	{NULL,	ENV_NONE}
};						   

extern ENV_Enum_Type activeEnv  = ENV_Yellowstone;



uint32_t CmdHelp(uint32_t argc, char** argv)
{	
	CMD_Type* cmdListItr = CMD_List;
	
	USB_SendString("\nAvailable commands:\n");
	
	while (cmdListItr->CmdString)
	{
		if (activeEnv & cmdListItr->CmdEnv)
		{
			USB_SendMsg("\n  ", 3);
			USB_SendString((const char*)cmdListItr->CmdString);
		}	  
		cmdListItr++;
	}
	USB_SendMsg("\n", 1);
	
	return 0;
}


uint32_t CmdEnv(uint32_t argc, char** argv)
{
	const ENV_Type* envListItr = ENV_List;

	if (argc == 1)
	{
		while ( envListItr->envString )
		{
			USB_SendMsg("\n  ", 3);
			USB_SendString(envListItr->envString);
			
			if (activeEnv == envListItr->envEnum)
			{
				USB_SendString("\t(active)");
			}
			envListItr++;
		} 
		return 0;
	}

	if (argc == 2)
	{
		while ( envListItr->envString )
		{
			if (!strcmp(*(argv+1), (envListItr->envString)))
			{			
				activeEnv = envListItr->envEnum;
				return 0;
			}
			envListItr++;
		}
		USB_SendString("\nEnvironment ");
		USB_SendString(*(argv+1));
		USB_SendString(" not found");		
	}

	// Send help message
  	USB_SendString("\nUsage: env [<new environment>]");
	return 1;
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
	char buf[128];
	uint8_t len;
	uint8_t i;

	if ( argc > 1 )
	{
		// FIXME: no length check
		strcpy(buf, *(argv+1));
		strcat(buf, " ");
		for ( i = 2 ; i < argc ; i++ )
		{
			strcat(buf, *(argv+i));
			strcat(buf, " ");
		}
		// Replace last space with '\n'
		len = strlen(buf);
		buf[len-1] = '\n';

		CON_SPI_Write( (const uint8_t*)buf, len );
		return 0;
	}

	// Send help message
  	USB_SendString("\nUsage: t <msg to forward>");
	return 1;
}
