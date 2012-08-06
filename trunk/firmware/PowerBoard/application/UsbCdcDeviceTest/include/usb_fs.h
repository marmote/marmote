/******************** (C) COPYRIGHT 2011 STMicroelectronics ********************
* File Name          : hw_config.h
* Author             : MCD Application Team
* Version            : V3.3.0
* Date               : 21-March-2011
* Description        : Hardware Configuration & Setup
********************************************************************************
* THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
* WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE TIME.
* AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY DIRECT,
* INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING FROM THE
* CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE CODING
* INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
*******************************************************************************/

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __USB_H
#define __USB_H

/* Includes ------------------------------------------------------------------*/
#include "usb_type.h"
#include "power_board.h"

/* Exported types ------------------------------------------------------------*/
/* Exported constants --------------------------------------------------------*/
/* Exported macro ------------------------------------------------------------*/
/* Exported define -----------------------------------------------------------*/
//#define MASS_MEMORY_START     0x04002000
#define BULK_MAX_PACKET_SIZE  0x00000040
													
#define USB_USBDP_PIN    		GPIO_Pin_12 // PA.12
#define USB_USBDP_GPIO_PORT    	GPIOA
#define USB_USBDP_GPIO_CLK    	RCC_APB2Periph_GPIOA

enum { USB_TX_BUFFER_SIZE = 256 };

static uint8_t USB_Tx_Buffer[USB_TX_BUFFER_SIZE];
static uint8_t USB_Tx_Buffer_Start = 0; // Index of first valid element
static uint8_t USB_Tx_Buffer_Count = 0; // Number of valid elements in buffer

/* Exported functions ------------------------------------------------------- */
//void Set_System(void);
static void Set_USBClock(void);
void Enter_LowPowerMode(void);
void Leave_LowPowerMode(void);
void Handle_USBAsynchXfer (void);
void Get_SerialNum(void);

void USB_FsInit(void); // USB_Init() is reserved by STM USB library
void USB_SoftReset(void);

uint8_t USB_SendMsg(const char* msg, uint8_t length);
uint8_t USB_SendString(const char* msg);
uint8_t USB_GetTxLength(void);

/* External variables --------------------------------------------------------*/

#endif  /*__USB_H*/
/******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/
