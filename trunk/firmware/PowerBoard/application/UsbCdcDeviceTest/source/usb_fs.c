/******************** (C) COPYRIGHT 2011 STMicroelectronics ********************
* File Name          : hw_config.c
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

/* Includes ------------------------------------------------------------------*/

#include "usb_lib.h"
#include "usb_prop.h"
#include "usb_desc.h"
#include "usb_pwr.h"
#include "usb_fs.h"

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/

/* Extern variables ----------------------------------------------------------*/

extern LINE_CODING linecoding;

/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/

/*******************************************************************************
* Function Name  : Set_USBClock
* Description    : Configures USB Clock input (48MHz)
* Input          : None.
* Return         : None.
*******************************************************************************/
void USB_FsInit()
{	
	NVIC_InitTypeDef NVIC_InitStructure;
	NVIC_PriorityGroupConfig(NVIC_PriorityGroup_1);

	//Delay(200);
	USB_SoftReset();

  	// Select USBCLK source
  	RCC_USBCLKConfig(RCC_USBCLKSource_PLLCLK_1Div5);
	  	
  	// Enable the USB clock 
  	RCC_APB1PeriphClockCmd(RCC_APB1Periph_USB, ENABLE);	 

	// Configure USB interrupts
	NVIC_InitStructure.NVIC_IRQChannel = USB_LP_CAN1_RX0_IRQn;
  	NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 1;
  	NVIC_InitStructure.NVIC_IRQChannelSubPriority = 0;
  	NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;
  	NVIC_Init(&NVIC_InitStructure);

	// Call USB init from STM32 USB-FS library
	USB_Init();
}

/*******************************************************************************
* Function Name  : Enter_LowPowerMode
* Description    : Power-off system clocks and power while entering suspend mode
* Input          : None.
* Return         : None.
*******************************************************************************/
void Enter_LowPowerMode(void)
{
  /* Set the device state to suspend */
  bDeviceState = SUSPENDED;
}

/*******************************************************************************
* Function Name  : Leave_LowPowerMode
* Description    : Restores system clocks and power while exiting suspend mode
* Input          : None.
* Return         : None.
*******************************************************************************/
void Leave_LowPowerMode(void)
{
  DEVICE_INFO *pInfo = &Device_Info;

  /* Set the device state to the correct state */
  if (pInfo->Current_Configuration != 0)
  {
    /* Device configured */
    bDeviceState = CONFIGURED;
  }
  else
  {
    bDeviceState = ATTACHED;
  }
}



/*******************************************************************************
* Function Name  : Handle_USBAsynchXfer.
* Description    : Send character data to USB through CDC.
* Input          : None.
* Return         : none.
*******************************************************************************/
void Handle_USBAsynchXfer (void)
{
	uint8_t length;
	
	length = USB_GetTxLength();

	if (length > 0)
	{
		UserToPMABufferCopy(USB_GetTxBuffer(), ENDP1_TXADDR, length);
    	SetEPTxCount(ENDP1, length);
    	SetEPTxValid(ENDP1);
	}

 

    /*
  uint16_t USB_Tx_ptr;
  uint16_t USB_Tx_length;
  
  if(USB_Tx_State != 1)
  {
    if (USART_Rx_ptr_out == USART_RX_DATA_SIZE)
    {
      USART_Rx_ptr_out = 0;
    }
    
    if(USART_Rx_ptr_out == USART_Rx_ptr_in) 
    {
      USB_Tx_State = 0; 
      return;
    }
    
    if(USART_Rx_ptr_out > USART_Rx_ptr_in) // rollback
    { 
      USART_Rx_length = USART_RX_DATA_SIZE - USART_Rx_ptr_out;
    }
    else 
    {
      USART_Rx_length = USART_Rx_ptr_in - USART_Rx_ptr_out;
    }
    
    if (USART_Rx_length > VIRTUAL_COM_PORT_DATA_SIZE)
    {
      USB_Tx_ptr = USART_Rx_ptr_out;
      USB_Tx_length = VIRTUAL_COM_PORT_DATA_SIZE;
      
      USART_Rx_ptr_out += VIRTUAL_COM_PORT_DATA_SIZE;	
      USART_Rx_length -= VIRTUAL_COM_PORT_DATA_SIZE;	
    }
    else
    {
      USB_Tx_ptr = USART_Rx_ptr_out;
      USB_Tx_length = USART_Rx_length;
      
      USART_Rx_ptr_out += USART_Rx_length;
      USART_Rx_length = 0;
    }
    USB_Tx_State = 1; 
    
    UserToPMABufferCopy(&USART_Rx_Buffer[USB_Tx_ptr], ENDP1_TXADDR, USB_Tx_length);
    SetEPTxCount(ENDP1, USB_Tx_length);
    SetEPTxValid(ENDP1); 
  }  
*/
}


void USB_SoftReset()
{
	GPIO_InitTypeDef GPIO_InitStructure; 

	// Enable peripheral clocks
	RCC->APB2ENR |= RCC_APB2ENR_IOPAEN;

    // PA12 / USBDP
	GPIO_InitStructure.GPIO_Pin = USB_USBDP_PIN; 
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_OD; 
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz; 
	GPIO_Init(USB_USBDP_GPIO_PORT, &GPIO_InitStructure);

	// Pull down USBDP for 50 ms
	USB_USBDP_GPIO_PORT->BRR = USB_USBDP_PIN;
	Delay(50);

	// Release USBDP
	USB_USBDP_GPIO_PORT->BSRR = USB_USBDP_PIN;
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING; 
	GPIO_Init(USB_USBDP_GPIO_PORT, &GPIO_InitStructure);
}


uint8_t USB_SendMsg(char* msg, uint8_t length)
{
    uint8_t i;

    if (USB_Tx_Length + length > VIRTUAL_COM_PORT_DATA_SIZE)
    {
        return 1; // FAILURE
    }

    for (i = 0; i < length; i++)
    {
        *USB_Tx_Ptr = *(msg+i);
        USB_Tx_Ptr++;
    }

    USB_Tx_Length += length;
    return 0; // SUCCESS
}

uint8_t USB_SendString(char* msg)
{
	uint8_t length;
	
	length = strlen(msg);
	return USB_SendMsg(msg, length);
}


uint8_t USB_GetTxLength()
{
    return USB_Tx_Length;
}

// Assume that the entier buffer can be taken at once
uint8_t* USB_GetTxBuffer()
{
    //uint8_t* ret = USB_Tx_Ptr;

    USB_Tx_Ptr = USB_Tx_Buffer; // ((USB_Tx_Ptr - USB_Tx_Buffer + USB_Tx_Length) % USB_TX_BUFFER_LENGTH_MAX) + USB_Tx_Buffer;
    USB_Tx_Length = 0;

    return USB_Tx_Ptr;
}

/******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/
