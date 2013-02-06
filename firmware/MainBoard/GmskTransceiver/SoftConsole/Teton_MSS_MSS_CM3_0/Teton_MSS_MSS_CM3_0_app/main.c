
#include <string.h>
#include <mss_gpio.h>
#include <mss_rtc.h>

#include "yellowstone.h"
#include "teton.h"

#include "cmd_def.h"


extern uint8_t spi_cmd_buf[];
extern uint8_t spi_cmd_length;

char* cmd_token;
CMD_Type* cmd_list_ptr;
char* arg_list[10];
uint32_t argc;

void process_spi_cmd_buf(const char* cmd_buf, uint8_t length);

static uint8_t payload;

int main()
{
	MSS_GPIO_init();
	Yellowstone_Init();
	Joshua_init();

	MSS_GPIO_config(MSS_GPIO_LED1, MSS_GPIO_OUTPUT_MODE);
	MSS_GPIO_config(MSS_GPIO_AFE1_ENABLE, MSS_GPIO_OUTPUT_MODE);
	MSS_GPIO_config(MSS_GPIO_AFE1_MODE, MSS_GPIO_OUTPUT_MODE);
	MSS_GPIO_config(MSS_GPIO_TX_DONE_IT, MSS_GPIO_INPUT_MODE);
	MSS_GPIO_config(MSS_GPIO_SFD_IT, MSS_GPIO_INPUT_MODE);
	MSS_GPIO_config(MSS_GPIO_RX_DONE_IT, MSS_GPIO_INPUT_MODE);

	MSS_GPIO_set_output(MSS_GPIO_LED1, 0);
	MSS_GPIO_set_output(MSS_GPIO_AFE1_ENABLE, 0);
	MSS_GPIO_set_output(MSS_GPIO_AFE1_MODE, AFE_RX_MODE);

	// TX_DONE IRQ
	MSS_GPIO_config (MSS_GPIO_TX_DONE_IT, MSS_GPIO_INPUT_MODE | MSS_GPIO_IRQ_EDGE_POSITIVE);
	MSS_GPIO_enable_irq(MSS_GPIO_TX_DONE_IT);
	NVIC_EnableIRQ(MSS_GPIO_TX_DONE_IRQn);

	// RX done IRQ
	MSS_GPIO_config (MSS_GPIO_RX_DONE_IT, MSS_GPIO_INPUT_MODE | MSS_GPIO_IRQ_EDGE_POSITIVE);
	MSS_GPIO_enable_irq(MSS_GPIO_RX_DONE_IT);
	NVIC_EnableIRQ(MSS_GPIO_RX_DONE_IRQn);

	// SFD IRQ
	MSS_GPIO_config (MSS_GPIO_SFD_IT, MSS_GPIO_INPUT_MODE | MSS_GPIO_IRQ_EDGE_POSITIVE);
	MSS_GPIO_enable_irq(MSS_GPIO_SFD_IT);
	NVIC_EnableIRQ(MSS_GPIO_SFD_IRQn);

	// ----------------- Rx ----------------

//	// Set up as a receiver at 2405 MHz by default
//	Max2830_set_frequency(2405000000uL);
//	Max2830_set_mode(MAX2830_RX_MODE);
//	MSS_GPIO_set_output(MSS_GPIO_AFE1_MODE, AFE_RX_MODE);
//	MSS_GPIO_set_output(MSS_GPIO_AFE1_ENABLE, 1);
//
//	//BB_CTRL->MUX1 = MUX_PATH_RX;
//	BB_CTRL->MUX2 = MUX_PATH_RX;

	// ----------------- Tx ----------------

	// Set up as a transmitter at 2405 MHz by default
	Max2830_set_frequency(2405000000uL);
	Max2830_set_mode(MAX2830_TX_MODE);
	MSS_GPIO_set_output(MSS_GPIO_AFE1_MODE, AFE_TX_MODE);
	MSS_GPIO_set_output(MSS_GPIO_AFE1_ENABLE, 1);

	//payload = 0x55;

	// TIMER
	MSS_TIM1_init(MSS_TIMER_PERIODIC_MODE);
	MSS_TIM1_load_background(20e5); // 1 s
	MSS_TIM1_enable_irq();
	MSS_TIM1_start();

	BB_CTRL->MUX1 = MUX_PATH_TX;
	BB_CTRL->MUX2 = MUX_PATH_TX;

	while( 1 )
	{
		if (spi_cmd_length > 0)
		{
			process_spi_cmd_buf((const char*)spi_cmd_buf, spi_cmd_length);
			spi_cmd_length = 0;
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

uint16_t baseband_ctr;

void Timer1_IRQHandler(void)
{
	MSS_TIM1_clear_irq();

//	BB_CTRL->TX_Q = baseband_ctr - 256;
//	BB_CTRL->TX_I = baseband_ctr++;

	// Fill up TX FIFO
//	TX_CTRL->TX_FIFO = payload++;
//	TX_CTRL->TX_FIFO = payload++;
//	TX_CTRL->TX_FIFO = payload++;
//	TX_CTRL->TX_FIFO = payload++;

	TX_CTRL->TX_FIFO = 0xAB;
	TX_CTRL->TX_FIFO = 0xCD;
	TX_CTRL->TX_FIFO = 0xFF;
	TX_CTRL->TX_FIFO = 0x00;

	// Start
	TX_CTRL->CTRL = 0x01;

	MSS_GPIO_set_output(MSS_GPIO_LED1, 1);
}
