/*
 * io_ports.c
 *
 *  Created on: Nov 14, 2011
 *      Author: babjak
 */

#include "flags.h"
#include "io_ports.h"

#define OUTBUFF_ENABLE_MASK	0x4
#define OUTREG_ENABLE_MASK	0x1


void io_ports_init()
{
	uint8_t	i;

	for (i=0; i<32; i++)
		(*((uint32_t*)(COREGPIO_0 + i*4))) = OUTBUFF_ENABLE_MASK | OUTREG_ENABLE_MASK;

}


void send_SPI(uint32_t data, uint8_t data_size)
{
/*
	GPIO_SCLK
	GPIO_SEN_RX
	GPIO_SDI
*/

	uint32_t mask = 0x00000001;
	mask = mask << (data_size - 1);

	ResetFlag((flags_t*) GPIO_OUTPUT, GPIO_SCLK);
	ResetFlag((flags_t*) GPIO_OUTPUT, GPIO_SEN_RX);

	while (mask)
	{
		SetFlagVal((flags_t*) GPIO_OUTPUT, GPIO_SDI, (data & mask) ? 1 : 0);

		SetFlag((flags_t*) GPIO_OUTPUT, GPIO_SCLK);
		ResetFlag((flags_t*) GPIO_OUTPUT, GPIO_SCLK);

		mask = mask >> 1;
	}

	SetFlag((flags_t*) GPIO_OUTPUT, GPIO_SEN_RX);

}
