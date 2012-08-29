
#include <string.h>
#include <mss_gpio.h>
#include <mss_rtc.h>

#include "yellowstone.h"
#include "teton.h"

#include "cmd_def.h"


extern uint8_t cmd_buffer[];
extern uint8_t cmd_length;

char* cmd_token;
CMD_Type* cmd_list_ptr;
char* arg_list[10];
uint32_t argc;

void process_cmd_buff(const char* cmd_buff, uint8_t length);



int main()
{
    MSS_RTC_init();

	MSS_GPIO_init();
	Yellowstone_Init();
	Joshua_init();

    MSS_RTC_configure( MSS_RTC_NO_COUNTER_RESET | MSS_RTC_ENABLE_VOLTAGE_REGULATOR_ON_MATCH );
    MSS_RTC_start();

	MSS_GPIO_config(MSS_GPIO_LED1, MSS_GPIO_OUTPUT_MODE);
	MSS_GPIO_config(MSS_GPIO_LED2, MSS_GPIO_OUTPUT_MODE);
	MSS_GPIO_config(MSS_GPIO_AFE_ENABLE, MSS_GPIO_OUTPUT_MODE);
	MSS_GPIO_config(MSS_GPIO_FPGA_ENABLE, MSS_GPIO_OUTPUT_MODE);
	//MSS_GPIO_config(MSS_GPIO_8, MSS_GPIO_OUTPUT_MODE);

	MSS_GPIO_set_output(MSS_GPIO_LED1, 0);
	MSS_GPIO_set_output(MSS_GPIO_LED2, 0);
	MSS_GPIO_set_output(MSS_GPIO_AFE_ENABLE, 0);
	MSS_GPIO_set_output(MSS_GPIO_FPGA_ENABLE, 0);
	//MSS_GPIO_set_outputs( MSS_GPIO_get_outputs() | MSS_GPIO_AFE1_T_RN_MASK );
	//MSS_GPIO_set_outputs( MSS_GPIO_get_outputs() & ~MSS_GPIO_LED1_MASK );
	//MSS_GPIO_set_outputs( MSS_GPIO_get_outputs() & ~MSS_GPIO_AFE_ENABLE_MASK );


	while( 1 )
	{
		if (cmd_length > 0)
		{
			process_cmd_buff((const char*)cmd_buffer, cmd_length);
			cmd_length = 0;
		}
	}
}



void process_cmd_buff(const char* cmd_buff, uint8_t length)
{
	uint8_t parse_result = 1;

	// Tokenize RX buffer content
	cmd_token = strtok((char *)cmd_buffer, " ");
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
	cmd_length = 0;
}
