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
int16_t Stream_Buf[48];
//uint16_t Stream_Buff[] = { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0} ;
//static uint16_t ctr;
/*
uint16_t In_Data_Offset;
*/

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

	uint8_t i;

    if (GetENDPOINT(ENDP1) & EP_DTOG_TX)
    {
	    for (i = 0 ; i < 48 ; i++)
	    {
	        Stream_Buf[i] = i;
	    }
        // Write to ENDP1_BUF0Addr buffer
        UserToPMABufferCopy((uint8_t*)Stream_Buf, ENDP1_BUF0Addr, 96);
    }
    else
    {
	    for (i = 0 ; i < 48 ; i++)
	    {
	        Stream_Buf[i] = 10;
	    }

        // Write to ENDP1_BUF1Addr buffer
        UserToPMABufferCopy((uint8_t*)Stream_Buf, ENDP1_BUF1Addr, 96);
    }
    
    FreeUserBuffer(ENDP1, EP_DBUF_IN);
}

/******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/

