#include "teton.h"

// TX DONE
void GPIO8_IRQHandler(void)
{
	MSS_GPIO_clear_irq( MSS_GPIO_TX_DONE_IT );
	MSS_GPIO_set_output(MSS_GPIO_LED1, 0);
}

// SFD
void GPIO9_IRQHandler(void)
{
	MSS_GPIO_clear_irq( MSS_GPIO_SFD_IT );
	MSS_GPIO_set_output(MSS_GPIO_LED1, 1);
//	while(1);
}

// RX DONE
void GPIO10_IRQHandler(void)
{
	MSS_GPIO_clear_irq( MSS_GPIO_RX_DONE_IT );
	if ( MSS_GPIO_get_outputs() & MSS_GPIO_LED1_MASK )
	{
		MSS_GPIO_set_output(MSS_GPIO_LED1, 0);
	}
	else
	{
		MSS_GPIO_set_output(MSS_GPIO_LED1, 1);
	}
}
