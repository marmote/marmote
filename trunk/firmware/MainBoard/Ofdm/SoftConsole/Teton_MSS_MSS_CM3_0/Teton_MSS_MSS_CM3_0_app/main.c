
#include <string.h>
#include <mss_gpio.h>
#include <mss_rtc.h>

#include "yellowstone.h"
#include "teton.h"

extern uint8_t spi_cmd_buf[];
extern uint8_t spi_cmd_length;

#include "cmd_def.h"

int main()
{
	MSS_GPIO_init();
	Yellowstone_init();
	Max19706_init(MSS_SPI_SLAVE_1);
	Joshua_init();
	Teton_init();

	Max2830_set_tx_bandwidth(12000uL);
	Max2830_set_frequency(2405000000uL);
	Max2830_set_tx_gain(0);

	set_mode(RADIO_STANDBY_MODE);

	TX_CTRL->PTRN = PTRN_DEFAULT;
	TX_CTRL->GAIN = 3;

	while (1)
	{
		if (spi_cmd_length > 0)
		{
			process_spi_cmd_buf((const char*)spi_cmd_buf, spi_cmd_length);
			spi_cmd_length = 0;
		}

		if (tx_done_it_flag)
		{
			tx_done_it_flag = 0;
		}
	}
}


void Timer1_IRQHandler(void)
{
	if (TX_CTRL->CTRL & 0x4u)
	{
		TX_CTRL->CTRL &= ~0x4u;
		MSS_GPIO_set_output(MSS_GPIO_LED1, 0);
	}
	else
	{
		TX_CTRL->CTRL |= 0x4u | 0x2u;
		MSS_GPIO_set_output(MSS_GPIO_LED1, 1);
	}
	MSS_TIM1_clear_irq();
}
