/*
 * teton.h
 *
 *  Created on: Aug 3, 2012
 *      Author: sszilvasi
 */

#ifndef TETON_H_
#define TETON_H_

#include <Teton_hw_platform.h>



//#define MSS_GPIO_LED1 				MSS_GPIO_0
#define MSS_GPIO_AFE_ENABLE			MSS_GPIO_1
//#define MSS_GPIO_LED2 				MSS_GPIO_7
#define MSS_GPIO_USB_CTRL_IT 		MSS_GPIO_8

//#define MSS_GPIO_LED1_MASK 			MSS_GPIO_0_MASK
#define MSS_GPIO_AFE_ENABLE_MASK 	MSS_GPIO_1_MASK
//#define MSS_GPIO_LED2_MASK 			MSS_GPIO_7_MASK
#define MSS_GPIO_USB_CTRL_IT_MASK 	MSS_GPIO_8_MASK

#define MSS_GPIO_USB_CTRL_IT_IRQn  	GPIO8_IRQn

typedef struct
{
  __I  uint32_t STAT;                      /*!< Offset: 0x00  Status Register             	*/
  __O  uint32_t TXC;                       /*!< Offset: 0x04  Data Register             	*/
  __I  uint32_t RXC;                       /*!< Offset: 0x08  Data Register             	*/
  __IO  uint32_t TEST;
} USB_CTRL_Type;

#define USB_CTRL            ((USB_CTRL_Type *)       USB_IF_0)   /*!< USB CTRL register struct */

#endif /* TETON_H_ */
