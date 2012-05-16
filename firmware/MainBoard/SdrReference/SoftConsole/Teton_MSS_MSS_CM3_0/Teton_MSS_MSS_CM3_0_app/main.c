
#include <mss_uart.h>
#include <mss_gpio.h>

#include <string.h>
#include <stdlib.h>
#include <stdio.h>


//#define MSS_GPIO_AFE1_T_RN_MASK MSS_GPIO_10_MASK
#define MSS_GPIO_AFE1_SHDN_MASK MSS_GPIO_0_MASK
#define MSS_GPIO_LED1_MASK MSS_GPIO_1_MASK

uint32_t CmdHelp(uint32_t argc, char** argv);
uint32_t CmdLed(uint32_t argc, char** argv);
uint32_t CmdAfe(uint32_t argc, char** argv);

typedef struct cmd_struct
{
	char* CmdString;
	uint32_t (*CmdFunction)(uint32_t argc, char** argv);
} cmd_t;

// List of command words and associated functions
cmd_t cmd_list[] =
{
	"help", CmdHelp,
	"led",  CmdLed,
	"afe",  CmdAfe,
	NULL,   NULL
};

cmd_t* cmd_list_ptr;
char* argList[10];

#define RX_BUFF_SIZE 64
#define CMD_BUFF_SIZE 256


uint8_t cmd_buff[CMD_BUFF_SIZE];
uint8_t cmd_buff_idx = 0;

char* cmd_token;

uint32_t argc;
uint8_t cmd_parse_result;

void process_cmd_buff(uint8_t* cmd_buff, uint8_t length)
{
	cmd_parse_result = 0;

	// Tokenize command buffer content
	cmd_token = strtok((char *)cmd_buff, " ");
	if (cmd_token != NULL)
	{
		cmd_list_ptr = cmd_list;
		while (cmd_list_ptr->CmdString)
		{
			if (!strcmp(cmd_token, cmd_list_ptr->CmdString))
			{
				// Set the argList pointers to tokens
				argc = 0;

				while ( cmd_token != NULL && argc < 10 )
				{
					argList[argc++] = cmd_token;
					cmd_token = strtok(NULL, " ");
				}

				while ( !MSS_UART_tx_complete(&g_mss_uart0) );
				MSS_UART_polled_tx_string( &g_mss_uart0, "\r\nACK" );

				// Invoke associated command function
				cmd_list_ptr->CmdFunction(argc, argList);

				cmd_parse_result = 0;
				break;
			}

			cmd_list_ptr++;
		}
	}

	// Send NAK if no valid command identified
	if (cmd_parse_result == 1)
	{
		while ( !MSS_UART_tx_complete(&g_mss_uart0) );
		MSS_UART_polled_tx_string( &g_mss_uart0, "\r\nNAK" );
	}

	// Send '>' prompt
	while ( !MSS_UART_tx_complete(&g_mss_uart0) );
	MSS_UART_polled_tx_string( &g_mss_uart0, "\r\n>" );
}



void process_rx_data (uint8_t* rx_buff, uint8_t length)
{
	uint8_t i;
	for ( i = 0; i < length; i++ )
	{
		if (*(rx_buff+i) == '\r')
		{
			cmd_buff[cmd_buff_idx] = '\0';
			process_cmd_buff(cmd_buff, cmd_buff_idx);
			cmd_buff_idx = 0;
		}
		else //if (*(rx_buff+i) != '\n')
		{
			cmd_buff[cmd_buff_idx++] = rx_buff[i];
		}
	}
}

//-----------------------------------------------------------------------------

int main()
{
    uint8_t rx_size;
    uint8_t uart_buff[RX_BUFF_SIZE];

	MSS_GPIO_init();

	MSS_GPIO_config(MSS_GPIO_0, MSS_GPIO_OUTPUT_MODE);
	MSS_GPIO_config(MSS_GPIO_1, MSS_GPIO_OUTPUT_MODE);

	//MSS_GPIO_set_outputs( MSS_GPIO_get_outputs() | MSS_GPIO_AFE1_T_RN_MASK );
	MSS_GPIO_set_outputs( MSS_GPIO_get_outputs() & ~MSS_GPIO_LED1_MASK );
	MSS_GPIO_set_outputs( MSS_GPIO_get_outputs() & ~MSS_GPIO_AFE1_SHDN_MASK );

    MSS_UART_init( &g_mss_uart0, MSS_UART_9600_BAUD,
                   MSS_UART_DATA_8_BITS | MSS_UART_NO_PARITY | MSS_UART_ONE_STOP_BIT );

	while( 1 )
	{
		rx_size = MSS_UART_get_rx( &g_mss_uart0, uart_buff, RX_BUFF_SIZE );
		if ( rx_size > 0 )
		{
			// Echo message
			while ( !MSS_UART_tx_complete(&g_mss_uart0) );
			MSS_UART_polled_tx( &g_mss_uart0, uart_buff, rx_size );

			while ( !MSS_UART_tx_complete(&g_mss_uart0) );
			process_rx_data( uart_buff, rx_size );
		}

	}
}

//-----------------------------------------------------------------------------


uint32_t CmdHelp(uint32_t argc, char** argv)
{
	cmd_t* cmdListItr = cmd_list;

	while ( !MSS_UART_tx_complete(&g_mss_uart0) );
	MSS_UART_polled_tx_string( &g_mss_uart0, "\r\nAvailable commands:\r\n" );

	while (cmdListItr->CmdString)
	{
		MSS_UART_polled_tx_string( &g_mss_uart0, "\r\n  " );
		MSS_UART_polled_tx_string( &g_mss_uart0, cmdListItr->CmdString );
		cmdListItr++;
	}
	MSS_UART_polled_tx_string( &g_mss_uart0, "\r\n" );

	return 0;
}

uint32_t CmdLed(uint32_t argc, char** argv)
{
	while ( !MSS_UART_tx_complete(&g_mss_uart0) );

	if (argc == 2) {
		if (!strcmp(*(argv+1), "on"))
		{
			MSS_GPIO_set_outputs( MSS_GPIO_get_outputs() | MSS_GPIO_LED1_MASK );
			MSS_UART_polled_tx_string( &g_mss_uart0, "\r\nLED is ON");
			return 0;
		}

		if (!strcmp(*(argv+1), "off"))
		{
			MSS_GPIO_set_outputs( MSS_GPIO_get_outputs() & ~MSS_GPIO_LED1_MASK );
			MSS_UART_polled_tx_string( &g_mss_uart0, "\r\nLED is OFF");
			return 0;
		}
	}

	// Send help message
	MSS_UART_polled_tx_string( &g_mss_uart0, "\r\nUsage: led [on | off]");
	return 1;
}

uint32_t CmdAfe(uint32_t argc, char** argv)
{
	uint32_t dac_value, gpio_value;
	char parse_buf[128];

	while ( !MSS_UART_tx_complete(&g_mss_uart0) );

	if (argc == 2)
	{
		if (!strcmp(*(argv+1), "on"))
		{
			MSS_GPIO_set_outputs( MSS_GPIO_get_outputs() & ~MSS_GPIO_AFE1_SHDN_MASK );
			MSS_UART_polled_tx_string( &g_mss_uart0, "\r\nAFE is ON");
			return 0;
		}

		if (!strcmp(*(argv+1), "off"))
		{
			MSS_GPIO_set_outputs( MSS_GPIO_get_outputs() | MSS_GPIO_AFE1_SHDN_MASK );
			MSS_UART_polled_tx_string( &g_mss_uart0, "\r\nAFE is OFF");
			return 0;
		}

		dac_value = atoi(*(argv+1));
		if (dac_value || !strcmp(*(argv+1), "0"))
		{
			dac_value = dac_value & (uint32_t)0x3FF;
			gpio_value = MSS_GPIO_get_outputs() & ~(uint32_t)0x3FF;
			gpio_value |= dac_value;
			MSS_GPIO_set_outputs( gpio_value );

			sprintf(parse_buf, "\r\nParsed: %d", (int)dac_value);
			MSS_UART_polled_tx_string( &g_mss_uart0, parse_buf );
			return 0;
		}
	}

	// Send help message
	MSS_UART_polled_tx_string( &g_mss_uart0, "\r\nUsage: afe [on | off | <dac value>]");
	return 1;
}
