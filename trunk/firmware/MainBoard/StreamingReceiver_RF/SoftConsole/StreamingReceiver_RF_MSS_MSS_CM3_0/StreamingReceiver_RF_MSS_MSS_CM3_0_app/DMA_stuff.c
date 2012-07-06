#include "mss_pdma.h"
#include "StreamingReceiver_RF_hw_platform.h"

#include "DMA_stuff.h"

//static			uint8_t*	buffer;
//static			uint16_t	buffer_size; //in bytes
extern			uint8_t		buffer[];
extern			uint16_t	buffer_size; //in bytes
volatile		uint8_t*	p_WR;
static			uint8_t*	p_WR_next;
extern volatile uint8_t*	p_RD;


// **************************************************************************
// **************************************************************************
//
// 								Functions
//
//
// **************************************************************************
void next_DMA_transfer()
{

	PDMA_load_next_buffer(PDMA_CHANNEL_0,
			(uint32_t) SAMPLE_APB_0,
            (uint32_t) p_WR_next,
            CHUNK_LENGTH);

}



// **************************************************************************
// **************************************************************************
//
// 					Functions for Interrupt Handlers
//
//
// **************************************************************************
void pdma_handler( void )
{
	p_WR = p_WR_next;

	uint8_t* p_temp = p_WR_next + CHUNK_LENGTH;
	if (p_temp + CHUNK_LENGTH >= buffer + buffer_size)
		p_temp = buffer;

	if (p_RD < p_temp || p_RD >= p_temp + CHUNK_LENGTH)
		p_WR_next = p_temp;

	next_DMA_transfer();
}



// **************************************************************************
// **************************************************************************
//
// 								Init functions
//
//
// **************************************************************************
void init_DMA()
{
    PDMA_init();

    PDMA_configure(PDMA_CHANNEL_0,
				PDMA_FROM_FPGA_0,
				PDMA_HIGH_PRIORITY | PDMA_BYTE_TRANSFER | PDMA_INC_DEST_ONE_BYTE,
				0);

    PDMA_set_irq_handler( PDMA_CHANNEL_0, pdma_handler );
    PDMA_enable_irq( PDMA_CHANNEL_0 );
}


void init_DMA_stuff(/*uint8_t* buff, uint16_t buff_size*/)
{
//	buffer 		= buff;
//	buffer_size = buff_size;

	p_WR 		= buffer;
	p_WR_next	= buffer + CHUNK_LENGTH;


	init_DMA();


	PDMA_start(PDMA_CHANNEL_0,
			(uint32_t) SAMPLE_APB_0,
            (uint32_t) p_WR_next,
            CHUNK_LENGTH);

	next_DMA_transfer();
}
