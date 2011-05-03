#ifndef _CONF_ETH_H_
#define _CONF_ETH_H_

//#define HTTP_USED 1

#if (NO_SYS == 0)
/*! define stack size for netif task */
#define netifINTERFACE_TASK_STACK_SIZE    4*1024

/*! define WEB server priority */
#define ethWEBSERVER_PRIORITY             ( tskIDLE_PRIORITY + 2 )

/*! define TFTP server priority */
#define ethTFTPSERVER_PRIORITY            ( tskIDLE_PRIORITY + 3 )

/*! define SMTP Client priority */
#define ethSMTPCLIENT_PRIORITY            ( tskIDLE_PRIORITY + 5 )

/*! define lwIP task priority */
#define lwipINTERFACE_TASK_PRIORITY       ( configMAX_PRIORITIES - 1 )

/*! define netif task priority */
#define netifINTERFACE_TASK_PRIORITY      ( configMAX_PRIORITIES - 1 )

/*! Number of threads that can be started with sys_thread_new() */
#define SYS_THREAD_MAX                      16
#endif

/*! Number of receive buffers */
//#define ETHERNET_CONF_NB_RX_BUFFERS        20

/*! USE_RMII_INTERFACE must be defined as 1 to use an RMII interface, or 0
to use an MII interface. */
//#define ETHERNET_CONF_USE_RMII_INTERFACE   1

/*! Number of Transmit buffers */
//#define ETHERNET_CONF_NB_TX_BUFFERS        10

/*! Size of each Transmit buffer. */
//#define ETHERNET_CONF_TX_BUFFER_SIZE       512
//#define ETHERNET_CONF_TX_BUFFER_SIZE       128

/*! Clock definition */
//#define ETHERNET_CONF_SYSTEM_CLOCK         48000000

/*! Use Auto Negociation to get speed and duplex */
//#define ETHERNET_CONF_AN_ENABLE                      1

/*! Do not use auto cross capability */
//#define ETHERNET_CONF_AUTO_CROSS_ENABLE              0
/*! use direct cable */
//#define ETHERNET_CONF_CROSSED_LINK                   0


/* ethernet default parameters */
/*! MAC address definition.  The MAC address must be unique on the network. */
#define ETHERNET_CONF_ETHADDR0                        0xAA
#define ETHERNET_CONF_ETHADDR1                        0xBB
#define ETHERNET_CONF_ETHADDR2                        0xCC
#define ETHERNET_CONF_ETHADDR3                        0x66
#define ETHERNET_CONF_ETHADDR4                        0x55
#define ETHERNET_CONF_ETHADDR5                        0x44

/*! The IP address being used. */
#if 0
#define ETHERNET_CONF_IPADDR0                         192
#define ETHERNET_CONF_IPADDR1                         168
#define ETHERNET_CONF_IPADDR2                         0
#define ETHERNET_CONF_IPADDR3                         2
#endif

/*! The gateway address being used. */
#define ETHERNET_CONF_GATEWAY_ADDR0                   192
#define ETHERNET_CONF_GATEWAY_ADDR1                   168
#define ETHERNET_CONF_GATEWAY_ADDR2                   0
#define ETHERNET_CONF_GATEWAY_ADDR3                   1

/*! The network mask being used. */
#define ETHERNET_CONF_NET_MASK0                       255
#define ETHERNET_CONF_NET_MASK1                       255
#define ETHERNET_CONF_NET_MASK2                       255
#define ETHERNET_CONF_NET_MASK3                       0

#endif
