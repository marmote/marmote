
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
void process_usb_cmd_buf(const uint8_t* buf);


int main()
{
    //MSS_RTC_init();

	MSS_GPIO_init();
	Yellowstone_Init();
	Joshua_init();

    //MSS_RTC_configure( MSS_RTC_NO_COUNTER_RESET | MSS_RTC_ENABLE_VOLTAGE_REGULATOR_ON_MATCH );
    //MSS_RTC_start();

	MSS_GPIO_config(MSS_GPIO_LED1, MSS_GPIO_OUTPUT_MODE);
//	MSS_GPIO_config(MSS_GPIO_LED2, MSS_GPIO_OUTPUT_MODE);
	MSS_GPIO_config(MSS_GPIO_AFE_ENABLE, MSS_GPIO_OUTPUT_MODE);
	MSS_GPIO_config(MSS_GPIO_AFE_MODE, MSS_GPIO_OUTPUT_MODE);
	MSS_GPIO_config(MSS_GPIO_USB_CTRL_IT, MSS_GPIO_INPUT_MODE);

	MSS_GPIO_set_output(MSS_GPIO_LED1, 0);
//	MSS_GPIO_set_output(MSS_GPIO_LED2, 0);
	MSS_GPIO_set_output(MSS_GPIO_AFE_ENABLE, 1);
	MSS_GPIO_set_output( MSS_GPIO_AFE_MODE, AFE_MODE_RX );
//	MSS_GPIO_set_output(MSS_GPIO_FPGA_ENABLE, 1);

	MSS_GPIO_config ( MSS_GPIO_USB_CTRL_IT, MSS_GPIO_INPUT_MODE | MSS_GPIO_IRQ_LEVEL_HIGH );
	MSS_GPIO_enable_irq( MSS_GPIO_USB_CTRL_IT );
	NVIC_EnableIRQ( MSS_GPIO_USB_CTRL_IT_IRQn );

	Max2830_set_frequency(2405000000uL);

	// Set up as a transmitter at 2405 MHz by default
	/*
	Max2830_set_frequency(2405000000uL);
	Max2830_set_mode( MAX2830_TX_MODE );
	MSS_GPIO_set_output( MSS_GPIO_AFE_MODE, AFE_MODE_TX );
	*/

	// Set up as a receiver at 2405 MHz by default
	Max2830_set_frequency(2405000000uL);
	MSS_GPIO_set_output( MSS_GPIO_AFE_MODE, AFE_MODE_RX );
	Max2830_set_mode( MAX2830_RX_MODE );


	while( 1 )
	{

		if (spi_cmd_length > 0)
		{
			process_spi_cmd_buf((const char*)spi_cmd_buf, spi_cmd_length);
			spi_cmd_length = 0;
		}


		if (usb_cmd_valid)
		{
			process_usb_cmd_buf(usb_cmd_buf);
			usb_cmd_valid = 0;
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


void process_usb_cmd_buf(const uint8_t* buf)
{
	PktHdr_t* pkt = (PktHdr_t*)buf;
	uint32_t ret_val;

	switch ((MsgClass_t)pkt->msg_class)
	{
		case MARMOTE :

			switch ((MsgId_t)pkt->msg_id)
			{
				case SET_LED :

					if (*(pkt->payload))
					{
						MSS_GPIO_set_output( MSS_GPIO_LED1, 1 );
					}
					else
					{
						MSS_GPIO_set_output( MSS_GPIO_LED1, 0 );
					}

				default :
					break;
			}
			break;

		case SDR :

			switch ((MsgId_t)pkt->msg_id)
			{
				case SET_FREQUENCY :

					Max2830_set_frequency( *(uint32_t*)pkt->payload  );
					break;

				case GET_FREQUENCY :

					ret_val = Max2830_get_frequency();
					USB_SendMsg( SDR, GET_FREQUENCY, (uint8_t*)&ret_val, sizeof(uint32_t));
					break;

				case START_STREAMING :

					USB_CTRL->SDR |= SDR_STREAM_ENABLE_MASK;
					break;

				case STOP_STREAMING :

					USB_CTRL->SDR &= ~SDR_STREAM_ENABLE_MASK;
					break;

				default :
					break;
			}
			break;

		case MAX2830 :

			break;

		default:

			break;

	}
}

