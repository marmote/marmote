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

	// RX done IRQ
	MSS_GPIO_config(MSS_GPIO_RX_DONE_IT, MSS_GPIO_INPUT_MODE);
	MSS_GPIO_config (MSS_GPIO_RX_DONE_IT, MSS_GPIO_INPUT_MODE | MSS_GPIO_IRQ_EDGE_POSITIVE);
	MSS_GPIO_enable_irq(MSS_GPIO_RX_DONE_IT);
	NVIC_EnableIRQ(MSS_GPIO_RX_DONE_IRQn);

	// SFD IRQ
	MSS_GPIO_config(MSS_GPIO_SFD_IT, MSS_GPIO_INPUT_MODE);
	MSS_GPIO_config (MSS_GPIO_SFD_IT, MSS_GPIO_INPUT_MODE | MSS_GPIO_IRQ_EDGE_POSITIVE);
	MSS_GPIO_enable_irq(MSS_GPIO_SFD_IT);
	NVIC_EnableIRQ(MSS_GPIO_SFD_IRQn);

	// Node ID
	node_rev = 'A' + (char)(MM_BOARD->REV & 0xFF) - 1;
	node_id = MM_BOARD->ID & 0xFF;

	// CDMA
	TX_CTRL->MASK = polynomial_masks[node_id];
	TX_CTRL->SF = 8;
	TX_CTRL->PRE_LEN = 2;
	TX_CTRL->PAY_LEN = 20;

	// Payload
	lfsr_int(polynomial_masks[node_id], 0x01);
}

// TX DONE
void GPIO8_IRQHandler(void)
{
	tx_done_it_flag = 1;
	MSS_GPIO_clear_irq( MSS_GPIO_TX_DONE_IT );
}

// SFD
void GPIO9_IRQHandler(void)
{
	sfd_it_flag = 1;
	MSS_GPIO_clear_irq( MSS_GPIO_SFD_IT );
}

// RX DONE
void GPIO10_IRQHandler(void)
{
	rx_done_it_flag = 1;
	MSS_GPIO_clear_irq( MSS_GPIO_RX_DONE_IT );
}


uint8_t lfsr_rand(void)
{
	if (s_lfsr_state & 0x0001)
	{
		s_lfsr_state >>= 1;
		s_lfsr_state ^= s_lfsr_mask;
	}
	else
	{
		s_lfsr_state >>= 1;
	}
	return s_lfsr_state & 0xFF;
}

void lfsr_int(uint32_t mask, uint32_t seed)
{
	s_lfsr_state = seed;
	s_lfsr_mask = mask;
}


void send_packet(const packet_t* pkt, uint8_t pay_len)
{
	uint8_t i;

//	set_mode(RADIO_TX_MODE);

	if (pay_len > 0 && pay_len < MAX_PAYLOAD_LEN)
	{
		TX_CTRL->TX_FIFO = pkt->src_addr;
		TX_CTRL->TX_FIFO = pkt->seq_num[0];
		TX_CTRL->TX_FIFO = pkt->seq_num[1];
		for (i = 0; i < pay_len; i++)
		{
			TX_CTRL->TX_FIFO = pkt->payload[i];
		}
		TX_CTRL->TX_FIFO = pkt->crc_16[0];
		TX_CTRL->TX_FIFO = pkt->crc_16[1];

		TX_CTRL->CTRL = 0x01; // start
	}
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

			BB_CTRL->MUX1 = MUX_PATH_TX;
			BB_CTRL->MUX2 = MUX_PATH_TX;
			break;

		case RADIO_TX_PERIODIC_MODE:
			Max2830_set_mode(RADIO_TX_MODE);
			// TIMER
			MSS_TIM1_init(MSS_TIMER_PERIODIC_MODE);
			MSS_TIM1_load_background(20e6); // 1 s
			MSS_TIM1_enable_irq();
			MSS_TIM1_start();

			BB_CTRL->MUX1 = MUX_PATH_TX;
			BB_CTRL->MUX2 = MUX_PATH_TX;
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


#define POLYNOMIAL 0x1021

uint16_t crc_16(const uint8_t data[], uint8_t length)
{
	uint8_t	bit;
	uint8_t byte;
    uint16_t crc;

	crc = 0;

    for (byte = 0; byte < length; ++byte)
    {
		crc ^= (data[byte] << 8);

        for (bit = 8; bit > 0; --bit)
        {
            if (crc & (1 << 15))
            {
                crc = (crc << 1) ^ POLYNOMIAL;
            }
            else
            {
                crc = (crc << 1);
            }
        }
    }

    return crc;
}

uint16_t check_crc(const packet_t* pkt, uint8_t pkt_len)
{
	return (crc_16((const uint8_t*)pkt, pkt_len-2) == (pkt->crc_16[0] << 8) + pkt->crc_16[1]);
}

void set_packet_crc(packet_t* pkt, uint8_t pkt_len)
{
	uint16_t crc;
	crc = crc_16((const uint8_t*)pkt, pkt_len-2);
	pkt->crc_16[0] = crc >> 8;
	pkt->crc_16[1] = crc & 0xFF;
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
