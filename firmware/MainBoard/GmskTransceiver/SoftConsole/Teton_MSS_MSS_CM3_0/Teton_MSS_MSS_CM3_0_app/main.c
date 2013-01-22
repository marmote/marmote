
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


int main()
{
	MSS_GPIO_init();
	Yellowstone_Init();
	Joshua_init();

	MSS_GPIO_config(MSS_GPIO_LED1, MSS_GPIO_OUTPUT_MODE);
	MSS_GPIO_config(MSS_GPIO_AFE_ENABLE, MSS_GPIO_OUTPUT_MODE);
	MSS_GPIO_config(MSS_GPIO_AFE_MODE, MSS_GPIO_OUTPUT_MODE);
	MSS_GPIO_config(MSS_GPIO_TX_DONE_IT, MSS_GPIO_INPUT_MODE);

	MSS_GPIO_set_output(MSS_GPIO_LED1, 0);
	MSS_GPIO_set_output(MSS_GPIO_AFE_ENABLE, 0);
	MSS_GPIO_set_output(MSS_GPIO_AFE_MODE, AFE_MODE_RX);

	// TX_DONE IRQ
	MSS_GPIO_config (MSS_GPIO_TX_DONE_IT, MSS_GPIO_INPUT_MODE | MSS_GPIO_IRQ_LEVEL_HIGH);
	MSS_GPIO_enable_irq(MSS_GPIO_TX_DONE_IT);
	NVIC_EnableIRQ(MSS_GPIO_TX_DONE_IRQn);

	// Set up as a transmitter at 2405 MHz by default
//	Max2830_set_frequency(2405000000uL);
//	MSS_GPIO_set_output(MSS_GPIO_AFE_MODE, AFE_MODE_TX);
//	Max2830_set_mode(MAX2830_TX_MODE);
	Max2830_set_mode(MAX2830_SHUTDOWN_MODE);

	// TIMER
	MSS_TIM1_init(MSS_TIMER_PERIODIC_MODE);
	MSS_TIM1_load_background(20e6); // 1 s
	MSS_TIM1_enable_irq();
	MSS_TIM1_start();

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

void Timer1_IRQHandler(void)
{
	MSS_TIM1_clear_irq();
	if ( MSS_GPIO_get_outputs() & MSS_GPIO_LED1_MASK )
	{
		MSS_GPIO_set_output(MSS_GPIO_LED1, 0);
	}
	else
	{
		MSS_GPIO_set_output(MSS_GPIO_LED1, 1);
	}
}
