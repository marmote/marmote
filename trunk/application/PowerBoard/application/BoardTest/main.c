#include "stm32f10x_conf.h"
#include "stm32f10x.h"

#include "power_board.h"


volatile uint32_t msTicks;                       /* timeTicks counter */

void SysTick_Handler(void) {
	msTicks++;                                     /* increment timeTicks counter */
}

static void Delay (uint32_t dlyTicks) {
	uint32_t curTicks = msTicks;

	while ((msTicks - curTicks) < dlyTicks);
}


int main (void) {
						

	GPIO_InitTypeDef GPIO_InitStructure; 

	// Put the clock configuration into RCC_APB2PeriphClockCmd 
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA, ENABLE); 

	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_8; 
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_PP; 
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz; 
	GPIO_Init(GPIOA, &GPIO_InitStructure); 

	// Set breakpoints here to check MCO output
	RCC_MCOConfig(RCC_MCO_HSI);
    RCC_MCOConfig(RCC_MCO_HSE);
	RCC_MCOConfig(RCC_MCO_PLLCLK_Div2);				   
	RCC_MCOConfig(RCC_MCO_SYSCLK); 

//	RCC->APB2ENR |= RCC_APB2ENR_AFIOEN;

	// Enable AFIO clock
	
//	RCC->APB2ENR |= RCC_APB2ENR_AFIOEN;
//	GPIOA->CRL &= GPIO_CRH_CNF8_0;
//	GPIOA->CRL |= GPIO_CRH_CNF8_1;   // PA8 to MCO (alternate function)
	
	LED_Init();	

	SysTick->CTRL |= (SysTick_CTRL_CLKSOURCE_Msk | SysTick_CTRL_TICKINT_Msk | SysTick_CTRL_ENABLE_Msk);
	SysTick->LOAD = 72000;	

	while (1)
	{
		LED_Toggle(LED1 | LED2);
		Delay(500);
	}
}

