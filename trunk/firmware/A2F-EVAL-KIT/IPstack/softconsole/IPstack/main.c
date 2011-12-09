/*******************************************************************************
 * (c) Copyright 2010 Actel Corporation.  All rights reserved.
 *
 *  Application demo for Smartfusion
 *
 *
 * Author : Actel's Corporate Application Team
 * Rev    : 1.0.0.4
 *
 *******************************************************************************/

/**************************************************************************/
/* Standard Includes */
/**************************************************************************/

#include <stdio.h>
#include <stdlib.h>

/**************************************************************************/
/* Firmware Includes */
/**************************************************************************/

#include "CMSIS/a2fxxxm3.h"

//#include "./drivers/mss_watchdog/mss_watchdog.h"
//#include "./drivers/mss_uart/mss_uart.h"
#include "./drivers/mss_ethernet_mac/mss_ethernet_mac.h"
//#include "./drivers/mss_rtc/mss_rtc.h"
#include "./drivers/mss_timer/mss_timer.h"

#include "lwip/sys.h"
#include "lwip/mem.h"
#include "lwip/memp.h"
#include "lwip/ip.h"
#include "lwip/tcp.h"
#include "lwip/dhcp.h"
#include "netif/etharp.h"
#include "netif/loopif.h"
//BB #include "netif/ethernet.h" //BB


#include "sampleserver.h"

//#include "ff.h"
//#include "diskio.h"
//#include "tftpd.h"
/**************************************************************************/
/* RTOS Includes */
/**************************************************************************/


extern void ethernetif_input( void * pvParameters );
extern void prvlwIPInit( void );
extern void portlwIPInit( void ); //BB

/**************************************************************************/
/* Preprocessor Macros*/
/**************************************************************************/

static uint16_t System_ticks = 0;

// Simple periodic polling function
#define PERIODIC(var,time,function) \
    if((System_ticks - var) > time) \
    {                               \
        var += time;                \
        function;                   \
    }                               \


struct netif netif;
#if LWIP_HAVE_LOOPIF
struct netif netif_loop;
#endif

/**************************************************************************/
/*Declaration of global variables*/
/**************************************************************************/
/**************************************************************************/
/*Extern Declarations*/
/**************************************************************************/

//extern void httpd_init(void);
//extern void init_mac(void);
/**************************************************************************/
/*Functions for Interrupt Handlers */
/**************************************************************************/

/**************************************************************************/
/* Function to initialization all necessary hardware components for this*/
/* demo*/
/**************************************************************************/
//FATFS fatfs;/* File system object */

/*
size_t
UART_Polled_Rx
(
    mss_uart_instance_t * this_uart,
    uint8_t * rx_buff,
    size_t buff_size
)
{
    size_t rx_size = 0U;

//    ASSERT( (this_uart == &g_mss_uart0) || (this_uart == &g_mss_uart1) );
    while( rx_size < buff_size )
    {
       while ( this_uart->hw_reg_bit->LSR_DR != 0U  )
       {
           rx_buff[rx_size] = this_uart->hw_reg->RBR;
           ++rx_size;
       }
    }

    return rx_size;
}
*/


void Timer1_IRQHandler( void )
{
    System_ticks++;
    /* Clear TIM1 interrupt */
    MSS_TIM1_clear_irq();
}


void init_system()
{
    uint32_t timer1_load_value;
    /* Disable the Watch Dog Timer */
//2    MSS_WD_disable( );
    /* Initialize and configure UART0. */
/*
    MSS_UART_init
    (
        &g_mss_uart0,
        MSS_UART_57600_BAUD,
        MSS_UART_DATA_8_BITS | MSS_UART_NO_PARITY | MSS_UART_ONE_STOP_BIT
    );
*/
//2    ACE_init();

    SystemCoreClockUpdate();
    /* Timer 1 for 10ms */
//    timer1_load_value = g_FrequencyPCLK0/1000;
    timer1_load_value = g_FrequencyPCLK0/10000;
    MSS_TIM1_init( MSS_TIMER_PERIODIC_MODE );
    MSS_TIM1_load_immediate( timer1_load_value );
    MSS_TIM1_start();
    MSS_TIM1_enable_irq();

}

/*
void init_RTC()
{
    MSS_RTC_init();
    MSS_RTC_configure( MSS_RTC_NO_COUNTER_RESET );
    MSS_RTC_start();
    set_fattime();

}
*/

/*
int Init_FS()
{
    long p2;
    FATFS *fs;

    // File System  on SPI Flash Init
    if (disk_initialize(0))
    {
        iprintf("Disk Initialization Failed: SPI interface Error \n\r");
        return 1;
    }
    else
    {
        f_mount(0, &fatfs);

        if(f_getfree("", (DWORD*)&p2, &fs))
        {
            // Create the File System
            if (f_mkfs(0, 0, 2048))
            {
                 iprintf("File System Cann't be created \n\r");
                 return 1;
            }
        }
        init_RTC();
    }
    return 0;
}
*/

/****************************************************************/
/* Entry to Main form user boot code                             */
/****************************************************************/
int main()
{
    uint16_t arp_timer = 0;
    uint16_t tcp_timer = 0;

    /* Initialization all necessary hardware components */
    init_system();

/*
    iprintf("*** Welcome to SmartFusion ***\n\r");
    iprintf("*** Dynamic Web server Demo: FAT FS on SPI FLash, TFTP and web server on lwIP\n\r");
*/

    init_mac();

    portlwIPInit();

    server_init();

//2    httpd_init();

/*2    if(tftpd_init())
    {
        iprintf("TFTP Initialization failed\n\r");
        return 0;
    }
*/

/*
    if(Init_FS())
    {
        iprintf(" Cann't create the Fat Fs on SPI Flash please check the SPI interface in bsp_config file\n\r");
        return 0;
    }
*/
/*
    iprintf("TFTP and Web server ports are live with above IP address\n\r");
    iprintf("If web pages are not present in SPI Flash then\n\r");
    iprintf("use TFTP from Host PC to send the web server pages to SPI Flash\n\r");
    iprintf("tftp -i <board_ip_addr> PUT <filename.ext>\n\r");
    iprintf("else Browse the web server using the above IP\n\r");
*/

    tcp_tmr();
    etharp_tmr();
    do
    {
        PERIODIC(tcp_timer, TCP_TMR_INTERVAL, tcp_tmr());
        PERIODIC(arp_timer, ARP_TMR_INTERVAL, etharp_tmr());
        ethernetif_input(NULL);
    }while( 1 );

    return 0;
}
