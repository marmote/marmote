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
#include <mss_timer.h>

#include <string.h>


#define MSS_GPIO_LED1 				MSS_GPIO_0
#define MSS_GPIO_AFE1_ENABLE		MSS_GPIO_1
//#define MSS_GPIO_LED2 				MSS_GPIO_7
#define MSS_GPIO_AFE1_MODE			MSS_GPIO_7
#define MSS_GPIO_TX_DONE_IT			MSS_GPIO_8
#define MSS_GPIO_SFD_IT				MSS_GPIO_9
#define MSS_GPIO_RX_DONE_IT			MSS_GPIO_10


#define MSS_GPIO_LED1_MASK 			MSS_GPIO_0_MASK
#define MSS_GPIO_AFE1_ENABLE_MASK 	MSS_GPIO_1_MASK
//#define MSS_GPIO_LED2_MASK 			MSS_GPIO_7_MASK
#define MSS_GPIO_AFE1_MODE_MASK		MSS_GPIO_7_MASK
#define MSS_GPIO_TX_DONE_IT_MASK	MSS_GPIO_8_MASK
#define MSS_GPIO_SFD_IT_MASK		MSS_GPIO_9_MASK
#define MSS_GPIO_RX_DONE_IT_MASK	MSS_GPIO_10_MASK


#define MSS_GPIO_TX_DONE_IRQn  		GPIO8_IRQn
#define MSS_GPIO_SFD_IRQn	  		GPIO9_IRQn
#define MSS_GPIO_RX_DONE_IRQn  		GPIO10_IRQn

uint8_t sfd_it_flag;
uint8_t rx_done_it_flag;

typedef struct
{
  __IO uint32_t CTRL;                      /*!< Offset: 0x00  Control/status Register       */
  __O  uint32_t TX_FIFO;                   /*!< Offset: 0x04  Data Register             	*/
  __IO uint32_t TEST;                      /*!< Offset: 0x08  Test Register             	*/
  __IO uint32_t MOD_MUX;                   /*!< Offset: 0x0C  Modulator input multiplexer Register */
} TX_CTRL_Type;

#define TX_CTRL            ((TX_CTRL_Type *)       TX_APB_IF_0)   /*!< TX CTRL register struct */



typedef struct
{
  __IO uint32_t CTRL;                      /*!< Offset: 0x00  Control/status Register       */
  __I  uint32_t RX_FIFO;                   /*!< Offset: 0x04  Data Register             	*/
} RX_CTRL_Type;

#define RX_CTRL            ((RX_CTRL_Type *)       RX_APB_IF_0)   /*!< RX CTRL register struct */

#define RX_FIFO_EMPTY_BIT_MASK 0x2

typedef enum _mod_mux_path
{
	MOD_PATH_PACKET 	= 0,
	MOD_PATH_CONST_0  	= 1,
	MOD_PATH_CONST_1  	= 2,
	MOD_PATH_RANDOM 	= 3
} mod_mux_path_t;


typedef struct
{
  __IO uint32_t CTRL;                      /*!< Offset: 0x00  Control/status register   */
  __O  uint32_t TX_I;                      /*!< Offset: 0x04  I register             	*/
  __O  uint32_t TX_Q;                      /*!< Offset: 0x08  Q register             	*/
  __IO uint32_t MUX1;                       /*!< Offset: 0x0C  AFE1 MUX SEL register         	*/
  __IO uint32_t MUX2;                       /*!< Offset: 0x0C  AFE2 MUX SEL register         	*/
} BB_CTRL_Type;

#define BB_CTRL            ((BB_CTRL_Type *)       DATAPATH_STUB_APB_0)   /*!< BB CTRL register struct */


typedef enum _afe_mode
{
	AFE_RX_MODE = 0,
	AFE_TX_MODE = 1,
} afe_mode_t;

typedef enum _afe_mux_path
{
	MUX_PATH_OFF = 0,
	MUX_PATH_RX  = 1,
	MUX_PATH_TX  = 2,
	MUX_PATH_IQ_REG = 3
} afe_mux_path_t;



#endif /* TETON_H_ */
