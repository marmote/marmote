/******************** (C) COPYRIGHT 2011 STMicroelectronics ********************
* File Name          : usb_endp.c
* Author             : MCD Application Team
* Version            : V3.3.0
* Date               : 21-March-2011
* Description        : Endpoint routines
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
#include "usb_mem.h"
#include "usb_fs.h"
#include "usb_istr.h"
#include "usb_pwr.h"

#include "power_board.h"

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/

/* Interval between sending IN packets in frame number (1 frame = 1ms) */
#define VCOMPORT_IN_FRAME_INTERVAL             5

/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
extern uint8_t USB_Tx_Buffer[VIRTUAL_COM_PORT_DATA_SIZE];
//static uint8_t* USB_Tx_Ptr;
//extern uint8_t USB_Tx_Length;

static uint8_t USB_Rx_Buffer[VIRTUAL_COM_PORT_DATA_SIZE];
//static uint8_t* USB_Rx_Ptr;
static uint8_t USB_Rx_Length;

extern uint8_t USB_Tx_Request;

extern uint8_t CMD_Rx_Buffer[32];
extern uint8_t CMD_Rx_Length;
extern uint8_t CMD_Rx_Valid;

/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/

/*******************************************************************************
* Function Name  : EP1_IN_Callback
* Description    :
* Input          : None.
* Output         : None.
* Return         : None.
*******************************************************************************/
void EP1_IN_Callback (void)
{	 
	/*
	if (USB_Tx_Request == 1)
	{	
		//USB_SIL_Write(EP1_IN, USB_Tx_Buffer, USB_Tx_Length); 

		UserToPMABufferCopy(USB_Tx_Buffer, ENDP1_TXADDR, USB_Tx_Length);
		SetEPTxCount(ENDP1, USB_Tx_Length);
		SetEPTxValid(ENDP1);

		USB_Tx_Request = 0;
	}
	*/
}

/*******************************************************************************
* Function Name  : EP3_OUT_Callback
* Description    :
* Input          : None.
* Output         : None.
* Return         : None.
*******************************************************************************/
void EP3_OUT_Callback(void)
{  
	uint16_t i;

  	/* Get the received data buffer and update the counter */
  	USB_Rx_Length = USB_SIL_Read(EP3_OUT, USB_Rx_Buffer);
				    
	// Echo characters
	UserToPMABufferCopy(USB_Rx_Buffer, ENDP1_TXADDR, USB_Rx_Length);
	SetEPTxCount(ENDP1, USB_Rx_Length);
	SetEPTxValid(ENDP1);
  
	// Send data to command processor here
	//CMD_ProcessRxBuffer(USB_Rx_Buffer, USB_Rx_Length);

	for (i = 0; i < USB_Rx_Length; i++)
	{
		switch (USB_Rx_Buffer[i])
		{	
			case 127 :		  // Backspace ('DEL') from Putty
			case '\b' :
				// Handle back space (TODO)
				if (CMD_Rx_Length > 0)
				{
					CMD_Rx_Length--;
				}
				break;

					  				
			case '\r' :
				// // Ignore carriage returns
				// break;
			case '\n' :
				// For now assume:
				// - '\n' is the last character in USB_Rx_Buffer (remainder is ignored)
				// - no new characters are received until the command is processed
												 
				CMD_Rx_Buffer[CMD_Rx_Length++] = '\0';

				// Signal to command processor (set flag)
				CMD_Rx_Valid = 1;

				break;
			default:
				// Copy character to 'command processor buffer'	
				CMD_Rx_Buffer[CMD_Rx_Length++] = USB_Rx_Buffer[i];
				break;
		}
	}

	// Enable the receive of data on EP3
	SetEPRxValid(ENDP3);
}

/*******************************************************************************
* Function Name  : SOF_Callback / INTR_SOFINTR_Callback
* Description    :
* Input          : None.
* Output         : None.
* Return         : None.
*******************************************************************************/
void SOF_Callback(void)
{
  static uint32_t FrameCount = 0;
  
  if(bDeviceState == CONFIGURED)
  {
    if (FrameCount++ == VCOMPORT_IN_FRAME_INTERVAL)
    {
      /* Reset the frame counter */
      FrameCount = 0;
      
      /* Check the data to be sent through IN pipe */
      Handle_USBAsynchXfer();
    }
  }  
}
/******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/

