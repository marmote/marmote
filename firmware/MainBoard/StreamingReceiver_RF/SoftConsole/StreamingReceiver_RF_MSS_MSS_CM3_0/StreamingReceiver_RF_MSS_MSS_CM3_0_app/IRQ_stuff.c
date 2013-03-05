#include "StreamingReceiver_RF_hw_platform.h"
#include "IRQ_stuff.h"
#include "MessageFormat.h"
#include "a2fxxxm3.h"
#include <stdint.h>


extern			uint8_t		buffer[];
extern			uint16_t	buffer_size; //in bytes
				volatile uint8_t * volatile	p_WR;
extern 			volatile uint8_t * volatile	p_RD;


// **************************************************************************
// **************************************************************************
// *																		*
// *							Functions									*
// *																		*
// *																		*
// **************************************************************************
char read_byte_from_USB(volatile uint8_t * volatile	p)
{
	uint32_t temp = *((volatile uint32_t*) SAMPLE_APB_0);

	if ((temp & 0x80000000) == 0)
		return 1;

	*p = (uint8_t) temp;

	return 0;
}


// **************************************************************************
// **************************************************************************
// *																		*
// *				Functions for Interrupt Handlers						*
// *																		*
// *																		*
// **************************************************************************
__attribute__ ((interrupt)) void Fabric_IRQHandler()
{
	if (read_byte_from_USB(p_WR))
		goto end_of_handler;

	volatile uint8_t* volatile p_temp = p_WR + 1;

	if (p_temp >= buffer + BUF_LENGTH)
		p_temp = buffer;

	if (p_RD != p_temp)
		p_WR = p_temp;

end_of_handler:
	return;
//	NVIC_ClearPendingIRQ(Fabric_IRQn);
}


// **************************************************************************
// **************************************************************************
// *																		*
// *							Init functions								*
// *																		*
// *																		*
// **************************************************************************

void init_IRQ_stuff(/*uint8_t* buff, uint16_t buff_size*/)
{
	p_WR 		= buffer;

	NVIC_EnableIRQ(Fabric_IRQn);

	Fabric_IRQHandler();
}
