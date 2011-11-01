
#include "stm32f10x_conf.h"
#include "stm32f10x.h"


int main (void) {

	// Configure clock system	  (PLL)
	


	GPIO_InitTypeDef GPIO_InitStructure; 

	// Put the clock configuration into RCC_APB2PeriphClockCmd 
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA, ENABLE); 
	/* Output clock on MCO pin ---------------------------------------------*/ 
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_8; 
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_PP; 
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz; 
	GPIO_Init(GPIOA, &GPIO_InitStructure); 
	RCC_MCOConfig(RCC_MCO_HSI); // Put on MCO pin the: freq. of external crystal 
	RCC_MCOConfig(RCC_MCO_SYSCLK);  // Put on MCO pin the: System clock selected  
    RCC_MCOConfig(RCC_MCO_HSE);
	RCC_MCOConfig(RCC_MCO_PLLCLK_Div2);


//	RCC->APB2ENR |= RCC_APB2ENR_AFIOEN;

	// Enable AFIO clock
//	RCC->APB2ENR |= RCC_APB2ENR_AFIOEN;
//	GPIOA->CRL &= GPIO_CRH_CNF8_0;
//	GPIOA->CRL |= GPIO_CRH_CNF8_1;   // PA8 to MCO (alternate function)
	

	// Set breakpoints here to check MCO output
	  /* Perform Byte access to MCO bits to select the MCO source */
  	//*(__IO uint8_t *) CFGR_BYTE4_ADDRESS = RCC_MCO;
//	RCC->CFGR &= ~RCC_CFGR_MCO;
//	RCC->CFGR |= RCC_CFGR_MCO_HSI;
//
//	RCC->CFGR &= ~RCC_CFGR_MCO;
//	RCC->CFGR |= RCC_CFGR_MCO_SYSCLK;
//
//	RCC->CFGR &= ~RCC_CFGR_MCO;
//	RCC->CFGR |= RCC_CFGR_MCO_HSE;
//
//	RCC->CFGR &= ~RCC_CFGR_MCO;
//	RCC->CFGR |= RCC_CFGR_MCO_PLL;



	RCC->APB2ENR |= RCC_APB2ENR_IOPBEN;

	// Configure LED2
	// Open-drain (CNF[1:0] = 01), 2 MHz mode (MODE[1:0] = 10)
	GPIOB->BSRR = (uint32_t)1 << 2;
	GPIOB->CRL = (uint32_t)0x06 << 8;	 

	// Turn LED2 ON
	GPIOB->BRR = (uint32_t)1 << 2;

	while (1)
	{
		;
	}
}

