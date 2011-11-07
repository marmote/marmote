//-----------------------------------------------------------------------------
// Title         : Power Monitor Functions Source
// Project       : Power Board
//-----------------------------------------------------------------------------
// File          : ..sourcepower_monitor.c
// Author        : Sandor Szilvasi
// Company       : Vanderbilt University, ISIS
// Created       : 2011-11-04 19:42
// Last update   : 2011-11-04 19:42
// Platform      : Marmote
// Target device : STM32F102CB
// Tool version  : ARM uVision 4 (v4.22.22.0)
// Standard      : CMSIS
//-----------------------------------------------------------------------------
// Description   : Source file for monitoring the battery and the power rails.
// That is to communicate with the battery gauge IC and handling the ADCs.
//-----------------------------------------------------------------------------
// Copyright (c) 2006-2011, Vanderbilt University
// All rights reserved.
//
// Permission to use, copy, modify, and distribute this software and its
// documentation for any purpose, without fee, and without written agreement is
// hereby granted, provided that the above copyright notice, the following
// two paragraphs and the author appear in all copies of this software.
//
// IN NO EVENT SHALL THE VANDERBILT UNIVERSITY BE LIABLE TO ANY PARTY FOR
// DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING OUT
// OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF THE VANDERBILT
// UNIVERSITY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// THE VANDERBILT UNIVERSITY SPECIFICALLY DISCLAIMS ANY WARRANTIES,
// INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
// AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE PROVIDED HEREUNDER IS
// ON AN "AS IS" BASIS, AND THE VANDERBILT UNIVERSITY HAS NO OBLIGATION TO
// PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.
//-----------------------------------------------------------------------------
// Revisions     :
// Date            Version  Author			Description
// 2011-11-04      1.0      Sandor Szilvasi	Created
//-----------------------------------------------------------------------------

#include "power_monitor.h"

void BAT_I2C_Init(void)
{
    GPIO_InitTypeDef  GPIO_InitStructure;
    I2C_InitTypeDef   I2C_InitStructure;

    //RCC_APB2PeriphClockCmd(RCC_APB2Periph_AFIO | BAT_I2C_SCL_GPIO_CLK, ENABLE);
    //RCC_APB2PeriphClockCmd(RCC_APB2Periph_AFIO | RCC_APB2Periph_GPIOB, ENABLE);
	RCC->APB2ENR |= RCC_APB2ENR_IOPBEN;
    //RCC_AHBPeriphClockCmd( BAT_I2C_SCL_GPIO_CLK  |
    //                       BAT_I2C_SDA_GPIO_CLK,
    //                      ENABLE);
    
    //RCC_APB1PeriphClockCmd(BAT_I2C_CLK, ENABLE);
    //RCC_APB1PeriphClockCmd(RCC_APB1Periph_I2C2, ENABLE);
	//RCC->APB1ENR |= RCC_APB1Periph_I2C2;
	RCC->APB1ENR |= BAT_I2C_CLK;
    //RCC_APB1PeriphClockCmd(BAT_I2C_CLK | RCC_APB1Periph_SYSCFG, ENABLE);


	GPIO_InitStructure.GPIO_Pin = BAT_I2C_SCL_PIN | BAT_I2C_SDA_PIN;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_10MHz;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_OD;
    GPIO_Init(BAT_I2C_SDA_GPIO_PORT, &GPIO_InitStructure); 

    // Init
    I2C_DeInit(BAT_I2C);

    I2C_InitStructure.I2C_Mode = I2C_Mode_I2C; 
    I2C_InitStructure.I2C_DutyCycle = I2C_DutyCycle_2;
    I2C_InitStructure.I2C_OwnAddress1 = 0x00;
    I2C_InitStructure.I2C_Ack = I2C_Ack_Enable;
    I2C_InitStructure.I2C_AcknowledgedAddress = I2C_AcknowledgedAddress_7bit;
    I2C_InitStructure.I2C_ClockSpeed = 100000;
    I2C_Init(BAT_I2C, &I2C_InitStructure);

    // Enable I2C peripheral
    I2C_Cmd(BAT_I2C, ENABLE);

    /*
    // START - TEMPORARY DEBUG CODE TO DRIVE I2C SIGNALS AS GPIOS
	GPIO_InitStructure.GPIO_Pin = BAT_I2C_SCL_PIN | BAT_I2C_SDA_PIN; 
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_OD; 
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz; 
	GPIO_Init(BAT_I2C_SDA_GPIO_PORT, &GPIO_InitStructure); 
    // END - TEMPORARY DEBUG CODE TO DRIVE I2C SIGNALS AS GPIOS
    */

}

ErrorStatus BAT_I2C_SendData(uint8_t address, uint8_t data)
{
    // NOTE: not finished yet!
    
    /* Send START condition */
    I2C_GenerateSTART(BAT_I2C, ENABLE);

    /* Test EV5 and clear it */
    while(!I2C_CheckEvent(BAT_I2C, I2C_EVENT_MASTER_MODE_SELECT));  

    /* Send slave address for write */
    I2C_Send7bitAddress(BAT_I2C, address << 1, I2C_Direction_Transmitter);

    /* Test EV6 and clear it */
    while(!I2C_CheckEvent(BAT_I2C, I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED))
	{
		// Check for ACK ERROR
	    if (I2C_CheckEvent(BAT_I2C, I2C_EVENT_SLAVE_ACK_FAILURE))
	    {	        
			I2C_GenerateSTOP(BAT_I2C, ENABLE);

			return ERROR;
	    }
	}  

    // Send data
    I2C_SendData(BAT_I2C, data);
    
    // Check EV8_2
    while(!I2C_CheckEvent(BAT_I2C, I2C_EVENT_MASTER_BYTE_TRANSMITTED));  

    /* Send STOP Condition */
    I2C_GenerateSTOP(BAT_I2C, ENABLE);

    return SUCCESS;
}


uint8_t BAT_ReadRegister(uint8_t address)
{
    uint8_t data;

    /* Send START condition */
    I2C_GenerateSTART(BAT_I2C, ENABLE);

    /* Test EV5 and clear it */
    while(!I2C_CheckEvent(BAT_I2C, I2C_EVENT_MASTER_MODE_SELECT));  

    /* Send slave address for write */
    I2C_Send7bitAddress(BAT_I2C, BAT_I2C_ADDRESS, I2C_Direction_Transmitter);

    /* Test EV6 and clear it */
    //while(!I2C_CheckEvent(BAT_I2C, I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED))
    while(!I2C_CheckEvent(BAT_I2C, I2C_EVENT_MASTER_BYTE_TRANSMITTING)) // FIXME
	{
		// Check for ACK ERROR
	    if (I2C_CheckEvent(BAT_I2C, I2C_EVENT_SLAVE_ACK_FAILURE))
	    {	        
			I2C_GenerateSTOP(BAT_I2C, ENABLE);
            LED_On(LED2);
	    }
	}  

    // Send battery gauge register address
    I2C_SendData(BAT_I2C, data);
    
    // Check EV8_2
    while(!I2C_CheckEvent(BAT_I2C, I2C_EVENT_MASTER_BYTE_TRANSMITTED));  


    // Send repeated START condition
    I2C_GenerateSTART(BAT_I2C, ENABLE);

    /* Test EV5 and clear it */
    while(!I2C_CheckEvent(BAT_I2C, I2C_EVENT_MASTER_MODE_SELECT));  

    // Send battery gauge I2C address for read
    I2C_Send7bitAddress(BAT_I2C, BAT_I2C_ADDRESS, I2C_Direction_Receiver);

    /* Test EV6 and clear it */
    while(!I2C_CheckEvent(BAT_I2C, I2C_EVENT_MASTER_RECEIVER_MODE_SELECTED))
	{
		// Check for ACK ERROR
	    if (I2C_CheckEvent(BAT_I2C, I2C_EVENT_SLAVE_ACK_FAILURE))
	    {	        
			I2C_GenerateSTOP(BAT_I2C, ENABLE);

			return ERROR;
	    }
	}  

    // Receive data
    data = I2C_ReceiveData(BAT_I2C);
    
    // Check EV8_2
    while(!I2C_CheckEvent(BAT_I2C, I2C_EVENT_MASTER_BYTE_RECEIVED));  

    /* Send STOP Condition */
    I2C_GenerateSTOP(BAT_I2C, ENABLE);

    return data;
}


