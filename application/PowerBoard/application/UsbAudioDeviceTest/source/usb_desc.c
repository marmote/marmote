/******************** (C) COPYRIGHT 2011 STMicroelectronics ********************
* File Name          : usb_desc.c
* Author             : MCD Application Team
* Version            : V3.3.0
* Date               : 21-March-2011
* Description        : Descriptors for Audio Microphone Demo
********************************************************************************
* THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
* WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE TIME.
* AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY DIRECT,
* INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING FROM THE
* CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE CODING
* INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
*******************************************************************************/

/* Includes ------------------------------------------------------------------*/
#include "usb_lib.h"
#include "usb_desc.h"

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private constants----------------------------------------------------------*/
/* USB Standard Device Descriptor */
const uint8_t Microphone_DeviceDescriptor[] =
{
/* Descriptor Length                       */ 0x12u,
/* DescriptorType: DEVICE                  */ 0x01u,
/* bcdUSB (ver 2.0)                        */ 0x00u, 0x02u,
/* bDeviceClass                            */ 0x00u,
/* bDeviceSubClass                         */ 0x00u,
/* bDeviceProtocol                         */ 0x00u,
/* bMaxPacketSize0                         */ 0x40u,
/* idVendor                                */ 0x84u, 0x34u,
/* idProduct                               */ 0x41u, 0x57u,
/* bcdDevice                               */ 0x00u, 0x00u,
/* iManufacturer                           */ 0x01u,
/* iProduct                                */ 0x02u,
/* iSerialNumber                           */ 0x00u,
/* bNumConfigurations                      */ 0x01u
};

/* USB Configuration Descriptor */
/*   All Descriptors (Configuration, Interface, Endpoint, Class, Vendor */
const uint8_t Microphone_ConfigDescriptor[] =
{
/*  Config Descriptor Length               */ 0x09u,
/*  DescriptorType: CONFIG                 */ 0x02u,
/*  wTotalLength                           */ 0x6fu, 0x00u,
/*  bNumInterfaces                         */ 0x02u,
/*  bConfigurationValue                    */ 0x01u,
/*  iConfiguration                         */ 0x00u,
/*  bmAttributes                           */ 0x80u,
/*  bMaxPower                              */ 0xF8u,
/*********************************************************************
 Audio Interface Descriptor (AudioControl)
 *********************************************************************/
/*  Interface Descriptor Length            */ 0x09u,
/*  DescriptorType: INTERFACE              */ 0x04u,
/*  bInterfaceNumber                       */ 0x00u,
/*  bAlternateSetting                      */ 0x00u,
/*  bNumEndpoints                          */ 0x00u,
/*  bInterfaceClass                        */ 0x01u,
/*  bInterfaceSubClass                     */ 0x01u,
/*  bInterfaceProtocol                     */ 0x0bu,
/*  iInterface                             */ 0x00u,
/*********************************************************************
 AC Header Descriptor
 *********************************************************************/
/*  AC Header Descriptor Length            */ 0x09u,
/*  DescriptorType: AUDIO                  */ 0x24u,
/*  bDescriptorSubtype                     */ 0x01u,
/*  bcdADC                                 */ 0x00u, 0x01u,
/*  wTotalLength                           */ 0x29u, 0x00u,
/*  bInCollection                          */ 0x01u,
/*  baInterfaceNr                          */ 0x01u,
/*********************************************************************
 AC Input Terminal Descriptor
 *********************************************************************/
/*  AC Input Terminal Descriptor Length    */ 0x0Cu,
/*  DescriptorType: AUDIO                  */ 0x24u,
/*  bDescriptorSubtype                     */ 0x02u,
/*  bTerminalID                            */ 0x04u,
/*  wTerminalType                          */ 0x01u, 0x02u,
/*  bAssocTerminal                         */ 0x00u,
/*  bNrChannels                            */ 0x01u,
/*  wChannelConfig                         */ 0x00u, 0x00u,
/*  iChannelNames                          */ 0x00u,
/*  iTerminal                              */ 0x00u,
/*********************************************************************
 AC Feature Unit Descriptor
 *********************************************************************/
/*  AC Feature Unit Descriptor Length      */ 0x0bu,
/*  DescriptorType: AUDIO                  */ 0x24u,
/*  bDescriptorSubtype                     */ 0x06u,
/*  bUnitID                                */ 0x05u,
/*  bSourceID                              */ 0x04u,
/*  bControlSize                           */ 0x02u,
/*  bmaControls                            */ 0x01u, 0x00u, 0x02u, 0x00u,
/*  iFeature                               */ 0x00u,
/*********************************************************************
 AC Output Terminal Descriptor
 *********************************************************************/
/*  AC Output Terminal Descriptor Length   */ 0x09u,
/*  DescriptorType: AUDIO                  */ 0x24u,
/*  bDescriptorSubtype                     */ 0x03u,
/*  bTerminalID                            */ 0x06u,
/*  wTerminalType                          */ 0x01u, 0x01u,
/*  bAssocTerminal                         */ 0x00u,
/*  bSourceID                              */ 0x05u,
/*  iTerminal                              */ 0x00u,

/*********************************************************************
 Audio Interface Descriptor (Zero-bandwidth AudioStreaming)
 *********************************************************************/
/*  Interface Descriptor Length            */ 0x09u,
/*  DescriptorType: INTERFACE              */ 0x04u,
/*  bInterfaceNumber                       */ 0x01u,
/*  bAlternateSetting                      */ 0x00u,
/*  bNumEndpoints                          */ 0x00u,
/*  bInterfaceClass                        */ 0x01u,
/*  bInterfaceSubClass                     */ 0x02u,
/*  bInterfaceProtocol                     */ 0x00u,
/*  iInterface                             */ 0x00u,

/*********************************************************************
 Audio Interface Descriptor (Mono AudioStreaming)
 *********************************************************************/
/*  Interface Descriptor Length            */ 0x09u,
/*  DescriptorType: INTERFACE              */ 0x04u,
/*  bInterfaceNumber                       */ 0x01u,
/*  bAlternateSetting                      */ 0x01u,
/*  bNumEndpoints                          */ 0x01u,
/*  bInterfaceClass                        */ 0x01u,
/*  bInterfaceSubClass                     */ 0x02u,
/*  bInterfaceProtocol                     */ 0x00u,
/*  iInterface                             */ 0x00u,
/*********************************************************************
 AS General Descriptor
 *********************************************************************/
/*  AS General Descriptor Length           */ 0x07u,
/*  DescriptorType: AUDIO                  */ 0x24u,
/*  bDescriptorSubtype                     */ 0x01u,
/*  bTerminalLink                          */ 0x06u,
/*  bDelay                                 */ 0x00u,
/*  wFormatTag                             */ 0x01u, 0x00u,
/*********************************************************************
 AS Format Type I Descriptor
 *********************************************************************/
/*  AS Format Type I Descriptor Length     */ 0x0Bu,
/*  DescriptorType: AUDIO                  */ 0x24u,
/*  bDescriptorSubtype                     */ 0x02u,
/*  bFormatType                            */ 0x01u,
/*  bNrChannels                            */ 0x01u,
/*  bSubframeSize                          */ 0x02u,
/*  bBitResolution                         */ 0x10u,
/*  bSamFreqType                           */ 0x01u,
/*  tSamFreq                               */ 0x00u, 0x77u, 0x01u, // !
/*********************************************************************
 Endpoint Descriptor (Mono Microphone Standard AS Audio Data EP)
 *********************************************************************/
/*  Endpoint Descriptor Length             */ 0x09u,
/*  DescriptorType: ENDPOINT               */ 0x05u,
/*  bEndpointAddress                       */ 0x81u, // !
/*  bmAttributes                           */ 0x0Du,
/*  wMaxPacketSize                         */ 0xC0u, 0x00u, // !
/*  bInterval                              */ 0x01u,
/*  bRefresh                               */ 0x00u,
/*  bSynchAddress                          */ 0x00u,
/*********************************************************************
 AS Endpoint Descriptor (Microphone Class-specific Iso Audio Data EP)
 *********************************************************************/
/*  Endpoint Descriptor Length             */ 0x07u,
/*  DescriptorType: CS_ENDPOINT            */ 0x25u,
/*  bDescriptorSubtype                     */ 0x01u,
/*  bmAttributes                           */ 0x00u,
/*  bLockDelayUnits                        */ 0x00u,
/*  wLockDelay                             */ 0x00u, 0x00u
};

/* USB String Descriptor (optional) */
const uint8_t Microphone_StringLangID[MICROPHONE_SIZ_STRING_LANGID] =
  {
    0x04,
    0x03,
    0x09,
    0x04
  }
  ; /* LangID = 0x0409: U.S. English */

const uint8_t Microphone_StringVendor[MICROPHONE_SIZ_STRING_VENDOR] =
  {
    MICROPHONE_SIZ_STRING_VENDOR, /* Size of manufacturer string */
    0x03,  /* bDescriptorType*/
    /* Manufacturer: "STMicroelectronics" */
    'S', 0, 'T', 0, 'M', 0, 'i', 0, 'c', 0, 'r', 0, 'o', 0, 'e', 0,
    'l', 0, 'e', 0, 'c', 0, 't', 0, 'r', 0, 'o', 0, 'n', 0, 'i', 0,
    'c', 0, 's', 0
  };

const uint8_t Microphone_StringProduct[MICROPHONE_SIZ_STRING_PRODUCT] =
  {
    MICROPHONE_SIZ_STRING_PRODUCT,  /* bLength */
    0x03,        /* bDescriptorType */
    'S', 0, 'T', 0, 'M', 0, '3', 0, '2', 0, ' ', 0,
    'R', 0, 'e', 0, 'c', 0, 'o', 0, 'r', 0, 'd', 0, 'e', 0, 'r', 0
  };

uint8_t Microphone_StringSerial[MICROPHONE_SIZ_STRING_SERIAL] =
  {
    MICROPHONE_SIZ_STRING_SERIAL,  /* bLength */
    0x03,        /* bDescriptorType */
    'S', 0, 'T', 0, 'M', 0, '3', 0, '2', 0, '1', 0, '0', 0
  };
/* Extern variables ----------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Extern function prototypes ------------------------------------------------*/
/* Private functions ---------------------------------------------------------*/

/******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/
