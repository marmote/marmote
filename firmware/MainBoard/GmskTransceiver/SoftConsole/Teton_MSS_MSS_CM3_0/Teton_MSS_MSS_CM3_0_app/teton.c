#include "teton.h"

void GPIO8_IRQHandler(void)
{
	MSS_GPIO_clear_irq( MSS_GPIO_TX_DONE_IT );
	MSS_GPIO_set_output(MSS_GPIO_LED1, 0);
}
