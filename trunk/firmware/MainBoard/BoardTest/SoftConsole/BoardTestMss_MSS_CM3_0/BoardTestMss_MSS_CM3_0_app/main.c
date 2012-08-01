#include <mss_spi.h>
#include <mss_gpio.h>
#include <stdio.h>

#define TETON_I2C_ADDR 0x01u
#define JOSHUA_I2C_ADDR (0x50u << 1) // 1010 000
//#define JOSHUA_I2C_ADDR 0xF0u

uint8_t wr_buf[2];
uint8_t rd_buf[1];


void GPIO1_IRQHandler( void )
{
	if ( MSS_GPIO_get_outputs() & MSS_GPIO_0_MASK )
	{
		MSS_GPIO_set_output( MSS_GPIO_0, 0 );
	}
	else
	{
		MSS_GPIO_set_output( MSS_GPIO_0, 1 );
	}
	MSS_GPIO_clear_irq( MSS_GPIO_1 );
}

int main()
{
	//const uint8_t frame_size = 8;
	//const uint8_t master_tx_frame = 0xDEu;
	uint8_t ctr = 0;
	uint8_t tx_frame = ',';

	// Set up GPIOs
	MSS_GPIO_init( );
	MSS_GPIO_config( MSS_GPIO_0, MSS_GPIO_OUTPUT_MODE );
	MSS_GPIO_set_output( MSS_GPIO_0, 0 );

	MSS_GPIO_config ( MSS_GPIO_1, MSS_GPIO_INPUT_MODE | MSS_GPIO_IRQ_EDGE_POSITIVE );
	//MSS_GPIO_config ( MSS_GPIO_1, MSS_GPIO_INPUT_MODE | MSS_GPIO_IRQ_LEVEL_HIGH );
	MSS_GPIO_enable_irq( MSS_GPIO_1 );
	NVIC_EnableIRQ( GPIO1_IRQn );

	// Initialize SPI master

	/*
	MSS_SPI_init( &g_mss_spi0 );
	MSS_SPI_configure_master_mode
	(
		&g_mss_spi0,
		MSS_SPI_SLAVE_0,
		MSS_SPI_MODE0,
		MSS_SPI_PCLK_DIV_128,
		frame_size
	);
	MSS_SPI_enable( &g_mss_spi0 );
	*/

	char obuf[32];
	while( 1 )
	{
		// Periodically send a character
		int i;
		for (i = 0; i < 100000; i++);

		tx_frame = (uint8_t)'0' + ctr;

		/*
		MSS_SPI_set_slave_select( &g_mss_spi0, MSS_SPI_SLAVE_0 );
		MSS_SPI_transfer_frame( &g_mss_spi0, tx_frame );
		MSS_SPI_clear_slave_select( &g_mss_spi0, MSS_SPI_SLAVE_0 );
		*/

		sprintf(obuf, "Hejje-hujja N: %c", tx_frame);
		puts(obuf);

		ctr = (ctr + 1) % 10;
	}
}
