#include "mss_gpio.h"
#include "mss_spi.h"

#include "Max2830.h"



void set_GPIO(Max2830_GPIO_t GPIOpin, uint8_t value)
//void SetGPIO(uint8_t GPIOpin, uint8_t value)
{
	if (value == MAX2830_nSHDN)
		MSS_GPIO_set_output(MSS_GPIO_13, value);
	else if (value == MAX2830_RXHP)
		MSS_GPIO_set_output(MSS_GPIO_14, value);
	else if (value == MAX2830_ANTSEL)
		MSS_GPIO_set_output(MSS_GPIO_15, value);
	else if (value == MAX2830_RXTX)
		MSS_GPIO_set_output(MSS_GPIO_28, value);
}

void send_SPI(uint32_t tx_frame)
{
	uint32_t			rx_frame;

	MSS_SPI_set_slave_select(&g_mss_spi1, MSS_SPI_SLAVE_0);
	rx_frame = MSS_SPI_transfer_frame(&g_mss_spi1, tx_frame);
	MSS_SPI_clear_slave_select(&g_mss_spi1, MSS_SPI_SLAVE_0);
}

void GPIO12_IRQHandler()
{
//    do_interrupt_processing();
    MSS_GPIO_clear_irq(  MSS_GPIO_12 );
}

int main()
{
//////////////////////////////////////////////////////
// GPIO init
	MSS_GPIO_init();

	//LD
	MSS_GPIO_config(MSS_GPIO_12, MSS_GPIO_INPUT_MODE | MSS_GPIO_IRQ_EDGE_BOTH);

	//nSHDN
	MSS_GPIO_config(MSS_GPIO_13, MSS_GPIO_OUTPUT_MODE);

	//RXHP
	MSS_GPIO_config(MSS_GPIO_14, MSS_GPIO_OUTPUT_MODE);

	//ANTSEL
	MSS_GPIO_config(MSS_GPIO_15, MSS_GPIO_OUTPUT_MODE);

	//RXTX
	MSS_GPIO_config(MSS_GPIO_28, MSS_GPIO_OUTPUT_MODE);


	MSS_GPIO_enable_irq(MSS_GPIO_12);


//////////////////////////////////////////////////////
// SPI init
	MSS_SPI_init(&g_mss_spi1);

	MSS_SPI_configure_master_mode( &g_mss_spi1,
									MSS_SPI_SLAVE_0,
									MSS_SPI_MODE0,
									MSS_SPI_PCLK_DIV_256,
									18 );

//	MSS_SPI_enable(&g_mss_spi1);

//////////////////////////////////////////////////////
// Max2830 init
// !!!!!!!! WARNING! MUST BE PRECEDED BY PROPER SPI AND GPIO INITIALIZATION!!!!!!!!!!!!!
	Max2830_Init();

	Max2830_Set_RXTX(MAX2830_TX_MODE);



//////////////////////////////////////////////////////
	while( 1 )
	{
		Max2830_Set_Frequency(2437000000);

		Max2830_Set_TX_Attenuation(0);

	}
}
