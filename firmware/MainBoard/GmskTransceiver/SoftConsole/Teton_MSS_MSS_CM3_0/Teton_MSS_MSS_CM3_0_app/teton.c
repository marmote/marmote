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
	sfd_it_flag = 1;
}

// RX DONE
void GPIO10_IRQHandler(void)
{
	MSS_GPIO_clear_irq( MSS_GPIO_RX_DONE_IT );
	rx_done_it_flag = 1;
}
