#include "stm32f10x_conf.h"
#include "stm32f10x.h"

#include "power_board.h"

#include "usb_istr.h"
#include "usb_pwr.h"


#include "usb_lib.h"

uint8_t USB_Tx_Request; 
uint32_t ctr;
uint32_t it;

uint8_t CMD_Rx_Buffer[32];
uint8_t CMD_Rx_Length;
uint8_t CMD_Rx_Valid;


static uint8_t USB_Tx_Buffer[1];
static uint8_t USB_Tx_Length;

void TIM2_IRQHandler(void)
{
	if (TIM_GetITStatus(TIM2, TIM_IT_Update) == SET)
	{
		LED_Toggle(LED1);
		ctr++;
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

		   		
int main (void) {

	NVIC_InitTypeDef NVIC_InitStructure;
  	NVIC_PriorityGroupConfig(NVIC_PriorityGroup_1);

	LED_Init();			
	PowerControl_Init();   
	
	// Configure SysTick
	SysTick->CTRL |= (SysTick_CTRL_CLKSOURCE_Msk | SysTick_CTRL_TICKINT_Msk | SysTick_CTRL_ENABLE_Msk);
	SysTick->LOAD = 72000;	

	//USB_SoftReset();

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
				
	while (1)
	{		
		if (CMD_Rx_Valid == 1)
		{
			LED_Toggle(LED2);
		}	
	}
}

