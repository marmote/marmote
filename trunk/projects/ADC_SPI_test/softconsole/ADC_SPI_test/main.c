#include "drivers\mss_gpio\mss_gpio.h"
//#include <inttypes.h>

#define ADC_MEM_ADDRESS_BASE	0x40050000
#define ADC_MEM_ADDRESS_DATA	(0x00+ADC_MEM_ADDRESS_BASE)
#define ADC_MEM_ADDRESS_COUNTER	(0x04+ADC_MEM_ADDRESS_BASE)

#define CHANNELS	2
#define BUFF_LENGTH 32

unsigned char current_buf;
unsigned char channel;
unsigned char next_sample;
uint16_t buffer[CHANNELS][BUFF_LENGTH][2];


__attribute__ ((interrupt)) void Fabric_IRQHandler(void)
{
//    MSS_GPIO_clear_irq( MSS_GPIO_22 );
	NVIC_ClearPendingIRQ(Fabric_IRQn);

	uint32_t temp = *((uint32_t*) ADC_MEM_ADDRESS_COUNTER);

	buffer[0][next_sample][current_buf] = (uint16_t) (0x0000FFFF & temp);
	buffer[1][next_sample][current_buf] = (uint16_t) ((0xFFFF0000 & temp) >> 16);

	next_sample++;

	if (next_sample >= BUFF_LENGTH)
	{
		next_sample = 0;

		current_buf = (current_buf + 1) % 2;
	}
}


int main()
{
	current_buf = 0;
	next_sample = 0;

	 /*Initialize and Configure GPIO*/
//	    MSS_GPIO_init();
//	    MSS_GPIO_config( MSS_GPIO_31 , MSS_GPIO_OUTPUT_MODE );


//	    MSS_GPIO_config( MSS_GPIO_22, MSS_GPIO_INPUT_MODE | MSS_GPIO_IRQ_EDGE_POSITIVE );
//		MSS_GPIO_enable_irq( MSS_GPIO_22 );
		NVIC_EnableIRQ(Fabric_IRQn);

	while(1)
	{
	}

    return 0;
}
