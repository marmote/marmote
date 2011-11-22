/******************** (C) COPYRIGHT 2011 STMicroelectronics ********************
* File Name          : usb_prop.c
* Author             : MCD Application Team
* Version            : V3.3.0
* Date               : 21-March-2011
* Description        : All processing related to Audio Microphone Demo
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
#include "usb_conf.h"
#include "usb_prop.h"
#include "usb_desc.h"
#include "usb_pwr.h"
#include "hw_config.h"


/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
uint32_t MUTE_DATA = 0;

DEVICE Device_Table =
  {
    EP_NUM,
    1
  };

DEVICE_PROP Device_Property =
  {
    Microphone_init,
    Microphone_Reset,
    Microphone_Status_In,
    Microphone_Status_Out,
    Microphone_Data_Setup,
    Microphone_NoData_Setup,
    Microphone_Get_Interface_Setting,
    Microphone_GetDeviceDescriptor,
    Microphone_GetConfigDescriptor,
    Microphone_GetStringDescriptor,
    0,
    0x40 /*MAX PACKET SIZE*/
  };

USER_STANDARD_REQUESTS User_Standard_Requests =
  {
    Microphone_GetConfiguration,
    Microphone_SetConfiguration,
    Microphone_GetInterface,
    Microphone_SetInterface,
    Microphone_GetStatus,
    Microphone_ClearFeature,
    Microphone_SetEndPointFeature,
    Microphone_SetDeviceFeature,
    Microphone_SetDeviceAddress
  };

ONE_DESCRIPTOR Device_Descriptor =
  {
    (uint8_t*)Microphone_DeviceDescriptor,
    MICROPHONE_SIZ_DEVICE_DESC
  };

ONE_DESCRIPTOR Config_Descriptor =
  {
    (uint8_t*)Microphone_ConfigDescriptor,
    MICROPHONE_SIZ_CONFIG_DESC
  };

ONE_DESCRIPTOR String_Descriptor[4] =
  {
    {(uint8_t*)Microphone_StringLangID, MICROPHONE_SIZ_STRING_LANGID},
    {(uint8_t*)Microphone_StringVendor, MICROPHONE_SIZ_STRING_VENDOR},
    {(uint8_t*)Microphone_StringProduct, MICROPHONE_SIZ_STRING_PRODUCT},
    {(uint8_t*)Microphone_StringSerial, MICROPHONE_SIZ_STRING_SERIAL},
  };

/* Extern variables ----------------------------------------------------------*/
//extern uint16_t In_Data_Offset;
//extern uint16_t Out_Data_Offset;

/* Private function prototypes -----------------------------------------------*/
/* Extern function prototypes ------------------------------------------------*/
/* Private functions ---------------------------------------------------------*/

/*******************************************************************************
* Function Name  : Microphone_init.
* Description    : Microphone init routine.
* Input          : None.
* Output         : None.
* Return         : None.
*******************************************************************************/
void Microphone_init()
{
  /* Update the serial number string descriptor with the data from the unique
  ID*/
  //Get_SerialNum();

  /* Initialize the current configuration */
  pInformation->Current_Configuration = 0;

  /* Connect the device */
  PowerOn();

  /* Perform basic device initialization operations */
  USB_SIL_Init();

  bDeviceState = UNCONNECTED;
}

/*******************************************************************************
* Function Name  : Microphone_Reset.
* Description    : Microphone reset routine.
* Input          : None.
* Output         : None.
* Return         : None.
*******************************************************************************/
void Microphone_Reset()
{
  /* Set Microphone device as not configured state */
  pInformation->Current_Configuration = 0;

  /* Current Feature initialization */
  pInformation->Current_Feature = Microphone_ConfigDescriptor[7];

  SetBTABLE(BTABLE_ADDRESS);

  /* Initialize Endpoint 0 */
  SetEPType(ENDP0, EP_CONTROL);
  SetEPTxStatus(ENDP0, EP_TX_NAK);
  SetEPRxAddr(ENDP0, ENDP0_RXADDR);
  SetEPRxCount(ENDP0, Device_Property.MaxPacketSize);
  SetEPTxAddr(ENDP0, ENDP0_TXADDR);
  Clear_Status_Out(ENDP0);
  SetEPRxValid(ENDP0);

  /* Initialize Endpoint 1 */
  SetEPType(ENDP1, EP_ISOCHRONOUS);
  SetEPDblBuffAddr(ENDP1, ENDP1_BUF0Addr, ENDP1_BUF1Addr);
  SetEPDblBuffCount(ENDP1, EP_DBUF_IN, 0x40);
  //SetEPDblBuffCount(ENDP1, EP_DBUF_IN, 0x80);
  ClearDTOG_RX(ENDP1);
  ClearDTOG_TX(ENDP1);
  ToggleDTOG_TX(ENDP1);
  SetEPRxStatus(ENDP1, EP_RX_DIS);
  SetEPTxStatus(ENDP1, EP_TX_VALID);

  SetEPRxValid(ENDP0);
  /* Set this device to response on default address */
  SetDeviceAddress(0);

  bDeviceState = ATTACHED;

  //In_Data_Offset = 0;
  //Out_Data_Offset = 0;
}
/*******************************************************************************
* Function Name  : Microphone_SetConfiguration.
* Description    : Update the device state to configured.
* Input          : None.
* Output         : None.
* Return         : None.
*******************************************************************************/
void Microphone_SetConfiguration(void)
{
  DEVICE_INFO *pInfo = &Device_Info;

  if (pInfo->Current_Configuration != 0)
  {
    /* Device configured */
    bDeviceState = CONFIGURED;
  }
}
/*******************************************************************************
* Function Name  : Microphone_SetConfiguration.
* Description    : Update the device state to addressed.
* Input          : None.
* Output         : None.
* Return         : None.
*******************************************************************************/
void Microphone_SetDeviceAddress (void)
{
  bDeviceState = ADDRESSED;
}
/*******************************************************************************
* Function Name  : Microphone_Status_In.
* Description    : Microhpne Status In routine.
* Input          : None.
* Output         : None.
* Return         : None.
*******************************************************************************/
void Microphone_Status_In(void)
{}

/*******************************************************************************
* Function Name  : Microphone_Status_Out.
* Description    : Microphone Status Out routine.
* Input          : None.
* Output         : None.
* Return         : None.
*******************************************************************************/
void Microphone_Status_Out (void)
{}

/*******************************************************************************
* Function Name  : Microphone_Data_Setup
* Description    : Handle the data class specific requests.
* Input          : None.
* Output         : None.
* Return         : USB_UNSUPPORT or USB_SUCCESS.
*******************************************************************************/
RESULT Microphone_Data_Setup(uint8_t RequestNo)
{
	uint8_t *(*CopyRoutine)(uint16_t);
  	CopyRoutine = NULL;

  	if ((RequestNo == GET_CUR) || (RequestNo == SET_CUR))
  	{
    	CopyRoutine = Mute_Command;
  	}

  	else
  	{
    	return USB_UNSUPPORT;
  	}

  	pInformation->Ctrl_Info.CopyData = CopyRoutine;
  	pInformation->Ctrl_Info.Usb_wOffset = 0;
  	(*CopyRoutine)(0);
  
  	return USB_SUCCESS;
}

/*******************************************************************************
* Function Name  : Microphone_NoData_Setup
* Description    : Handle the no data class specific requests.
* Input          : None.
* Output         : None.
* Return         : USB_UNSUPPORT or USB_SUCCESS.
*******************************************************************************/
RESULT Microphone_NoData_Setup(uint8_t RequestNo)
{
  return USB_UNSUPPORT;
}

/*******************************************************************************
* Function Name  : Microphone_GetDeviceDescriptor.
* Description    : Get the device descriptor.
* Input          : Length : uint16_t.
* Output         : None.
* Return         : The address of the device descriptor.
*******************************************************************************/
uint8_t *Microphone_GetDeviceDescriptor(uint16_t Length)
{
  return Standard_GetDescriptorData(Length, &Device_Descriptor);
}

/*******************************************************************************
* Function Name  : Microphone_GetConfigDescriptor.
* Description    : Get the configuration descriptor.
* Input          : Length : uint16_t.
* Output         : None.
* Return         : The address of the configuration descriptor.
*******************************************************************************/
uint8_t *Microphone_GetConfigDescriptor(uint16_t Length)
{
  return Standard_GetDescriptorData(Length, &Config_Descriptor);
}

/*******************************************************************************
* Function Name  : Microphone_GetStringDescriptor.
* Description    : Get the string descriptors according to the needed index.
* Input          : Length : uint16_t.
* Output         : None.
* Return         : The address of the string descriptors.
*******************************************************************************/
uint8_t *Microphone_GetStringDescriptor(uint16_t Length)
{
  uint8_t wValue0 = pInformation->USBwValue0;

  if (wValue0 > 4)
  {
    return NULL;
  }
  else
  {
    return Standard_GetDescriptorData(Length, &String_Descriptor[wValue0]);
  }
}

/*******************************************************************************
* Function Name  : Microphone_Get_Interface_Setting.
* Description    : test the interface and the alternate setting according to the
*                  supported one.
* Input1         : uint8_t: Interface : interface number.
* Input2         : uint8_t: AlternateSetting : Alternate Setting number.
* Output         : None.
* Return         : The address of the string descriptors.
*******************************************************************************/
RESULT Microphone_Get_Interface_Setting(uint8_t Interface, uint8_t AlternateSetting)
{
  if (AlternateSetting > 1)
  {
    return USB_UNSUPPORT;
  }
  else if (Interface > 1)
  {
    return USB_UNSUPPORT;
  }
  return USB_SUCCESS;
}

/*******************************************************************************
* Function Name  : Mute_Command
* Description    : Handle the GET MUTE and SET MUTE command.
* Input          : Length : uint16_t.
* Output         : None.
* Return         : The address of the string descriptors.
*******************************************************************************/

uint8_t *Mute_Command(uint16_t Length)
{

  if (Length == 0)
  {
    pInformation->Ctrl_Info.Usb_wLength = pInformation->USBwLengths.w;
    return NULL;
  }
  else
  {
    return((uint8_t*)(&MUTE_DATA));
  }
}

/******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/

