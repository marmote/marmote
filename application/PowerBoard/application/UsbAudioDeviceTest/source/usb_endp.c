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
#include "usb_istr.h"

#include "power_board.h"

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
uint8_t Stream_Buff[24];
uint16_t In_Data_Offset;

/* Extern variables ----------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Extern function prototypes ------------------------------------------------*/
/* Private functions ---------------------------------------------------------*/
/*******************************************************************************
* Function Name  : EP1_OUT_Callback
* Description    : Endpoint 1 out callback routine.
* Input          : None.
* Output         : None.
* Return         : None.
*******************************************************************************/
void EP1_IN_Callback(void)
{
//  uint16_t Data_Len;       /* data length*/
  
  LED_On(LED2);

  while (1)
  {
  }
  // FIXME correct the lines below
//  if (GetENDPOINT(ENDP1) & EP_DTOG_TX)
//  {
//    /*read from ENDP1_BUF0Addr buffer*/
//    Data_Len = GetEPDblBuf0Count(ENDP1);
//    PMAToUserBufferCopy(Stream_Buff, ENDP1_BUF0Addr, Data_Len);
//  }
//  else
//  {
//    /*read from ENDP1_BUF1Addr buffer*/
//    Data_Len = GetEPDblBuf1Count(ENDP1);
//    PMAToUserBufferCopy(Stream_Buff, ENDP1_BUF1Addr, Data_Len);
//  }
//  FreeUserBuffer(ENDP1, EP_DBUF_OUT);
//  In_Data_Offset += Data_Len;
}

/******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/

