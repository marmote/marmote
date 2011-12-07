#include "stm32f10x_conf.h"
#include "stm32f10x.h"

#include "power_board.h"
#include "cmd_def.h"
#include "usb_fs.h"

uint8_t CMD_Rx_Buffer[32];
uint8_t CMD_Rx_Length;
uint8_t CMD_Rx_Valid;
uint8_t CMD_ParseResult;

uint8_t i, j;		  
uint8_t CMD_ListLength;  		

int main (void) {
							
	// Configure SysTick
	SysTick->CTRL |= (SysTick_CTRL_CLKSOURCE_Msk | SysTick_CTRL_TICKINT_Msk | SysTick_CTRL_ENABLE_Msk);
	SysTick->LOAD = 72000;	
						
	PowerControl_Init();
	//PowerMonitor_Init();	
	LED_Init();
	USB_FsInit();

	CMD_ListLength = sizeof(CMD_List)/sizeof(CMD_Type);
				
	while (1)
	{		
		if (CMD_Rx_Valid == 1)
		{
			CMD_ParseResult = 1;

			// Process command
			for (i = 0; i < CMD_ListLength; i++)
            {
                // Compare CMD[i} with received command
                for (j = 0; j < CMD_Rx_Length; j++)
                {
                    if (CMD_List[i].CmdString[j] == '\0')
                    {
                        CMD_ParseResult = 0;
                        (*CMD_List[i].CmdFunction)();
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

			// Send ACK/NAK
			if (CMD_ParseResult == 0)
			{		
				USB_SendMsg("\nACK\n>", 6);	
				/*
				USB_Tx_Buffer[0] = 'A';
				USB_Tx_Buffer[1] = 'C';
				USB_Tx_Buffer[2] = 'K';
				USB_Tx_Buffer[3] = '\n';
				USB_Tx_Buffer[4] = '>';
				USB_Tx_Length = 5;
				USB_Tx_Request = 1;
				*/
			}
			else
			{		
				USB_SendMsg("\nNAK\n>", 6);	
				/*
				USB_Tx_Buffer[0] = 'N';
				USB_Tx_Buffer[1] = 'A';
				USB_Tx_Buffer[2] = 'K';
				USB_Tx_Buffer[3] = '\n';
				USB_Tx_Buffer[4] = '>';
				USB_Tx_Length = 5;
				USB_Tx_Request = 1;
				*/
			}

			// Clean up states
			CMD_Rx_Valid = 0;
			CMD_Rx_Length = 0;
		}	
	}
}

