/*******************************************************************************
 * (c) Copyright 2008 Actel Corporation.  All rights reserved.
 * 
 * SVN $Revision: 1477 $
 * SVN $Date: 2009-09-28 15:45:52 +0100 (Mon, 28 Sep 2009) $
 */
#include "hal.h"
#include "hal_assert.h"

#if defined(NDEBUG)
/***************************************************************************//**
 * HAL_ASSERT() is defined out when the NDEBUG symbol is used.
 ******************************************************************************/

#elif defined(HAL_ASSERT_TESTSUITE)
/***************************************************************************//**
 * HAL_ASSERT() macro implementation for use with test suites.
 *------------------------------------------------------------------------------
 * In this mode an error message is displayed via the UART and a global variable
 * set to indicate that an assertion was fired. Then the program execution
 * proceeds as if no assertion was fired.
 * This mode expects a CoreUARTapb hardware instance to be present in the design
 * in order to display the error message. A pointer "g_ext_uart" to this UART's
 * instance data is also expected.
 ******************************************************************************/
#include "core_uart_apb.h"

#define MAX_PATH_FILE_NAME  256

int32_t g_test_error;

uint32_t hal_assert_int_2_text
(
	uint8_t * buff,
	uint32_t buff_size,
	uint32_t value
);

extern UART_instance_t g_ext_uart;
extern int32_t g_test_error;

/*-------------------------------------------------------------------------*//**
 *
 */
void HAL_assert_fail
(
    const uint8_t * file_name,
    uint32_t line_no
)
{
    const uint8_t fail_msg[] = "\r\nHAL_ASSERT: ";
    const uint8_t line_msg[] = ", line ";
    uint8_t line_nb_msg[256];
    uint32_t msg_length;
    
    g_test_error = ASSERTION_ERROR_CODE;
    
    UART_send( &g_ext_uart,	fail_msg, sizeof(fail_msg) );
    
    for ( msg_length = 0; (msg_length < MAX_PATH_FILE_NAME) && (file[msg_length] != 0); msg_length++ )
    {
        ;
    }

    UART_send( &g_ext_uart,	(const uint8_t *)file, msg_length );
    UART_send( &g_ext_uart, line_msg, sizeof(line_msg) );

    msg_length = hal_assert_int_2_text( line_nb_msg, sizeof(line_nb_msg), line_no );
    
    UART_send( &g_ext_uart, line_nb_msg, msg_length );
}

/*-------------------------------------------------------------------------*//**
 *
 */
uint32_t hal_assert_int_2_text
(
	uint8_t * buff,
	uint32_t buff_size,
	uint32_t value
)
{
	int32_t nb_char, temp_val, rev_i, i, brk;
	uint8_t reversed[256];
	
	temp_val = value;
	brk = 0;
	for ( nb_char = 0; (nb_char < buff_size) && (brk != 1); nb_char++ )
	{
		reversed[nb_char] = (temp_val % 10) + '0';
		temp_val = temp_val / 10;
		if ( temp_val == 0 )
		{
			brk = 1;
		}
	}

	for ( i = 0, rev_i = (nb_char - 1); rev_i >= 0; rev_i--, i++)
	{
		buff[i] = reversed[rev_i];
	}
	
	return ((uint32_t)nb_char);
}

#else
/***************************************************************************//**
 * Default behaviour for HAL_ASSERT() macro:
 *------------------------------------------------------------------------------
 * In this mode, an assertion will block the programs execution until a watchdog
 * resets the system.
 ******************************************************************************/
void HAL_assert_fail
(
    const uint8_t * file_name,
    uint32_t line_no
)
{
    while(1)
    {
        volatile const uint8_t * assert_file = file_name;
        volatile uint32_t assert_line = line_no;
        volatile char dummy;
		volatile uint32_t i_dummy;
		
		/* following lines to avoid compiler warnings: */
        dummy = *assert_file;
		i_dummy = assert_line;
		i_dummy++;
    }
}

#endif

