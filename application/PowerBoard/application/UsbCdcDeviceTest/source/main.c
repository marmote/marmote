#include "stm32f10x_conf.h"
#include "stm32f10x.h"

#include "misc.h"
#include "stm32f10x_tim.h"

#include "usb_istr.h"

#include "power_board.h"

#include "usb_lib.h"


volatile uint32_t msTicks;                       /* timeTicks counter */

void SysTick_Handler(void) {
	msTicks++;                                     /* increment timeTicks counter */
}

static void Delay (uint32_t dlyTicks) {
	uint32_t curTicks = msTicks;

	while ((msTicks - curTicks) < dlyTicks);
}

void Init_Timer()
{						
						   
  	NVIC_InitTypeDef NVIC_InitStructure;
	TIM_TimeBaseInitTypeDef TIM_InitStructure;

  	NVIC_PriorityGroupConfig(NVIC_PriorityGroup_1);

	// Configure TIM1 OVF interrupts
	NVIC_InitStructure.NVIC_IRQChannel = TIM2_IRQn;
  	NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 1;
  	NVIC_InitStructure.NVIC_IRQChannelSubPriority = 0;
  	NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;
  	NVIC_Init(&NVIC_InitStructure);

	// Set peripheral clock sources
	RCC_APB1PeriphClockCmd(RCC_APB1Periph_TIM2, ENABLE);

	// Initialize peripheral
	TIM_InitStructure.TIM_Prescaler	= 7200; // 100 us at 72 MHz SysClk
	TIM_InitStructure.TIM_CounterMode = TIM_CounterMode_Down;
	TIM_InitStructure.TIM_Period = 10000;
	TIM_InitStructure.TIM_ClockDivision = TIM_CKD_DIV2;
	TIM_InitStructure.TIM_RepetitionCounter = 0;
	TIM_TimeBaseInit(TIM2, &TIM_InitStructure);					   
	
	TIM_ARRPreloadConfig(TIM2, ENABLE);
							
	TIM_ITConfig(TIM2, TIM_IT_Update, ENABLE);

	// Enable Peripheral
	TIM_Cmd(TIM2, ENABLE);
}

uint32_t ctr;
uint32_t it;

void TIM2_IRQHandler(void)
{
	if (TIM_GetITStatus(TIM2, TIM_IT_Update) == SET)
	{
		LED_Toggle(LED1);
		ctr++;
		TIM_ClearITPendingBit(TIM2, TIM_IT_Update);
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
		Delay(250);
		//LED_Toggle(LED2);	
	}
}

