#include "stm32f10x_conf.h"
#include "stm32f10x.h"

#include "power_board.h"
#include "m6_rf315.h"
#include "cmd_def.h"
#include "usb_fs.h"

#include <string.h>
#include <stdio.h>

//char cmd[20];
uint32_t argc;
char* cmdTok;

uint8_t CMD_Rx_Buffer[32];
uint8_t CMD_Rx_Length;
uint8_t CMD_Rx_Valid;
uint8_t CMD_ParseResult;

uint8_t i, j;		  
uint8_t CMD_ListLength;  	
uint32_t c;


extern CMD_Type CMD_List[];

int main (void) {
							
	// Configure SysTick
	SysTick->CTRL |= (SysTick_CTRL_CLKSOURCE_Msk | SysTick_CTRL_TICKINT_Msk | SysTick_CTRL_ENABLE_Msk);
	SysTick->LOAD = 72000;	
		
 	USB_FsInit();
					
	PowerControl_Init();
	PowerMonitor_Init();	
	//LED_Init();

	// Initialize M6-RF315 board
	M6RF315_Init();

	// Enable power
	POW_EnableMasterSwitch();

	// Turn on LEDs
	CON_TX_LED_Off();
	CON_RX_LED_On();
	for (c = 0 ; c < 1600000; c++) ;
	CON_RX_LED_Toggle();
	//for (c = 0 ; c < 1600000; c++) ;
	//CON_RX_LED_Toggle();

	//for (;;) ;

	CMD_ListLength = sizeof(CMD_List)/sizeof(CMD_Type);
				
	while (1)
	{		
		if (CMD_Rx_Valid == 1)
		{
			CMD_ParseResult = 1;

			// Tokenize command string
			//argList = strtok("a b c d", " ");

			argc = 0;
			//argList[argc] = strtok((char *)CMD_Rx_Buffer, " ");
			cmdTok = strtok((char *)CMD_Rx_Buffer, " ");

			CMD_ParseResult = 1;

			while ( argList[argc] != NULL && argc < 10 )
			{
				argc++;
				argList[argc] = strtok(NULL, " ");
			}

			if (argc > 0)
			{
				// Process command
				for (i = 0; i < CMD_ListLength; i++)
	            {
	                // Compare CMD[i] with received command
	                for (j = 0; j < strlen(argList[0]); j++)
	                {
	                    if (CMD_List[i].CmdString[j] == '\0')
	                    {
	                        CMD_ParseResult = 0;
	                        (*CMD_List[i].CmdFunction)(argc, argList);
	                        break;
	                    }
	
	                    if (CMD_Rx_Buffer[j] != CMD_List[i].CmdString[j])
	                    {
	                        break;
	                    }
	                }
	
	                // Exit for loop as soon as a match is found
					if (CMD_ParseResult == 0)
					{
						break;
					}
	        	}
			}
				else
			{
				CMD_ParseResult = 1;
			}



			// Send ACK/NAK
			if (CMD_ParseResult == 0)
			{		
				USB_SendMsg("\nACK\n>", 6);	
			}
			else
			{		
				USB_SendMsg("\nNAK\n>", 6);	
			}

			// Clean up states
			CMD_Rx_Valid = 0;
			CMD_Rx_Length = 0;
		}	
	}
}

