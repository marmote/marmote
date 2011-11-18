#ifndef __SERVER_H__
#define __SERVER_H__

#ifdef __cplusplus
extern "C" {
#endif

void receive_callback(void* data, u16_t len);

struct udp_pcb *server_init(u16_t port);

err_t send_buffer (struct udp_pcb *pcb,
		                /* struct ip_addr *to_ip,
		                 int to_port,*/
		                 char *buf,
		                 int buflen);

#ifdef __cplusplus
}
#endif

#endif /* __SERVER_H__ */
