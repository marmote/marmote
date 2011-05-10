#include "drivers\mss_gpio\mss_gpio.h"
#include "drivers\mss_pdma\mss_pdma.h"
//#include <inttypes.h>

#define ADC_MEM_ADDRESS_BASE	0x40050000
#define ADC_MEM_ADDRESS_DATA	(0x00+ADC_MEM_ADDRESS_BASE)
#define ADC_MEM_ADDRESS_COUNTER	(0x04+ADC_MEM_ADDRESS_BASE)

#define BUFF_LENGTH 32

#define NB_OF_SAMPLE_BUFFERS    2
//#define FREE_BUFFER         0
//#define UNDER_DMA_CONTROL   1
//#define DATA_READY          2


unsigned char current_buf;
unsigned char next_sample;
uint32_t	buffer[NB_OF_SAMPLE_BUFFERS][BUFF_LENGTH];
//uint8_t		buffer_status[NB_OF_SAMPLE_BUFFERS];

__attribute__ ((interrupt)) void Fabric_IRQHandler(void)
{
//    MSS_GPIO_clear_irq( MSS_GPIO_22 );
	NVIC_ClearPendingIRQ(Fabric_IRQn);

	uint32_t temp = *((uint32_t*) ADC_MEM_ADDRESS_COUNTER);

	buffer[current_buf][next_sample] = temp;

	next_sample++;

	if (next_sample >= BUFF_LENGTH)
	{
		next_sample = 0;

		current_buf = (current_buf + 1) % 2;
	}
}


/*==============================================================================
 *
 */
void pdma_handler( void )
{
//	PDMA_disable_irq( PDMA_CHANNEL_0 );

	current_buf = (current_buf + 1) % 2;

//	PDMA_start
//        (
//           PDMA_CHANNEL_0,
//            /* Read PPE_PDMA_DOUT */
//            (uint32_t) PDMA_ACE_PPE_DATAOUT,
//            /* This is in MSS ESRAM */
//            (uint32_t)g_samples_buffer[g_pdma_buffer_idx],
//            SAMPLES_BUFFER_SIZE
//        );

//    PDMA_enable_irq( PDMA_CHANNEL_0 );
}



int main()
{
	current_buf = 0;
	next_sample = 0;


    PDMA_init();

    PDMA_configure
    (
    	PDMA_CHANNEL_0,
    	PDMA_FROM_FPGA_0,
        PDMA_HIGH_PRIORITY | PDMA_WORD_TRANSFER | PDMA_INC_DEST_FOUR_BYTES,
        0
    );


    PDMA_set_irq_handler( PDMA_CHANNEL_0, pdma_handler );
    PDMA_enable_irq( PDMA_CHANNEL_0 );
    NVIC_EnableIRQ( DMA_IRQn );

/*    for ( unsigned int i = 0; i < NB_OF_SAMPLE_BUFFERS; ++i )
    {
        buffer_status[i] = FREE_BUFFER;
    }

    buffer_status[current_buf] = UNDER_DMA_CONTROL;*/

    PDMA_start
    (
        PDMA_CHANNEL_0,
        /* Read PPE_PDMA_DOUT */
        (uint32_t) ADC_MEM_ADDRESS_COUNTER,
        /* This is in MSS ESRAM */
        (uint32_t) &(buffer[current_buf][0]),
        BUFF_LENGTH
    );


	 /*Initialize and Configure GPIO*/
//	    MSS_GPIO_init();
//	    MSS_GPIO_config( MSS_GPIO_31 , MSS_GPIO_OUTPUT_MODE );


//	    MSS_GPIO_config( MSS_GPIO_22, MSS_GPIO_INPUT_MODE | MSS_GPIO_IRQ_EDGE_POSITIVE );
//		MSS_GPIO_enable_irq( MSS_GPIO_22 );

//    NVIC_EnableIRQ(Fabric_IRQn);

	while(1)
	{
	}

    return 0;
}
