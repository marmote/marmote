#include "teton.h"

const char* fw_name = "OFDM transmitter";
uint32_t g_rate = 500; // ms
uint32_t g_sweep = 0;

uint32_t fc_vec[] =
{
		2400000000uL,
		2420000000uL,
		2440000000uL,
		2460000000uL,
		2480000000uL,
		2500000000uL,
		2410000000uL,
		2430000000uL,
		2450000000uL,
		2470000000uL,
		2490000000uL
};

mask_set_t mask_vec[] =
{
		{"original",	0x007E32C8ul,   0xAAAAAAAAul,	0x55555555ul},
		{"sideburn",	0x015B6E30ul,   0x00AAAAFFul,	0xFF555500ul},
		{"asymhalf",	0x049805B8ul,   0xAAAA5555ul,	0x5555AAAAul},
		{"dualstag",	0x007D7080ul,   0xCCCCCCCCul,	0x33333333ul},
		{NULL,			0,              0,				0},
};


void update_ptrn_and_mask(void)
{
	TX_CTRL->PTRN= mask_ptr->ptrn;
	switch (g_role)
	{
		case TX1:
			TX_CTRL->MASK = mask_ptr->mask1 & MASK_DEFAULT;
			break;
		case TX2:
			TX_CTRL->MASK = mask_ptr->mask2 & MASK_DEFAULT;
			break;
	}
}

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
	TX_CTRL->PTRN = PTRN_DEFAULT;
	TX_CTRL->MASK = MASK_DEFAULT;
	TX_CTRL->GAIN = 3;
	g_role = TX1;
	g_sweep = 0;
	g_sweep_len = 2048;
	mask_ptr = mask_vec+3;
	update_ptrn_and_mask();

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
