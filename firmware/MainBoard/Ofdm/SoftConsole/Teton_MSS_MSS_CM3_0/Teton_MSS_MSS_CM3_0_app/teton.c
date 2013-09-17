#include "teton.h"

uint32_t packet_rate = 10000; // us
float packet_var = 0;

void Teton_init(void)
{
	MSS_GPIO_config(MSS_GPIO_LED1, MSS_GPIO_OUTPUT_MODE);
	MSS_GPIO_set_output(MSS_GPIO_LED1, 0);

	MSS_GPIO_config(MSS_GPIO_AFE1_ENABLE, MSS_GPIO_OUTPUT_MODE);
	MSS_GPIO_config(MSS_GPIO_AFE1_MODE, MSS_GPIO_OUTPUT_MODE);

	MSS_GPIO_set_output(MSS_GPIO_AFE1_ENABLE, 0);
	MSS_GPIO_set_output(MSS_GPIO_AFE1_MODE, AFE_RX_MODE);

	// TX_DONE IRQ
	MSS_GPIO_config(MSS_GPIO_TX_DONE_IT, MSS_GPIO_INPUT_MODE);
	MSS_GPIO_config (MSS_GPIO_TX_DONE_IT, MSS_GPIO_INPUT_MODE | MSS_GPIO_IRQ_EDGE_POSITIVE);
	MSS_GPIO_enable_irq(MSS_GPIO_TX_DONE_IT);
	NVIC_EnableIRQ(MSS_GPIO_TX_DONE_IRQn);

	// Node ID
	node_rev = 'A' + (char)(MM_BOARD->REV & 0xFF);
	node_id = MM_BOARD->ID & 0xFF;

	MSS_TIM1_init(MSS_TIMER_PERIODIC_MODE);

	// OFDM
//	TX_CTRL->PTRN = PTRN_DEFAULT;
//	TX_CTRL->MASK = MASK_DEFAULT;
}

// TX DONE
void GPIO8_IRQHandler(void)
{
	tx_done_it_flag = 1;
	MSS_GPIO_clear_irq( MSS_GPIO_TX_DONE_IT );
}


void set_mode(radio_operating_mode_t mode)
{
	switch (mode)
	{
		case RADIO_STANDBY_MODE:
			Max2830_set_mode(RADIO_STANDBY_MODE);
			break;

		case RADIO_RX_MODE:
			Max2830_set_mode(RADIO_RX_MODE);
			MSS_GPIO_set_output(MSS_GPIO_AFE1_MODE, AFE_RX_MODE);
			MSS_GPIO_set_output(MSS_GPIO_AFE1_ENABLE, 1);
//			BB_CTRL->MUX2 = MUX_PATH_RX;
			break;

		case RADIO_TX_MODE:
			Max2830_set_mode(RADIO_TX_MODE);
			MSS_GPIO_set_output(MSS_GPIO_AFE1_MODE, AFE_TX_MODE);
			MSS_GPIO_set_output(MSS_GPIO_AFE1_ENABLE, 1);
			break;

		default:
			break;
	}
	radio_mode = mode;
}

radio_operating_mode_t get_mode()
{
	return radio_mode;
}


char* 		cmd_token;
CMD_Type* 	cmd_list_ptr;
char* 		arg_list[10];
uint32_t 	argc;

void process_spi_cmd_buf(const char* cmd_buf, uint8_t length)
{
	uint8_t parse_result = 1;

	// Tokenize RX buffer content
	cmd_token = strtok((char *)cmd_buf, " ");
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
