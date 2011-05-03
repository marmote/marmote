#include "sampleserver.h"

/**************************************************************************/
/* Standard Includes */
/**************************************************************************/

#include <stdio.h>
#include <stdlib.h>

/**************************************************************************/
/* Driver Includes */
/**************************************************************************/

#include "../drivers/mss_ethernet_mac/mss_ethernet_mac.h"
#include "../drivers/mac/tcpip.h"
#include "conf_eth.h"

#include "lwip/tcp.h"

#include "cpu_types.h"
/**************************************************************************/
/* Definitions for Ethernet test */
/**************************************************************************/

#define OPEN_IP
#define BUF                       ((struct uip_eth_hdr *)&uip_buf[0])
#ifndef DEFAULT_NETMASK0
#define DEFAULT_NETMASK0          255
#endif

#ifndef DEFAULT_NETMASK1
#define DEFAULT_NETMASK1          255
#endif

#ifndef DEFAULT_NETMASK2
#define DEFAULT_NETMASK2          0
#endif

#ifndef DEFAULT_NETMASK3
#define DEFAULT_NETMASK3          0
#endif
#define TCP_PKT_SIZE              1600
#define IP_ADDR_LEN               4
#define PHY_ADDRESS               1
#define DHCP_ATTEMPTS             4
#define USER_RX_BUFF_SIZE         1600

/**************************************************************************/
/* Extern Declarations */
/**************************************************************************/
extern unsigned char              my_ip[4];
extern unsigned int               num_pkt_rx;
extern unsigned char              ip_known;
extern unsigned char              my_ip[IP_ADDR_LEN];
extern unsigned char              tcp_packet[TCP_PKT_SIZE];
extern unsigned char              dhcp_ip_found;

unsigned char appdata[5120];
char ethAddr[6] = {0xaa,0xbb,0xcc,0x66,0x55,0x44};

struct http_state {
  char *file;
  u16_t left;
  u8_t retries;
};

/**************************************************************************/
/* Function to Initialize the MAC, setting the MAC address and */
/* fetches the IP address */
/**************************************************************************/
void init_mac()
{
    uint32_t time_out = 0;
    int32_t mac_cfg;
    int32_t i;
    int32_t rx_size;
    uint8_t rx_buffer[USER_RX_BUFF_SIZE];
    MSS_MAC_init( PHY_ADDRESS );
    /*
     * Configure the MAC.
     */
    mac_cfg = MSS_MAC_get_configuration();

    mac_cfg &= ~( MSS_MAC_CFG_STORE_AND_FORWARD | MSS_MAC_CFG_PASS_BAD_FRAMES );
    mac_cfg |=
    MSS_MAC_CFG_RECEIVE_ALL |
    MSS_MAC_CFG_PROMISCUOUS_MODE |
    MSS_MAC_CFG_FULL_DUPLEX_MODE |
    MSS_MAC_CFG_TRANSMIT_THRESHOLD_MODE |
    MSS_MAC_CFG_THRESHOLD_CONTROL_00;

    MSS_MAC_configure(mac_cfg );
    MSS_MAC_set_mac_address((uint8_t *)ethAddr);
    tcp_init();

    ip_known = 0;
    num_pkt_rx = 0;
    time_out = 0;
    for (i = 0; i < 1600; i++)
    {
        rx_buffer[i] = 0;
    }

    /* Logic to get the open IP address */
#ifdef OPEN_IP
    do
    {
        send_bootp_packet(0);
        do
        {
            rx_size = MSS_MAC_rx_pckt_size();
            time_out++;
            if(dhcp_ip_found)
                break;
         }while ( rx_size == 0 && (time_out < 3000000));
         MSS_MAC_rx_packet( rx_buffer, USER_RX_BUFF_SIZE, MSS_MAC_BLOCKING );
         num_pkt_rx++;
         process_packet( rx_buffer );
    }while((!dhcp_ip_found) && (time_out < 7000000));
#endif

//BB    show_ip();
}

/*-----------------------------------------------------------------------------------*/

static void
conn_err(void *arg, err_t err)
{
  struct http_state *hs;

  LWIP_UNUSED_ARG(err);

  hs = arg;
  mem_free(hs);
}

/*-----------------------------------------------------------------------------------*/

static void
close_conn(struct tcp_pcb *pcb, struct http_state *hs)
{
  tcp_arg(pcb, NULL);
  tcp_sent(pcb, NULL);
  tcp_recv(pcb, NULL);
  mem_free(hs);
  tcp_close(pcb);
}

/*-----------------------------------------------------------------------------------*/

static void
send_data(struct tcp_pcb *pcb, struct http_state *hs)
{
  err_t err;
  u16_t len;

  /* We cannot send more data than space available in the send
     buffer. */
  if (tcp_sndbuf(pcb) < hs->left) {
    len = tcp_sndbuf(pcb);
  } else {
    len = hs->left;
  }

  do {
    err = tcp_write(pcb, hs->file, len, 0);
    if (err == ERR_MEM) {
      len /= 2;
    }
  } while (err == ERR_MEM && len > 1);

  if (err == ERR_OK) {
    hs->file += len;
    hs->left -= len;
    /*  } else {
    printf("send_data: error %s len %d %d\n", lwip_strerr(err), len, tcp_sndbuf(pcb));*/
  }
}

/*-----------------------------------------------------------------------------------*/

static err_t
server_sent(void *arg, struct tcp_pcb *pcb, u16_t len)
{
  struct http_state *hs;

  LWIP_UNUSED_ARG(len);

  hs = arg;

  hs->retries = 0;

  if (hs->left > 0) {
    send_data(pcb, hs);
  } else {


	  appdata[0] = 0xAA;
	  appdata[1] = 0xAA;
	  appdata[2] = 0xAA;
	  appdata[3] = 0xAA;
	  appdata[4] = 0xAA;
	  appdata[5] = 0xAA;
	  appdata[6] = 0xAA;
	  appdata[7] = 0xAA;
	  hs->file = (char *)appdata;
	  hs->left = 8;
	  send_data(pcb, hs);
	  // Tell TCP that we wish be to informed of data that has been
	  //   successfully sent by a call to the http_sent() function.
	  tcp_sent(pcb, server_sent);


//    close_conn(pcb, hs);
  }

  return ERR_OK;
}

/*-----------------------------------------------------------------------------------*/

static err_t
server_poll(void *arg, struct tcp_pcb *pcb)
{
  struct http_state *hs;

  hs = arg;

  /*  printf("Polll\n");*/
  if (hs == NULL) {
    /*    printf("Null, close\n");*/
    tcp_abort(pcb);
    return ERR_ABRT;
  } else {
    ++hs->retries;
    if (hs->retries == 4) {
      tcp_abort(pcb);
      return ERR_ABRT;
    }
    send_data(pcb, hs);
  }

  return ERR_OK;
}

/*-----------------------------------------------------------------------------------*/

static err_t
server_recv(void *arg, struct tcp_pcb *pcb, struct pbuf *p, err_t err)
{
	  char *data;
	  struct http_state *hs;
	  //unsigned char Buff[10240];

	  hs = (struct http_state *)arg;

	  if (err == ERR_OK && p != NULL) {

	    /* Inform TCP that we have taken the data. */
	    tcp_recved(pcb, p->tot_len);

	    if (hs->file == NULL)
	    {
	       hs->left = 0;
	       data = (char *)p->payload;
           //iprintf("%s\n",data);


    	   //TODO: insert fancy data processing here...

	       /*
	       if (strncmp(data, "GET ", 4) == 0)
	       {
	    	   //TODO: data processing here...

	    	   hs->file = (char *)appdata;
		       hs->left = 1000;

		       pbuf_free(p);
               send_data(pcb, hs);
               // Tell TCP that we wish be to informed of data that has been
	           //   successfully sent by a call to the http_sent() function.
               tcp_sent(pcb, http_sent);
	       }
	       else
	       {
	           pbuf_free(p);
	           close_conn(pcb, hs);
	       }
	       */
	   }
#if 1
	   else
	   {
	       pbuf_free(p);
	   }
#endif
	}

	if (err == ERR_OK && p == NULL)
	{
	    close_conn(pcb, hs);
    }
	return ERR_OK;
}

/*-----------------------------------------------------------------------------------*/

static err_t
server_accept(void *arg, struct tcp_pcb *pcb, err_t err)
{
  struct http_state *hs;

  LWIP_UNUSED_ARG(arg);
  LWIP_UNUSED_ARG(err);

  tcp_setprio(pcb, TCP_PRIO_MIN);

  /* Allocate memory for the structure that holds the state of the
     connection. */
  hs = (struct http_state *)mem_malloc(sizeof(struct http_state));

  if (hs == NULL) {
    iprintf("http_accept: Out of memory\n\r");
    return ERR_MEM;
  }

  /* Initialize the structure. */
  hs->file = NULL;
  hs->left = 0;
  hs->retries = 0;

  /* Tell TCP that this is the structure we wish to be passed for our
     callbacks. */
  tcp_arg(pcb, hs);

  /* Tell TCP that we wish to be informed of incoming data by a call
     to the http_recv() function. */
  tcp_recv(pcb, server_recv);

  tcp_err(pcb, conn_err);

  tcp_poll(pcb, server_poll, 4);



  appdata[0] = 0xAA;
  appdata[1] = 0xAA;
  appdata[2] = 0xAA;
  appdata[3] = 0xAA;
  appdata[4] = 0xAA;
  appdata[5] = 0xAA;
  appdata[6] = 0xAA;
  appdata[7] = 0xAA;
  hs->file = (char *)appdata;
  hs->left = 8;
  send_data(pcb, hs);
  // Tell TCP that we wish be to informed of data that has been
  //   successfully sent by a call to the http_sent() function.
  tcp_sent(pcb, server_sent);


  return ERR_OK;
}

/*-----------------------------------------------------------------------------------*/

void
server_init(void)
{
  struct tcp_pcb *pcb;

  pcb = tcp_new();
  tcp_bind(pcb, IP_ADDR_ANY, 80);
  pcb = tcp_listen(pcb);
  tcp_accept(pcb, server_accept);
}
