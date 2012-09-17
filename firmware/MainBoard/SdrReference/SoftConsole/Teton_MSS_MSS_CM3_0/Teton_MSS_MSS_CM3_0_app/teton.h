/*
 * teton.h
 *
 *  Created on: Aug 3, 2012
 *      Author: sszilvasi
 */

#ifndef TETON_H_
#define TETON_H_

#include <Teton_hw_platform.h>
#include <mss_gpio.h>

#include <string.h>



#define MSS_GPIO_LED1 				MSS_GPIO_0
#define MSS_GPIO_AFE_ENABLE			MSS_GPIO_1
#define MSS_GPIO_LED2 				MSS_GPIO_7
#define MSS_GPIO_USB_CTRL_IT 		MSS_GPIO_8

#define MSS_GPIO_LED1_MASK 			MSS_GPIO_0_MASK
#define MSS_GPIO_AFE_ENABLE_MASK 	MSS_GPIO_1_MASK
#define MSS_GPIO_LED2_MASK 			MSS_GPIO_7_MASK
#define MSS_GPIO_USB_CTRL_IT_MASK 	MSS_GPIO_8_MASK

#define MSS_GPIO_USB_CTRL_IT_IRQn  	GPIO8_IRQn

#define SDR_STREAM_ENABLE_MASK 		0x01


typedef struct
{
  __I  uint32_t STAT;                      /*!< Offset: 0x00  Status Register             	*/
  __O  uint32_t TXC;                       /*!< Offset: 0x04  Data Register             	*/
  __I  uint32_t RXC;                       /*!< Offset: 0x08  Data Register             	*/
  __IO uint32_t SDR;                       /*!< Offset: 0x0C  Data Register             	*/
} USB_CTRL_Type;

#define USB_CTRL            ((USB_CTRL_Type *)       USB_IF_0)   /*!< USB CTRL register struct */


#define SYNC_CHAR_1 0xB5
#define SYNC_CHAR_2 0x63 // ASCII 'b'

typedef enum _usb_pkt_state
{
	SYNC_1,
	SYNC_2,
	MSG_CLASS,
	MSG_ID,
	LEN_1,
	LEN_2,
	PAYLOAD,
	CHK_A,
	CHK_B,
} usb_pkt_state_t;


#define USB_BUF_LENGTH 150
extern usb_pkt_state_t ups;
extern uint8_t usb_cmd_buf[USB_BUF_LENGTH];
extern uint8_t usb_cmd_valid;

typedef enum _MsgClass
{
	MARMOTE = 1,
	SDR = 2,
	MAX2830 = 3,
} MsgClass_t;

typedef enum _MsgId
{
	// Marmote
	SET_LED = 1,
	// SDR
	START_STREAMING = 2,
	STOP_STREAMING = 3,
	SET_FREQUENCY = 4,
	GET_FREQUENCY = 5,
	// MAX2830
	SET_REG = 6,
	GET_REG = 7,
} MsgId_t;

typedef struct
{
	uint8_t sync_1;
	uint8_t sync_2;
	uint8_t msg_class;
	uint8_t msg_id;
	uint16_t len; // payload length (little-endian, max. 128 excluding sync chars, class, id and checksum fields)
	uint8_t payload[];
	// uint8_t chk_a;
	// uint8_t chk_b;
} PktHdr_t;

void USB_SendMsg(MsgClass_t msg_class, MsgId_t msg_id, const uint8_t* payload, uint16_t len);

#endif /* TETON_H_ */
