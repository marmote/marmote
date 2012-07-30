//#include <mss_i2c.h>
#include <mss_spi.h>
#include <mss_gpio.h>

#define TETON_I2C_ADDR 0x01u
#define JOSHUA_I2C_ADDR (0x50u << 1) // 1010 000
//#define JOSHUA_I2C_ADDR 0xF0u

uint8_t wr_buf[2];
uint8_t rd_buf[1];

void slave_frame_handler( uint32_t rx_frame )
{
	//g_slave_rx_frame = rx_frame;
	//uint32_t gpio_outputs;

	if ( MSS_GPIO_get_outputs() & MSS_GPIO_0_MASK )
	{
		MSS_GPIO_set_output( MSS_GPIO_0, 0 );
	}
	else
	{
		MSS_GPIO_set_output( MSS_GPIO_0, 1 );
	}
}

int main()
{
	const uint16_t frame_size = 16u;
	const uint16_t slave_tx_frame = 0xBABEu;
	//uint16_t master_rx;

	MSS_GPIO_init( );
	MSS_GPIO_config( MSS_GPIO_0, MSS_GPIO_OUTPUT_MODE );
	MSS_GPIO_set_output( MSS_GPIO_0, 1 );

	MSS_SPI_init( &g_mss_spi0 );

	MSS_SPI_configure_slave_mode
		(
			&g_mss_spi0,
			MSS_SPI_MODE0, // TODO: check in datasheet
			MSS_SPI_PCLK_DIV_2,
			frame_size
		);

	MSS_SPI_set_slave_tx_frame( &g_mss_spi0, slave_tx_frame );

	MSS_SPI_set_frame_rx_handler( &g_mss_spi1, slave_frame_handler );

	MSS_SPI_enable( &g_mss_spi0 );


	/*
	mss_i2c_status_t status;

	MSS_I2C_init(
		&g_mss_i2c0,
		TETON_I2C_ADDR,
		MSS_I2C_PCLK_DIV_256
		);

	wr_buf[0] = 0; // ADDR
	wr_buf[1] = 0xF4; // DATA

	rd_buf[0] = 0;

	MSS_I2C_write(
		&g_mss_i2c0,
		JOSHUA_I2C_ADDR,
		wr_buf,
		2,
		MSS_I2C_RELEASE_BUS
		);

	status = MSS_I2C_wait_complete( &g_mss_i2c0 );

	if ( status != MSS_I2C_SUCCESS )
	{
		while (1);
	}

	int i;
	for (i = 0; i < 1000000; i++);

	MSS_I2C_write_read(
		&g_mss_i2c0,
		JOSHUA_I2C_ADDR,
		wr_buf, // addr
		1, // length of addr
		rd_buf,
		1,
		MSS_I2C_RELEASE_BUS
		);

	status = MSS_I2C_wait_complete( &g_mss_i2c0 );

		if ( status != MSS_I2C_SUCCESS )
		{
			while (1);
		}
	*/


	while( 1 )
	{
	}
}
