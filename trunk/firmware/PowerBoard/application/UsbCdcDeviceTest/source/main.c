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

			// Tokenize RX buffer content
			cmdTok = strtok((char *)CMD_Rx_Buffer, " ");
			if (cmdTok != NULL)
			{
				for ( j = 0; j < sizeof(CMD_List)/sizeof(CMD_Type); j++ )
			    {
			        if (!strcmp(cmdTok, CMD_List[j].CmdString))
			        {
						// Set the argList pointers to tokens
			            argc = 0;			
									
			            while ( cmdTok != NULL && argc < 10 )
			            {
			                argList[argc++] = cmdTok;
			                cmdTok = strtok(NULL, " ");
			            }

						USB_SendMsg("\nACK\n>", 6);

						// Invoke associated command function
				        CMD_List[j].CmdFunction(argc, argList);			

						CMD_ParseResult = 0;
			            break;
			        }
			    }
			}							
			
			// Send NAK if no valid command identified
			if (CMD_ParseResult == 1)
			{		
				USB_SendMsg("\nNAK\n>", 6);	
			}

			// Clean up states
			CMD_Rx_Valid = 0;
			CMD_Rx_Length = 0;
		}	
	}
}

