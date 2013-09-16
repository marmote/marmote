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
#include "joshua.h"
#include "yellowstone.h"
#include "max19706.h"

#include "cmd_def.h"


#define MSS_GPIO_LED1 				MSS_GPIO_0
#define MSS_GPIO_AFE1_ENABLE		MSS_GPIO_1
//#define MSS_GPIO_LED2 				MSS_GPIO_X
#define MSS_GPIO_AFE1_MODE			MSS_GPIO_7
#define MSS_GPIO_TX_DONE_IT			MSS_GPIO_8


#define MSS_GPIO_LED1_MASK 			MSS_GPIO_0_MASK
#define MSS_GPIO_AFE1_ENABLE_MASK 	MSS_GPIO_1_MASK
//#define MSS_GPIO_LED2_MASK 			MSS_GPIO_X_MASK
#define MSS_GPIO_AFE1_MODE_MASK		MSS_GPIO_7_MASK
#define MSS_GPIO_TX_DONE_IT_MASK	MSS_GPIO_8_MASK


typedef struct
{
  __I uint32_t REV;                       /*!< Offset: 0x00  Board revision   */
  __I uint32_t ID;                        /*!< Offset: 0x04  Node ID (serial) */
} BOARD_Type;

#define MM_BOARD            ((BOARD_Type *)       FROM_BASE)   /*!< BOARD_Type register struct */

uint8_t node_rev;
uint8_t node_id;

#define MICRO_SEC_DIV 20
#define MILLI_SEC_DIV (1000 * MICRO_SEC_DIV)

#define MSS_GPIO_TX_DONE_IRQn  		GPIO8_IRQn

uint8_t tx_done_it_flag;

typedef struct
{
  __IO uint32_t CTRL;                      	/*!< Offset: 0x00  Control/status Register       			*/
  __IO uint32_t DUMMY_[3];					/*!< Placeholder 											*/

  __IO uint32_t PTRN;                   	/*!< Offset: 0x10  Subcarrier Pattern Register 	(16-bit) 	*/
  __IO uint32_t MASK;                   	/*!< Offset: 0x14  Subcarrier Mask Register (16-bit)	 	*/
} TX_CTRL_Type;

#define TX_CTRL            ((TX_CTRL_Type *)       TX_APB_IF_0)   /*!< TX CTRL register struct */

typedef enum _afe_mode
{
	AFE_RX_MODE = 0,
	AFE_TX_MODE = 1,
} afe_mode_t;

typedef enum __radio_mode_t
{
	RADIO_SHUTDOWN_MODE	= 0,
	RADIO_STANDBY_MODE	= 1,
	RADIO_RX_MODE		= 2,
	RADIO_TX_MODE 		= 3,
	RADIO_TX_PERIODIC_MODE 		= 4
} radio_operating_mode_t;

static radio_operating_mode_t radio_mode;

void Teton_init(void);
void set_mode(radio_operating_mode_t mode);
radio_operating_mode_t get_mode();

void process_spi_cmd_buf(const char* cmd_buf, uint8_t length);

#endif /* TETON_H_ */
