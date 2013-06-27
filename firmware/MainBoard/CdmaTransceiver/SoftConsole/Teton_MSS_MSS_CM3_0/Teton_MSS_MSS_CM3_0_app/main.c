
#include <string.h>
#include <mss_gpio.h>
#include <mss_rtc.h>

#include "yellowstone.h"
#include "teton.h"

#include "cmd_def.h"

static packet_t pkt;
static uint16_t seq_num;

extern uint8_t spi_cmd_buf[];
extern uint8_t spi_cmd_length;

char* 		cmd_token;
CMD_Type* 	cmd_list_ptr;
char* 		arg_list[10];
uint32_t 	argc;

void process_spi_cmd_buf(const char* cmd_buf, uint8_t length);

int main()
{
	MSS_GPIO_init();
	Yellowstone_init();
	Max19706_init(MSS_SPI_SLAVE_1);
	Joshua_init();
	Teton_init();

	Max2830_set_frequency(2405000000uL);
	Max2830_set_tx_gain(15);

	set_mode(RADIO_TX_MODE);
	BB_CTRL->MUX1 = MUX_PATH_TX;
	BB_CTRL->MUX2 = MUX_PATH_TX;

	MSS_TIM1_init(MSS_TIMER_PERIODIC_MODE);
	MSS_TIM1_enable_irq();
	MSS_TIM2_init(MSS_TIMER_ONE_SHOT_MODE);
	MSS_TIM2_enable_irq();

	MSS_TIM1_load_background(packet_rate * MICRO_SEC_DIV);
	MSS_TIM1_start();

	while( 1 )
	{
		if (spi_cmd_length > 0)
		{
			process_spi_cmd_buf((const char*)spi_cmd_buf, spi_cmd_length);
			spi_cmd_length = 0;
		}

		if (tx_done_it_flag)
		{
			tx_done_it_flag = 0;
			int32_t jitter = ((int8_t)lfsr_rand()) * packet_var;
			MSS_TIM1_load_background((uint32_t)((int32_t)packet_rate + jitter) * MICRO_SEC_DIV);
		}

		if (sfd_it_flag)
		{
			sfd_it_flag = 0;
		}

		if (rx_done_it_flag)
		{
			rx_done_it_flag = 0;
		}
	}
}


void Timer1_IRQHandler(void)
{
	// FIXME: Reduce the length of this time critical section
	uint8_t pkt_len = TX_CTRL->PAY_LEN;
	int i;

	// Prepare packet
	pkt.src_addr = node_id;
	pkt.seq_num[0] = (seq_num >> 8) & 0xFF;
	pkt.seq_num[1] = seq_num & 0xFF;
	for (i = 0; i < pkt_len-5; i++)
	{
		pkt.payload[i] = lfsr_rand();
	}
	set_packet_crc(&pkt, pkt_len);
	send_packet(&pkt, pkt_len-5);

	seq_num++;

//	TX_CTRL->CTRL = 0x01; // Start

	// Turn on LED
	MSS_GPIO_set_output(MSS_GPIO_LED1, 1);
	MSS_TIM2_load_immediate(1e2 * MICRO_SEC_DIV);
	MSS_TIM2_start();

	MSS_TIM1_clear_irq();
}


void Timer2_IRQHandler(void)
{
	// Turn off LED
	MSS_GPIO_set_output( MSS_GPIO_LED1, 0 );
	MSS_TIM2_clear_irq();
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
