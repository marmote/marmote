#include <Teton_hw_platform.h>

#include <mss_uart.h>
#include <mss_gpio.h>

#include <string.h>
#include <stdlib.h>
#include <stdio.h>

#include "joshua.h"
#include "cmd_defs.h"


cmd_t* cmd_list_ptr;
char* argList[10];

#define RX_BUFF_SIZE 64
#define CMD_BUFF_SIZE 256


uint8_t cmd_buff[CMD_BUFF_SIZE];
uint8_t cmd_buff_idx = 0;

char* cmd_token;

uint32_t argc;
uint8_t cmd_parse_result;

void process_cmd_buff(uint8_t* cmd_buff, uint8_t length);
void process_rx_data (uint8_t* rx_buff, uint8_t length)
;


//-----------------------------------------------------------------------------


int main()
{
    uint8_t rx_size;
    uint8_t uart_buff[RX_BUFF_SIZE];

	MSS_GPIO_init();

	MSS_GPIO_config(MSS_GPIO_0, MSS_GPIO_OUTPUT_MODE);
	MSS_GPIO_config(MSS_GPIO_1, MSS_GPIO_OUTPUT_MODE);

	//MSS_GPIO_set_outputs( MSS_GPIO_get_outputs() | MSS_GPIO_LED1_MASK );
	MSS_GPIO_set_outputs( MSS_GPIO_get_outputs() & ~MSS_GPIO_LED1_MASK );
	//MSS_GPIO_set_outputs( MSS_GPIO_get_outputs() | MSS_GPIO_LED1_MASK );
	MSS_GPIO_set_outputs( MSS_GPIO_get_outputs() & ~MSS_GPIO_AFE1_SHDN_MASK );

    MSS_UART_init( &g_mss_uart0, MSS_UART_9600_BAUD,
                   MSS_UART_DATA_8_BITS | MSS_UART_NO_PARITY | MSS_UART_ONE_STOP_BIT );

    FSK_TX_init( FSK_38400_BAUD, 150000, 0 );
	FSK_TX->MUX = 1;

    Joshua_init( );

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

void process_cmd_buff(uint8_t* cmd_buff, uint8_t length)
{
	cmd_parse_result = 1;

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
				MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)"\r\nACK" );

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
		MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)"\r\nNAK" );
	}

	// Send '>' prompt
	while ( !MSS_UART_tx_complete(&g_mss_uart0) );
	MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)"\r\n>" );
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
		else // if (*(rx_buff+i) != '\n')
		{
			cmd_buff[cmd_buff_idx++] = rx_buff[i];
		}
	}
}

