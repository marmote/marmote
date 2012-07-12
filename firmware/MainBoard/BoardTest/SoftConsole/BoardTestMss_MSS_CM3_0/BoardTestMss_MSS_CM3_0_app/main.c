#include <mss_i2c.h>

#define TETON_I2C_ADDR 0x01u
#define JOSHUA_I2C_ADDR (0x50u << 1) // 1010 000
//#define JOSHUA_I2C_ADDR 0xF0u

uint8_t wr_buf[2];
uint8_t rd_buf[1];

int main()
{
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


	while( 1 )
	{
	}
}
