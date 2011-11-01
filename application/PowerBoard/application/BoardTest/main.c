
#include "stm32f10x_conf.h"
#include "stm32f10x.h"


volatile uint32_t msTicks;                       /* timeTicks counter */

void SysTick_Handler(void) {
	msTicks++;                                     /* increment timeTicks counter */
}

static void Delay (uint32_t dlyTicks) {
	uint32_t curTicks = msTicks;

	while ((msTicks - curTicks) < dlyTicks);
	//uint32_t i;
	//for (i = 0 ; i < 3600000 ; i++);
}

static void LED_Config(void) {
	// Enable peripheral clock
	RCC->APB2ENR |= RCC_APB2ENR_IOPBEN;

	// Configure LED2
	// Open-drain (CNF[1:0] = 01), 2 MHz mode (MODE[1:0] = 10)
	GPIOB->BSRR = (uint32_t)1 << 2;
	GPIOB->CRL = (uint32_t)0x06 << 8;
}

static void LED_On (uint32_t led) {
	// Turn LED2 ON
	GPIOB->BRR = (uint32_t)1 << 2;
}

static void LED_Off (uint32_t led) {
	// Turn LED2 OFF
	GPIOB->BSRR = (uint32_t)1 << 2;
}


int main (void) {
						
	uint32_t d;
	uint32_t i;

	GPIO_InitTypeDef GPIO_InitStructure; 

	// Put the clock configuration into RCC_APB2PeriphClockCmd 
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA, ENABLE); 
	/* Output clock on MCO pin ---------------------------------------------*/ 
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_8; 
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_PP; 
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz; 
	GPIO_Init(GPIOA, &GPIO_InitStructure); 

	// Set breakpoints here to check MCO output
	RCC_MCOConfig(RCC_MCO_HSI); // Put on MCO pin the: freq. of external crystal 
    RCC_MCOConfig(RCC_MCO_HSE);
	RCC_MCOConfig(RCC_MCO_PLLCLK_Div2);				   
	RCC_MCOConfig(RCC_MCO_SYSCLK);  // Put on MCO pin the: System clock selected  


//	RCC->APB2ENR |= RCC_APB2ENR_AFIOEN;

	// Enable AFIO clock
//	RCC->APB2ENR |= RCC_APB2ENR_AFIOEN;
//	GPIOA->CRL &= GPIO_CRH_CNF8_0;
//	GPIOA->CRL |= GPIO_CRH_CNF8_1;   // PA8 to MCO (alternate function)

	//SysTick_Type SysTick_InitStructure;
	//SysTick_InitStructure.

	SysTick->CTRL |= (SysTick_CTRL_CLKSOURCE_Msk | SysTick_CTRL_TICKINT_Msk | SysTick_CTRL_ENABLE_Msk);
	//SysTick->CTRL |= (SysTick_CTRL_ENABLE_Pos);
	
	LED_Config();				

	while (1)
	{
		LED_On(0x100);                              /* Turn  on the LED   */
		Delay(500);     
		//for (i = 0 ; i < d ; i++);                            /* delay  100 Msec    */
		LED_Off(0x100);                             /* Turn off the LED   */
		Delay(500);                                 /* delay  100 Msec    */
		//for (i = 0 ; i < d ; i++);
	}
}

