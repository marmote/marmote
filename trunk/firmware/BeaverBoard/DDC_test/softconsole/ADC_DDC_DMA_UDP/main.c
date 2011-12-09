#define NETWORKING_ENABLED	// Everything network related

#define ADC_ENABLED			// DMA to read from ADC
#define TIME_STAMP			// Shall we put time stamps on buffers?

#define CONTROL_ENABLED		// Radio front-end card control


// **************************************************************************
// **************************************************************************
//
// 								Standard Includes
//
//
// **************************************************************************

//#include <stdio.h>
//#include <stdlib.h>



// **************************************************************************
// **************************************************************************
//
// 							Firmware and other Includes
//
//
// **************************************************************************

#include "CMSIS/a2fxxxm3.h"

#ifdef ADC_ENABLED
#  include "drivers\mss_gpio\mss_gpio.h"
#  include "drivers\mss_pdma\mss_pdma.h"
#  include "top_hw_platform.h"
#endif

#ifdef CONTROL_ENABLED
#	include "drivers\mss_ace\mss_ace.h"
#	include "top_hw_platform.h"
#	include "RFX400.h"
#endif

#ifdef NETWORKING_ENABLED
#  include "./drivers/mss_ethernet_mac/mss_ethernet_mac.h"
#  include "./drivers/mss_timer/mss_timer.h"

#  include "lwip/opt.h"
#  include "lwip/sys.h"
#  include "lwip/mem.h"
#  include "lwip/memp.h"
#  include "lwip/ip.h"
#  include "lwip/udp.h"
#  include "lwip/dhcp.h"
#  include "lwip/init.h"
#  include "netif/etharp.h"

#  include "SmartFusionethernetif.h"
#  include "sampleserver.h"
#endif



// **************************************************************************
// **************************************************************************
//
// 								Preprocessor Macros
//
//
// **************************************************************************

#ifdef ADC_ENABLED
#  define ADC_MEM_ADDRESS_DATA		(0x00+SAMPLE_APB3_0)
//#  define ADC_MEM_ADDRESS_COUNTER	(0x04+SAMPLE_APB3_0)
#  define ADC_MEM_ADDRESS			ADC_MEM_ADDRESS_DATA
#endif

#ifdef CONTROL_ENABLED
#  define SHIFT_REG					(0x08+SAMPLE_APB3_0)
#  define DPHASE_REG				(0x0C+SAMPLE_APB3_0)
#  define DC_OFFSET_REG				(0x10+SAMPLE_APB3_0)
#endif

#ifdef NETWORKING_ENABLED

// Simple periodic polling function
#define PERIODIC(var,time,function) \
    if((System_ticks - var) > time) \
    {                               \
        var += time;                \
        function;                   \
    }                               \

#endif

//#define BUFF_LENGTH				TCP_SND_BUF/sizeof(uint32_t)
#define BUFF_LENGTH				128
#define NB_OF_SAMPLE_BUFFERS	3 //MIN 3 !!!!!!!



// **************************************************************************
// **************************************************************************
//
// 						Declaration of global variables
//
//
// **************************************************************************

#ifdef NETWORKING_ENABLED
static volatile uint64_t System_ticks = 0;

volatile unsigned char still_working_on_last_data = 0;
#endif

static volatile uint8_t		DMA_buf = 0;
static volatile uint8_t		next_DMA_buf = 1;
static volatile uint8_t		NET_buf = 0;
static volatile uint32_t	buffer[NB_OF_SAMPLE_BUFFERS][BUFF_LENGTH];

//Specifies how many bursts are to be sent over the network.
//The number is decreased after every successful burst transmit.
static volatile uint8_t		BurstCounter = 0;
//If BurstCounter is set to FAST_FLOOD, it will continuously send bursts.
#define	FAST_FLOOD			0xFF



// **************************************************************************
// **************************************************************************
//
// 							External Declarations
//
//
// **************************************************************************

#ifdef NETWORKING_ENABLED
// Returns the current time in milliseconds,
// may be the same as sys_jiffies or at least based on it.
u32_t sys_now(void)
{
	return (u32_t) System_ticks;
}
#else
//Dummy function
unsigned long sys_now()
{
	return 0;
}
#endif



// **************************************************************************
// **************************************************************************
//
// 								Functions
//
//
// **************************************************************************

#ifdef ADC_ENABLED
#	ifdef TIME_STAMP
void set_time_stamp(uint8_t buf_num)
{
	static uint32_t counter = 0;

    buffer[buf_num][0] = counter;

    counter++;

}
#	endif

void next_DMA_transfer()
{
#	ifdef TIME_STAMP
	PDMA_load_next_buffer(PDMA_CHANNEL_0,
			(uint32_t) ADC_MEM_ADDRESS,
            (uint32_t) &(buffer[next_DMA_buf][1]),
            BUFF_LENGTH-1);

#	else
	PDMA_load_next_buffer(PDMA_CHANNEL_0,
			(uint32_t) ADC_MEM_ADDRESS,
            (uint32_t) &(buffer[next_DMA_buf][0]),
            BUFF_LENGTH);
#	endif
}
#endif


#ifdef CONTROL_ENABLED
void BusyWait(uint64_t time_ms) //Wait for given millisecs
{
	uint64_t t_orig = System_ticks;

	while (1)
	{
		if (System_ticks - t_orig > time_ms)
			break;
	}
}

void SetRFinput(uint8_t input)
{
	RFX400SetInput(input);
}


void SetRFGain(uint32_t gain)
{
    ACE_set_sdd_value(SDD1_OUT, gain);
}


void SetRFFr(uint32_t frequency)
{
	RFX400InitFrequency(frequency);

	BusyWait(15);

	RFX400SetFrequency();
}


void SetDCoffset(int16_t DC_offsetI, int16_t DC_offsetQ)
{
	uint32_t temp =  (uint16_t) DC_offsetI;
	temp = temp << 16;
	temp = temp | (uint16_t) DC_offsetQ;

	*((uint32_t*) DC_OFFSET_REG ) = temp;
}


void SetDDCFr(double frequency)
{
	double Fs = 50000000.0/18.0;
	double phase_bit_width = 65536.0; //2^16

//	uint32_t dummy = (uint32_t) ((int16_t) (frequency * phase_bit_width / Fs));

	*((uint32_t*) DPHASE_REG ) = (uint32_t) ((int16_t) (frequency * phase_bit_width / Fs));
}

void SetDDCshift(uint8_t shift)
{
	if (shift > 11)
		shift = 11;

	*((uint32_t*) SHIFT_REG) = (uint32_t) shift;
}
#endif



// **************************************************************************
// **************************************************************************
//
// 					Functions for Interrupt Handlers
//
//
// **************************************************************************

#ifdef ADC_ENABLED
void pdma_handler( void )
{
#	ifdef TIME_STAMP
	set_time_stamp(DMA_buf);
#	endif

	DMA_buf = next_DMA_buf;

	uint8_t next_buf = (next_DMA_buf + 1) % NB_OF_SAMPLE_BUFFERS;
	if (next_buf != NET_buf)
		next_DMA_buf = next_buf;

	next_DMA_transfer();
}
#endif

#ifdef NETWORKING_ENABLED
void data_sent_callback_fn()
{
	if (!still_working_on_last_data)
		return;

	still_working_on_last_data = 0;
	NET_buf = (NET_buf + 1) % NB_OF_SAMPLE_BUFFERS;

	if (BurstCounter && BurstCounter != FAST_FLOOD)
		BurstCounter--;
}

void Timer1_IRQHandler( void )
{
    System_ticks++;
    MSS_TIM1_clear_irq();
}

#define COMMAND_ID_CONFIG_MSG		0x00
#define COMMAND_ID_FLOW_CONTROL_MSG	0x01

#define COMMAND_ID_WAITING_STATE		0
#define COMMAND_ID_CONFIG_STATE			1
#define COMMAND_ID_FLOW_CONTROL_STATE	2

#define CMD_SIZE	(1+4+4+2+2+4+1)

void receive_callback(void* data, u16_t len)
{
	static uint8_t	buffer[CMD_SIZE];
	static uint8_t	counter = CMD_SIZE;
	static char		state = COMMAND_ID_WAITING_STATE;

	u16_t i;
	for (i = 0; i < len; i++)
	{
		if (state == COMMAND_ID_WAITING_STATE)
		{
			if (*(((uint8_t*) data) + i) == COMMAND_ID_FLOW_CONTROL_MSG)
				state = COMMAND_ID_FLOW_CONTROL_STATE;
#ifdef CONTROL_ENABLED
			else if (*(((uint8_t*) data) + i) == COMMAND_ID_CONFIG_MSG)
				state = COMMAND_ID_CONFIG_STATE;
#endif
		}
#ifdef CONTROL_ENABLED
		else if (state == COMMAND_ID_CONFIG_STATE)
		{
			counter--;
			buffer[counter] = *(((uint8_t*) data) + i);

			if (counter == 0)
			{
				uint8_t input			=	buffer[17];
				uint32_t gain			=	*((uint32_t*) &(buffer[13]));
				uint32_t RFfrequency	=	*((uint32_t*) &(buffer[9]));
				int16_t DC_offsetI		=	*((int32_t*) &(buffer[7]));
				int16_t DC_offsetQ		=	*((int32_t*) &(buffer[5]));
				double DDCfrequency		=	(double) *(((int32_t*) &(buffer[1])));
				uint8_t shift			=	buffer[0];

				SetRFinput(input);
				SetRFGain(gain);
				SetRFFr(RFfrequency);
				SetDCoffset(DC_offsetI, DC_offsetQ);
				SetDDCFr(DDCfrequency);
				SetDDCshift(shift);

				counter = CMD_SIZE;

				state = COMMAND_ID_WAITING_STATE;
			}
		}
#endif
		else if (state == COMMAND_ID_FLOW_CONTROL_STATE)
		{
			BurstCounter = *(((uint8_t*) data) + i);

			NET_buf = DMA_buf;

			state = COMMAND_ID_WAITING_STATE;
		}
	}
}
#endif



// **************************************************************************
// **************************************************************************
//
// 								Init functions
//
//
// **************************************************************************

#ifdef ADC_ENABLED
void init_DMA()
{
    PDMA_init();

    PDMA_configure(PDMA_CHANNEL_0,
				PDMA_FROM_FPGA_0,
				PDMA_HIGH_PRIORITY | PDMA_WORD_TRANSFER | PDMA_INC_DEST_FOUR_BYTES,
				0);

    PDMA_set_irq_handler( PDMA_CHANNEL_0, pdma_handler );
    PDMA_enable_irq( PDMA_CHANNEL_0 );
}
#endif

#ifdef NETWORKING_ENABLED
void init_timing()
{
    SystemCoreClockUpdate();

    MSS_TIM1_init( MSS_TIMER_PERIODIC_MODE );
    MSS_TIM1_load_immediate( (uint32_t) (g_FrequencyPCLK0/1000) ); //Divide by 1000 means an interrupt at every 1/1000 sec = 1 msec
    MSS_TIM1_start();
    MSS_TIM1_enable_irq();
}
#endif



// ****************************************************************
// ****************************************************************
//
// 								Main
//
//
// ****************************************************************
int main()
{
#ifdef NETWORKING_ENABLED

	struct netif l_netif;                // the single network interface
	struct udp_pcb *pcb;

#  if LWIP_ARP
    uint64_t arp_timer = 0;
#  endif
#  if LWIP_DHCP
    uint64_t dhcp_fine_timer = 0;
    uint64_t dhcp_coarse_timer = 0;
#  endif

#endif


#ifdef ADC_ENABLED
    init_DMA();
#endif


#ifdef NETWORKING_ENABLED
    // Initialize hardware necessary for millisecond timing
    init_timing();

#ifdef CONTROL_ENABLED
    ACE_init();
    ACE_configure_sdd(SDD1_OUT, SDD_24_BITS, SDD_VOLTAGE_MODE | SDD_NON_RTZ , INDIVIDUAL_UPDATE );
    ACE_enable_sdd(SDD1_OUT);

	SetDCoffset(0, 0);
    SetDDCFr(1000);
    SetDDCshift(3);

    BusyWait(1); // WARNING!!! WITH RFX400 ATTACHED IT TAKES AT LEAST 170us FOR THE GPIO VOLTAGES TO REACH 3.3V
    RFX400init();

    SetRFinput(RFX400_TX_RX);
    SetRFGain(0);
    SetRFFr(426000000);
#endif

    // Initialize the lwIP stack
    lwip_init();

    // initialize the network interface
    ethernetif_init(&l_netif);

    // initialize the simple server
    pcb = server_init(49151);
#endif

#ifdef ADC_ENABLED
//	next_DMA_transfer(); //This would be ideal, but it doesn't work like this. This has to be after PDMA_start

#	ifdef TIME_STAMP
//    set_time_stamp(DMA_buf);

	PDMA_start(PDMA_CHANNEL_0,
			(uint32_t) ADC_MEM_ADDRESS,
            (uint32_t) &(buffer[DMA_buf][1]),
            BUFF_LENGTH-1);
#	else

	PDMA_start(PDMA_CHANNEL_0,
			(uint32_t) ADC_MEM_ADDRESS,
            (uint32_t) &(buffer[DMA_buf][0]),
            BUFF_LENGTH);
#	endif

	next_DMA_transfer();
#endif

    while (1)
    {
#ifdef NETWORKING_ENABLED

#  if LWIP_ARP
        PERIODIC(arp_timer, ARP_TMR_INTERVAL, etharp_tmr());
#  endif
#  if LWIP_DHCP
        PERIODIC(dhcp_fine_timer, DHCP_FINE_TIMER_MSECS, dhcp_fine_tmr());
        PERIODIC(dhcp_coarse_timer, DHCP_COARSE_TIMER_MSECS, dhcp_coarse_tmr());
#  endif

        ethernetif_input(&l_netif);
#endif

        // if we have stuff to write
        //AND last data is already sent
        //AND we have a live connection
        //AND BurstCounter indicates that receiver is still expecting bursts
        if (	(NET_buf != DMA_buf)
        		&&
        		!still_working_on_last_data
        		&&
        		pcb->remote_port
        		&&
        		BurstCounter)
        {
        	still_working_on_last_data = 1;
        	send_buffer(pcb, &(buffer[NET_buf][0]), BUFF_LENGTH*sizeof(uint32_t));

        	data_sent_callback_fn();
        }
    }

    return 0;
}
