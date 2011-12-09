#ifndef __SERVER_H__
#define __SERVER_H__

#ifdef __cplusplus
extern "C" {
#endif

struct tcp_pcb *server_init(u16_t port);
void send_buffer(struct tcp_pcb		*pcb,
				void*				buffer,
				u32_t				buf_size);

#ifdef __cplusplus
}
#endif

#endif /* __SERVER_H__ */
