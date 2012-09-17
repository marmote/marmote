#include "teton.h"


uint8_t usb_buf[USB_BUF_LENGTH];
uint8_t usb_cmd_buf[USB_BUF_LENGTH];
uint8_t usb_cmd_valid = 0;
uint8_t* usb_buf_ptr = 0;
uint8_t upp_len; // packet payload length field
uint8_t upp_ctr; // received payload length counter
uint8_t chk_a;
uint8_t chk_b;

usb_pkt_state_t ups = SYNC_1;

void GPIO8_IRQHandler( void ) // TODO: rename to USB_CTRL_IRQHandler
{
	while ((USB_CTRL->STAT & 0x04) == 0)
	{
		switch (ups)
		{
			case SYNC_1 :

				usb_buf_ptr = usb_buf;
				upp_len = 0;
				upp_ctr = 0;

				if ((*usb_buf_ptr = USB_CTRL->RXC) == SYNC_CHAR_1)
				{
					ups = SYNC_2;
					usb_buf_ptr++;
				}
				break;

			case SYNC_2 :

				if ((*usb_buf_ptr = USB_CTRL->RXC) == SYNC_CHAR_2)
				{
					chk_a = 0;
					chk_b = 0;
					usb_buf_ptr++;
					ups = MSG_CLASS;
				}
				else
				{
					ups = SYNC_1;
				}
				break;

			case MSG_CLASS :

				ups = MSG_ID;
				*usb_buf_ptr = USB_CTRL->RXC;
				chk_a = *usb_buf_ptr;
				chk_b = chk_a;
				usb_buf_ptr++;
				break;

			case MSG_ID :

				*usb_buf_ptr = USB_CTRL->RXC;
				chk_a += *usb_buf_ptr;
				chk_b += chk_a;
				usb_buf_ptr++;
				ups = LEN_1;
				break;

			case LEN_1 :

				*usb_buf_ptr = USB_CTRL->RXC;
				upp_len = *usb_buf_ptr;
				chk_a += *usb_buf_ptr;
				chk_b += chk_a;
				usb_buf_ptr++;
				ups = LEN_2;
				break;

			case LEN_2 :

				*usb_buf_ptr = USB_CTRL->RXC;
				upp_len = upp_len + (*usb_buf_ptr << 8);
				chk_a += *usb_buf_ptr;
				chk_b += chk_a;

				if (*usb_buf_ptr || *(usb_buf_ptr-1))
				{
					ups = PAYLOAD;
				}
				else
				{
					// Zero-length payload
					ups = CHK_A;
				}
				usb_buf_ptr++;

				break;

			case PAYLOAD :

				*usb_buf_ptr = USB_CTRL->RXC;
				chk_a += *usb_buf_ptr;
				chk_b += chk_a;
				usb_buf_ptr++;
				upp_ctr++;

				if (upp_ctr == upp_len)
				{
					ups = CHK_A;
				}
				break;

			case CHK_A :

				*usb_buf_ptr = USB_CTRL->RXC;

				if (*usb_buf_ptr == chk_a)
				{
					usb_buf_ptr++;
					ups = CHK_B;
				}
				else
				{
					ups = SYNC_1;
				}
				break;

			case CHK_B :

				*usb_buf_ptr = USB_CTRL->RXC;


				if (*usb_buf_ptr == chk_b)
				{
					// Place payload in command buffer
					memcpy(usb_cmd_buf, usb_buf, 6 + upp_len + 2);
					usb_cmd_valid = 1;
				}
				ups = SYNC_1;
				break;

			default :
				break;
		}
	}

	MSS_GPIO_clear_irq( MSS_GPIO_USB_CTRL_IT );
}


void USB_SendMsg(MsgClass_t msg_class, MsgId_t msg_id, const uint8_t* payload, uint16_t len)
{
	uint8_t i;
	uint8_t chk_a;
	uint8_t chk_b;

	USB_CTRL->TXC = SYNC_CHAR_1;
	USB_CTRL->TXC = SYNC_CHAR_2;
	USB_CTRL->TXC = (uint8_t)msg_class;
	chk_a = (uint8_t)msg_class;
	chk_b = chk_a;
	USB_CTRL->TXC = (uint8_t)msg_id;
	chk_a += (uint8_t)msg_id;
	chk_b += chk_a;
	USB_CTRL->TXC = (uint8_t)(len & 0xFF);
	chk_a += (uint8_t)(len & 0xFF);
	chk_b += chk_a;
	USB_CTRL->TXC = (uint8_t)((len >> 8) & 0xFF);
	chk_a += (uint8_t)((len >> 8) & 0xFF);
	chk_b += chk_a;

	for (i = 0; i < len; i++)
	{
		USB_CTRL->TXC = *(payload + i);
		chk_a += *(payload + i);
		chk_b += chk_a;
	}

	USB_CTRL->TXC = chk_a;
	USB_CTRL->TXC = chk_b;
}

