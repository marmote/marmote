
#include <string.h>
#include <mss_gpio.h>
#include <mss_rtc.h>

#include "yellowstone.h"
#include "teton.h"

#include "cmd_def.h"

static packet_t pkt;
//static packet_t ack_pkt;

extern uint8_t spi_cmd_buf[];
extern uint8_t spi_cmd_length;

char* 		cmd_token;
CMD_Type* 	cmd_list_ptr;
char* 		arg_list[10];
uint32_t 	argc;

void process_spi_cmd_buf(const char* cmd_buf, uint8_t length);

int main()
{
	char buf[128];
	char rx_buf[128];
	uint8_t rx_ctr;

	MSS_GPIO_init();
	Yellowstone_init();
	Max19706_init(MSS_SPI_SLAVE_1);
	Joshua_init();
	Teton_init();

	MSS_GPIO_set_output(MSS_GPIO_LED1, 0);
	MSS_GPIO_set_output(MSS_GPIO_LED1, 1);

	Max2830_set_frequency(2405000000uL);

	set_mode(RADIO_RX_MODE);
	BB_CTRL->MUX1 = MUX_PATH_RX;
	BB_CTRL->MUX2 = MUX_PATH_RX;


//	set_mode(RADIO_TX_MODE);
//
//	MSS_TIM1_init(MSS_TIMER_PERIODIC_MODE);
//	MSS_TIM1_load_background(20e6); // 1 s
//	MSS_TIM1_enable_irq();
//	MSS_TIM1_start();
//
//	BB_CTRL->MUX1 = MUX_PATH_TX;
//	BB_CTRL->MUX2 = MUX_PATH_TX;

	while( 1 )
	{
		if (spi_cmd_length > 0)
		{
			process_spi_cmd_buf((const char*)spi_cmd_buf, spi_cmd_length);
			spi_cmd_length = 0;
		}

//		if (tx_done_it_flag)
//		{
//			set_mode(RADIO_RX_MODE);
//		}

		if (sfd_it_flag)
		{
			sfd_it_flag = 0;
		}

		if (rx_done_it_flag)
		{
			rx_done_it_flag = 0;
			rx_ctr = 0;

			// Read FIFO
			Yellowstone_print("\r\n");
			while ((RX_CTRL->CTRL & RX_FIFO_EMPTY_BIT_MASK) == 0)
			{
				rx_buf[rx_ctr] = RX_CTRL->RX_FIFO;
				rx_ctr++;
			}

			// Print message content
			for (rx_ctr = 1; rx_ctr <= rx_buf[0]-sizeof(pkt.crc); rx_ctr++)
			{
				sprintf(buf, "%02X ", (unsigned)rx_buf[rx_ctr]);
				Yellowstone_print(buf);
			}
			// Check CRC
			if (!check_crc((packet_t*)rx_buf))
			{
				sprintf(buf, "#");
				Yellowstone_print(buf);
			}
		}
	}
}


void process_spi_cmd_buf(const char* cmd_buf, uint8_t length)
{
	uint8_t parse_result = 1;

	// Tokenize RX buffer content
	cmd_token = strtok((char *)spi_cmd_buf, " ");
	if (cmd_token != NULL)
	{
		cmd_list_ptr = CMD_List;
		while (cmd_list_ptr->CmdString)
	    {
	        if (!strcmp(cmd_token, (const char*)cmd_list_ptr->CmdString))
	        {
				// Set the argList pointers to tokens
	            argc = 0;

	            while ( cmd_token != NULL && argc < 10 )
	            {
	                arg_list[argc++] = cmd_token;
	                cmd_token = strtok(NULL, " ");
	            }

				Yellowstone_write("\nACK", 5);

				// Invoke associated command function
		        cmd_list_ptr->CmdFunction(argc, arg_list);

				parse_result = 0;
	            break;
	        }

			cmd_list_ptr++;
	    }
	}

	// Send NAK if no valid command identified
	if (parse_result == 1)
	{
		Yellowstone_write("\nNAK>", 5);
	}

	// Send '>' prompt
	Yellowstone_write("\nT>", 3);

	// Clean up states
	spi_cmd_length = 0;
}

static uint8_t ctr;
static uint8_t i;

void Timer1_IRQHandler(void)
{
	pkt.length = 6;
	for (i = 0; i < 4; i++)
	{
		pkt.payload[i] = ctr++;
	}
	set_packet_crc(&pkt);

	send_packet(&pkt);
	MSS_TIM1_clear_irq();
}
