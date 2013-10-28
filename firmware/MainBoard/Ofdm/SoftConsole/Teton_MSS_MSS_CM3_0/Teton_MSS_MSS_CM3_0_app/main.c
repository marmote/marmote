
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

	fc = 2400000000uL;
	Max2830_set_tx_bandwidth(12000uL);
	Max2830_set_tx_gain(0);
	Max2830_set_frequency(fc);

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
	Max2830_set_frequency(fc);
	if (fc >= 2500000000uL)
	{
		fc = 2400000000uL;
	}
	else
	{
		fc +=  10000000uL; // +10 MHz
	}
	MSS_TIM1_clear_irq();
}
