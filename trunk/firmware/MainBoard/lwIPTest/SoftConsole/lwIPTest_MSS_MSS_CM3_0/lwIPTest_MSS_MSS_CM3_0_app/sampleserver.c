#include <stdio.h>
#include <string.h>

#include "lwip/inet.h"
#include "lwip/err.h"
#include "lwip/udp.h"
#include "lwip/mem.h"

#include "sampleserver.h"


/*..........................................................................*/
err_t send_buffer (struct udp_pcb *pcb,
		                 /*struct ip_addr *to_ip,
		                 int to_port,*/
		                 char *buf,
		                 int buflen)
{
	struct ip_addr *to_ip = &(pcb->remote_ip);
	int to_port = pcb->remote_port;

    err_t err;
    struct pbuf *pkt_buf;

    pkt_buf = pbuf_alloc(PBUF_TRANSPORT, buflen, PBUF_POOL);
    if (!pkt_buf)
    {
//        iprintf("error allocating pkt buffer\n\r");
        return ERR_MEM;
    }
    // Copy the original data buffer over to the packet buffer's payload
    memcpy(pkt_buf->payload, buf, buflen);
    // send message
    err = udp_sendto(pcb, pkt_buf, to_ip, to_port);
    pbuf_free(pkt_buf);
    return err;
}


/*..........................................................................*/
void recv_callback(void *arg,
					   struct udp_pcb *pcb,
		               struct pbuf *pkt_buf,
		               struct ip_addr *addr,
		               u16_t port)
{
	pcb->remote_port = port;
	pcb->remote_ip = *addr;

//Process
	struct pbuf* p = pkt_buf;

	while (p && p->len)
	{
		receive_callback(p->payload, p->len);
		p = p->next;
	}

//Free buff
	pbuf_free(pkt_buf);

// if error close
	//udp_remove(pcb);
}


/*..........................................................................*/
struct udp_pcb *server_init(u16_t port)
{
    struct udp_pcb *pcb;
    err_t err;

    pcb = udp_new();
    if (!pcb)
    {
//    	iprintf("Error creating PCB. Out of Memory\n\r");
        return NULL;
    }

    err = udp_bind(pcb, IP_ADDR_ANY, port);
    if (err != ERR_OK)
    {
//        iprintf("Unable to bind to port %d: err = %d\n\r", port, err);
        return NULL;
    }

    udp_recv(pcb, recv_callback, NULL);

    return pcb;
}
