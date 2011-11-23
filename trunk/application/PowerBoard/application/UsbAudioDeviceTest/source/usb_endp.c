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
uint8_t Stream_Buff[48];
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
extern uint32_t EP_ctr;
void EP1_IN_Callback(void)
{																																			  
//    uint16_t i;

    uint16_t Data_Len;       /* data length*/
    Data_Len = 48;


			 EP_ctr++;
	//Stream_Buff[0] = 3;
    //ctr = 3;

//    for (i = 0 ; i < 5 ; i++)
//    {
//        Stream_Buff[i] = i;
//    }

    //ctr++;
    //ctr %= 500;

    LED_Toggle(LED2);

    if (GetENDPOINT(ENDP1) & EP_DTOG_TX)
    {
	    /*
		for (i = 0 ; i < sizeof(Stream_Buff) ; i++)
	    {
	        Stream_Buff[i] = i;
	    }
		*/
        // Write to ENDP1_BUF0Addr buffer
        UserToPMABufferCopy((uint8_t*)Stream_Buff, ENDP1_BUF0Addr, Data_Len);
    }
    else
    {
		/*
	    for (i = 0 ; i < sizeof(Stream_Buff) ; i++)
	    {
	        Stream_Buff[i] = 1;
	    }
		*/

        // Write to ENDP1_BUF1Addr buffer
        //Data_Len = GetEPDblBuf1Count(ENDP1);
        UserToPMABufferCopy((uint8_t*)Stream_Buff, ENDP1_BUF1Addr, Data_Len);
    }
    
    //FreeUserBuffer(ENDP1, EP_DBUF_OUT);
}

/******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/

