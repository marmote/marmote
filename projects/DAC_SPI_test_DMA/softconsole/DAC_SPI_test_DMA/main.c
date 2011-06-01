// **************************************************************************
// Firmware and other Includes
// **************************************************************************
#include "CMSIS/a2fxxxm3.h"

#include "top_hw_platform.h"

#include "drivers\mss_gpio\mss_gpio.h"
#include "drivers\mss_pdma\mss_pdma.h"


// **************************************************************************
// Preprocessor Macros
// **************************************************************************
#define DAC_MEM_ADDRESS_DATA		(0x00+SPI_APB_DAC_0)
#define DAC_MEM_ADDRESS_CONTROL		(0x04+SPI_APB_DAC_0)
#define DAC_MEM_ADDRESS				DAC_MEM_ADDRESS_DATA

#define SDO2						0x0800
#define SDO1						0x0400
#define DSY							0x0200
#define HCLR						0x0100
#define SCLK						0x0080

#define BUFF_LENGTH 32

#define NB_OF_SAMPLE_BUFFERS	3 //MIN 3 !!!!!!!


// **************************************************************************
// Declaration of global variables
// **************************************************************************
unsigned char last_data_written = 1;

uint8_t		DMA_buf = 0;
uint8_t		next_DMA_buf = 1;
uint8_t		NET_buf = 0;
uint32_t	buffer[NB_OF_SAMPLE_BUFFERS][BUFF_LENGTH];


// **************************************************************************
// Functions
// **************************************************************************
void next_DMA_transfer()
{
	PDMA_load_next_buffer(PDMA_CHANNEL_0,
            (uint32_t) &(buffer[next_DMA_buf][0]),
			(uint32_t) DAC_MEM_ADDRESS,
            BUFF_LENGTH);
}


// **************************************************************************
// Functions for Interrupt Handlers
// **************************************************************************
void pdma_handler( void )
{
//	PDMA_disable_irq( PDMA_CHANNEL_0 );

	DMA_buf = next_DMA_buf;

	uint8_t next_buf = (next_DMA_buf + 1) % NB_OF_SAMPLE_BUFFERS;
	if (next_buf != NET_buf)
		next_DMA_buf = next_buf;

	next_DMA_transfer();

//    PDMA_enable_irq( PDMA_CHANNEL_0 );
}


void data_recv_callback_fn()
{
	if (last_data_written)
		return;

	last_data_written = 1;
	NET_buf = (NET_buf + 1) % NB_OF_SAMPLE_BUFFERS;
}


#define		MAX_VAL	0x0FFF
void receive_buffer(uint32_t* buff, uint32_t length)
{
	static uint16_t counter = 0;

	int i;
	for (i = 0; i < length; i++)
	{
		buff[i] = ((MAX_VAL - counter) << 16) + counter;
//		buff[i] = 0;
//		buff[i] = (0xAAA << 16) + 0xAAA;

		counter = (counter + 1) % (MAX_VAL + 1);
	}

	data_recv_callback_fn();
}

// **************************************************************************
// Init functions
// **************************************************************************
void init_DMA()
{
    PDMA_init();

    PDMA_configure(PDMA_CHANNEL_0,
    	PDMA_TO_FPGA_0,
        PDMA_HIGH_PRIORITY | PDMA_WORD_TRANSFER | PDMA_INC_SRC_FOUR_BYTES,
        0);

    PDMA_set_irq_handler( PDMA_CHANNEL_0, pdma_handler );
    PDMA_enable_irq( PDMA_CHANNEL_0 );
//    NVIC_EnableIRQ( DMA_IRQn );
}


// ****************************************************************
// Entry to Main form user boot code
// ****************************************************************
int main()
{
//Init DAC
	*((uint32_t*) DAC_MEM_ADDRESS_CONTROL) = 0xD000 | SDO2 | SDO1 /*| DSY*/ /*| HCLR*/ /*| SCLK*/;

//PDMA
	init_DMA();

	PDMA_start(PDMA_CHANNEL_0,
            (uint32_t) &(buffer[DMA_buf][0]),
			(uint32_t) DAC_MEM_ADDRESS,
            BUFF_LENGTH);

	next_DMA_transfer();

	while(1)
	{
        // if we have stuff to write AND last data is already sent AND we have a live connection
        if (NET_buf != DMA_buf && last_data_written)
        {
        	last_data_written = 0;
        	receive_buffer(&(buffer[NET_buf][0]), BUFF_LENGTH);
        }
	}

    return 0;
}
