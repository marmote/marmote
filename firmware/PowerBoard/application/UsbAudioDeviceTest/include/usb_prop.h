/******************** (C) COPYRIGHT 2011 STMicroelectronics ********************
* File Name          : usb_prop.h
* Author             : MCD Application Team
* Version            : V3.3.0
* Date               : 21-March-2011
* Description        : All processing related to Mass Storage Demo (Endpoint 0)
********************************************************************************
* THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
* WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE TIME.
* AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY DIRECT,
* INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING FROM THE
* CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE CODING
* INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
*******************************************************************************/

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __usb_prop_H
#define __usb_prop_H

/* Includes ------------------------------------------------------------------*/
/* Exported types ------------------------------------------------------------*/
/* Exported constants --------------------------------------------------------*/
/* Exported macro ------------------------------------------------------------*/
/* Exported functions ------------------------------------------------------- */
void Microphone_init(void);
void Microphone_Reset(void);
void Microphone_SetConfiguration(void);
void Microphone_SetDeviceAddress (void);
void Microphone_Status_In (void);
void Microphone_Status_Out (void);
RESULT Microphone_Data_Setup(uint8_t);
RESULT Microphone_NoData_Setup(uint8_t);
RESULT Microphone_Get_Interface_Setting(uint8_t Interface, uint8_t AlternateSetting);
uint8_t *Microphone_GetDeviceDescriptor(uint16_t );
uint8_t *Microphone_GetConfigDescriptor(uint16_t);
uint8_t *Microphone_GetStringDescriptor(uint16_t);
uint8_t *Mute_Command(uint16_t Length);

/* Exported define -----------------------------------------------------------*/
#define Microphone_GetConfiguration          NOP_Process
//#define Microphone_SetConfiguration          NOP_Process
#define Microphone_GetInterface              NOP_Process
#define Microphone_SetInterface              NOP_Process
#define Microphone_GetStatus                 NOP_Process
#define Microphone_ClearFeature              NOP_Process
#define Microphone_SetEndPointFeature        NOP_Process
#define Microphone_SetDeviceFeature          NOP_Process
//#define Microphone_SetDeviceAddress          NOP_Process
#define GET_CUR                           0x81
#define SET_CUR                           0x01

#endif /* __usb_prop_H */
/******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/

