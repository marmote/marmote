#include "stm32f10x_conf.h"
#include "stm32f10x.h"

#include "power_board.h"
#include "cmd_def.h"
#include "usb_fs.h"

#include <string.h>
#include <stdio.h>

char* argList[10];

CMD_Type* cmd_list_ptr;

uint32_t argc;
char* cmd_token;																													   
uint8_t CMD_Rx_Buffer[32];
uint8_t CMD_Rx_Length;
uint8_t CMD_Rx_Valid;

void process_cmd_buff(const char* cmd_buff, uint8_t length)
{
	uint8_t CMD_ParseResult = 1;

	// Tokenize RX buffer content
	cmd_token = strtok((char *)CMD_Rx_Buffer, " ");
	if (cmd_token != NULL)
	{
		cmd_list_ptr = CMD_List;
		while (cmd_list_ptr->CmdString)
	    {
	        if (!strcmp(cmd_token, (const char*)cmd_list_ptr->CmdString))
	        {
				// Set the argList pointers to tokens
	            argc = 0;			
							
	            while ( cmd_token != NULL && argc < 10 )
	            {
	                argList[argc++] = cmd_token;
	                cmd_token = strtok(NULL, " ");
	            }

				USB_SendMsg("\nACK", 4);

				// Invoke associated command function
		        cmd_list_ptr->CmdFunction(argc, argList);			

				CMD_ParseResult = 0;
	            break;
	        }

			cmd_list_ptr++;
	    }
	}							
	
	// Send NAK if no valid command identified
	if (CMD_ParseResult == 1)
	{		
		USB_SendMsg("\nNAK>", 4);	
	}

	// Send '>' prompt
	USB_SendMsg("\n>", 2);	

	// Clean up states
	CMD_Rx_Valid = 0;
	CMD_Rx_Length = 0;
}

//-------------------------------------------------------------------


int main (void) {
							
	// Configure SysTick
	SysTick->CTRL |= (SysTick_CTRL_CLKSOURCE_Msk | SysTick_CTRL_TICKINT_Msk | SysTick_CTRL_ENABLE_Msk);
	SysTick->LOAD = 72000;	
		
 	USB_FsInit();
					
	PowerControl_Init();
	PowerMonitor_Init();
	Teton_Init();

	// Enable power
	POW_EnableMasterSwitch();

	// USB command processor loop				
	while (1)
	{		
		if (CMD_Rx_Valid == 1)
		{
			process_cmd_buff((const char*)CMD_Rx_Buffer, CMD_Rx_Length);
		}
	}
}



