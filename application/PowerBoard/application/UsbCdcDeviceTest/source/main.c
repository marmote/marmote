#include "stm32f10x_conf.h"
#include "stm32f10x.h"

#include "power_board.h"

#include "usb_istr.h"
#include "usb_pwr.h"


#include "usb_lib.h"

#include "cmd_def.h"

uint8_t USB_Tx_Request; 
uint32_t it;

uint8_t CMD_Rx_Buffer[32];
uint8_t CMD_Rx_Length;
uint8_t CMD_Rx_Valid;
uint8_t CMD_ParseResult;

#include "usb_desc.h"
uint8_t USB_Tx_Buffer[VIRTUAL_COM_PORT_DATA_SIZE];
uint8_t USB_Tx_Length;

void TIM2_IRQHandler(void)
{
	if (TIM_GetITStatus(TIM2, TIM_IT_Update) == SET)
	{
		LED_Toggle(LED1);
		TIM_ClearITPendingBit(TIM2, TIM_IT_Update);

		 //
		//USB_Tx_Buffer[0] = '!';
		//USB_Tx_Length = 1;
				
		//UserToPMABufferCopy(USB_Tx_Buffer, ENDP1_TXADDR, USB_Tx_Length);
		//SetEPTxCount(ENDP1, USB_Tx_Length);
		//SetEPTxValid(ENDP1);
	}
	else
	{
		LED_On(LED2);
		while(1);
	}
}

void USBWakeUp_IRQHandler(void)
{
	LED_On(LED2);
	while(1);
}

void USB_HP_CAN1_TX_IRQHandler()
{	
	LED_On(LED2);
	while(1);
}

void USB_LP_CAN1_RX0_IRQHandler()
{
	//LED_On(LED2);
	USB_Istr();
	//LED_Off(LED2);
	//while(1);
}

uint8_t i, j;		  
uint8_t CMD_ListLength;		   		

int main (void) {

	NVIC_InitTypeDef NVIC_InitStructure;
  	NVIC_PriorityGroupConfig(NVIC_PriorityGroup_1);
	
	LED_Init();			
	PowerControl_Init();   
	
	// Configure SysTick
	SysTick->CTRL |= (SysTick_CTRL_CLKSOURCE_Msk | SysTick_CTRL_TICKINT_Msk | SysTick_CTRL_ENABLE_Msk);
	SysTick->LOAD = 72000;	

	//Delay(200);
	USB_SoftReset();

  	// Select USBCLK source
  	RCC_USBCLKConfig(RCC_USBCLKSource_PLLCLK_1Div5);
	  	
  	// Enable the USB clock 
  	RCC_APB1PeriphClockCmd(RCC_APB1Periph_USB, ENABLE);	 

	// Configure USB interrupts
	NVIC_InitStructure.NVIC_IRQChannel = USB_LP_CAN1_RX0_IRQn;
  	NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 1;
  	NVIC_InitStructure.NVIC_IRQChannelSubPriority = 0;
  	NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;
  	NVIC_Init(&NVIC_InitStructure);

	Init_Timer();
	USB_Init();

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
				USB_Tx_Buffer[0] = 'A';
				USB_Tx_Buffer[1] = 'C';
				USB_Tx_Buffer[2] = 'K';
				USB_Tx_Buffer[3] = '\n';
				USB_Tx_Buffer[4] = '>';
				USB_Tx_Length = 5;
				USB_Tx_Request = 1;
			}
			else
			{			
				USB_Tx_Buffer[0] = 'N';
				USB_Tx_Buffer[1] = 'A';
				USB_Tx_Buffer[2] = 'K';
				USB_Tx_Buffer[3] = '\n';
				USB_Tx_Buffer[4] = '>';
				USB_Tx_Length = 5;
				USB_Tx_Request = 1;
			}

			// Clean up states
			CMD_Rx_Valid = 0;
			CMD_Rx_Length = 0;
		}	
	}
}

