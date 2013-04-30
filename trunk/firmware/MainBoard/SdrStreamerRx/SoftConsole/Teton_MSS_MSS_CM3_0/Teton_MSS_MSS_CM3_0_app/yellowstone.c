
#include "yellowstone.h"

enum { spi_frame_size = 8 };
enum { spi_rx_buffer_size = 32 };

uint8_t spi_rx_buffer[spi_rx_buffer_size];
uint8_t spi_rx_buffer_start = 0;
uint8_t spi_rx_buffer_count = 0;
uint8_t rx_data;

uint8_t spi_cmd_buf[spi_rx_buffer_size];


void Yellowstone_Init(void)
{
	// MSS_GPIO_init( );
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
		spi_frame_size
	);
	MSS_SPI_enable( &g_mss_spi0 );

	MSS_GPIO_config ( MSS_GPIO_SPI_0_IT, MSS_GPIO_INPUT_MODE | MSS_GPIO_IRQ_LEVEL_HIGH );
	MSS_GPIO_enable_irq( MSS_GPIO_SPI_0_IT );
	NVIC_EnableIRQ( MSS_GPIO_SPI_0_IT_IRQn );
}

void Yellowstone_write( const char* data, uint8_t length )
{
	uint8_t i;

	for ( i = 0; i < length; i++ )
	{
		MSS_SPI_set_slave_select( &g_mss_spi0, MSS_SPI_SLAVE_0 );
		rx_data = MSS_SPI_transfer_frame( &g_mss_spi0, *(data+i) );
		MSS_SPI_clear_slave_select( &g_mss_spi0, MSS_SPI_SLAVE_0 );
	}
}

void Yellowstone_print( const char* data )
{
	unsigned int length = strlen(data);
	Yellowstone_write( data, length );
	Yellowstone_write( '\n', 1 );
}

void GPIO28_IRQHandler( void ) // TODO: rename to SPI_0_IRQHandler
{
	MSS_SPI_set_slave_select( &g_mss_spi0, MSS_SPI_SLAVE_0 );
	rx_data = MSS_SPI_transfer_frame( &g_mss_spi0, '.' );
	MSS_SPI_clear_slave_select( &g_mss_spi0, MSS_SPI_SLAVE_0 );

	uint8_t end = (spi_rx_buffer_start + spi_rx_buffer_count) % spi_rx_buffer_size;
	spi_rx_buffer[end] = rx_data;

	if ( spi_rx_buffer_count != spi_rx_buffer_size )
	{
		spi_rx_buffer_count++;
	}

	//cmd_length = 0;
	if ( spi_rx_buffer[end] == '\n' )
	{
		uint8_t i;
		for ( i = 0; i < spi_rx_buffer_count-1; i++ )
		{
			spi_cmd_buf[i] = spi_rx_buffer[(spi_rx_buffer_start + i) % spi_rx_buffer_size];
		}
		spi_cmd_buf[spi_rx_buffer_count-1] = '\0';
		spi_cmd_length = spi_rx_buffer_count;

		spi_rx_buffer_start = spi_cmd_length % spi_rx_buffer_size;
		spi_rx_buffer_count = 0;
	}

	MSS_GPIO_clear_irq( MSS_GPIO_SPI_0_IT );
}
