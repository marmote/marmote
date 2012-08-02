#include <mss_spi.h>
#include <mss_gpio.h>
#include <stdio.h>

#define TETON_I2C_ADDR 0x01u
#define JOSHUA_I2C_ADDR (0x50u << 1) // 1010 000
//#define JOSHUA_I2C_ADDR 0xF0u

enum { spi_rx_buffer_size = 8 };
uint8_t spi_rx_buffer[spi_rx_buffer_size];
uint8_t spi_rx_buffer_start = 0;
uint8_t spi_rx_buffer_count = 0;
uint8_t rx_data;

uint8_t cmd_buffer[spi_rx_buffer_size];
uint8_t cmd_done;

void GPIO1_IRQHandler( void )
{
	MSS_GPIO_set_output( MSS_GPIO_0, 1 );

	MSS_SPI_set_slave_select( &g_mss_spi0, MSS_SPI_SLAVE_0 );
	rx_data = MSS_SPI_transfer_frame( &g_mss_spi0, '.' );
	MSS_SPI_clear_slave_select( &g_mss_spi0, MSS_SPI_SLAVE_0 );

	uint8_t end = (spi_rx_buffer_start + spi_rx_buffer_count) % spi_rx_buffer_size;
	spi_rx_buffer[end] = rx_data;

	if ( spi_rx_buffer_count != spi_rx_buffer_size )
	{
		spi_rx_buffer_count++;
	}

	cmd_done = 0;
	if ( spi_rx_buffer[end] == '!' )
	{
		uint8_t i;
		for ( i = 0; i < spi_rx_buffer_count; i++ )
		{
			cmd_buffer[i] = spi_rx_buffer[spi_rx_buffer_start + i];
		}
		cmd_done = 1;
	}
	/*
	MSS_SPI_set_slave_select( &g_mss_spi0, MSS_SPI_SLAVE_0 );
	MSS_SPI_transfer_frame( &g_mss_spi0, rx_data+1 );
	MSS_SPI_clear_slave_select( &g_mss_spi0, MSS_SPI_SLAVE_0 );

	MSS_SPI_set_slave_select( &g_mss_spi0, MSS_SPI_SLAVE_0 );
	MSS_SPI_transfer_frame( &g_mss_spi0, '\n' );
	MSS_SPI_clear_slave_select( &g_mss_spi0, MSS_SPI_SLAVE_0 );
	*/

	//puts( (const char*)spi_rx_buffer );

	MSS_GPIO_set_output( MSS_GPIO_0, 0 );
	MSS_GPIO_clear_irq( MSS_GPIO_1 );
}




int main()
{
	const uint8_t frame_size = 8;
	//const uint8_t master_tx_frame = 0xDEu;
	uint8_t ctr = 0;
	uint8_t tx_frame = ',';	// Set up GPIOs
	MSS_GPIO_init( );
	MSS_GPIO_config( MSS_GPIO_0, MSS_GPIO_OUTPUT_MODE );
	MSS_GPIO_set_output( MSS_GPIO_0, 0 );

	// Initialize SPI master
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

	MSS_GPIO_config ( MSS_GPIO_1, MSS_GPIO_INPUT_MODE | MSS_GPIO_IRQ_LEVEL_HIGH );
	MSS_GPIO_enable_irq( MSS_GPIO_1 );
	NVIC_EnableIRQ( GPIO1_IRQn );;;;

	char obuf[32];
	while( 1 )
	{
		// Periodically send a character
		int i;
		for (i = 0; i < 1000000; i++);

		tx_frame = (uint8_t)'0' + ctr;

		/*
		MSS_SPI_set_slave_select( &g_mss_spi0, MSS_SPI_SLAVE_0 );
		MSS_SPI_transfer_frame( &g_mss_spi0, tx_frame );
		MSS_SPI_clear_slave_select( &g_mss_spi0, MSS_SPI_SLAVE_0 );
		*/

		sprintf(obuf, "N: %c", tx_frame);
		puts(obuf);

		ctr = (ctr + 1) % 10;
	}
}
