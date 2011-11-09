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

	// Reset the battery gauge I2C interface
	//I2C_GenerateSTART(BAT_I2C, ENABLE);
	//I2C_GenerateSTOP(BAT_I2C, ENABLE);

    /*
    // START - TEMPORARY DEBUG CODE TO DRIVE I2C SIGNALS AS GPIOS
	GPIO_InitStructure.GPIO_Pin = BAT_I2C_SCL_PIN | BAT_I2C_SDA_PIN; 
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_OD; 
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz; 
	GPIO_Init(BAT_I2C_SDA_GPIO_PORT, &GPIO_InitStructure); 
    // END - TEMPORARY DEBUG CODE TO DRIVE I2C SIGNALS AS GPIOS
    */

}

void BAT_WriteRegister(BAT_RegisterAddress_Type address, uint16_t data)
{
    switch (address)
    {
        // 8-bit writable registers
        case CONTROL :
        case VOLTAGE_THRESHOLD_HIGH :
        case VOLTAGE_THRESHOLD_LOW :
        case TEMPERATURE_THRESHOLD_HIGH :
        case TEMPERATURE_THRESHOLD_LOW :

            // ------------- Write register address ----------------

            // Send START condition
            I2C_GenerateSTART(BAT_I2C, ENABLE);

            // EV5
             while(!I2C_CheckEvent(BAT_I2C, I2C_EVENT_MASTER_MODE_SELECT));  

            /* Send slave address for write */
            I2C_Send7bitAddress(BAT_I2C, BAT_I2C_ADDRESS, I2C_Direction_Transmitter);

            // EV6
            while(!I2C_CheckEvent(BAT_I2C, I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED));

            // ------------- Write register address ----------------

            // Send battery gauge register address
            I2C_SendData(BAT_I2C, address);

            // EV8
            while(!I2C_CheckEvent(BAT_I2C, I2C_EVENT_MASTER_BYTE_TRANSMITTED));

            // Send battery gauge register value
            I2C_SendData(BAT_I2C, data);

            // EV8
            while(!I2C_CheckEvent(BAT_I2C, I2C_EVENT_MASTER_BYTE_TRANSMITTED));
            
            // Set STOP Condition
            I2C_GenerateSTOP(BAT_I2C, ENABLE);

            break;


        // 16-bit writable registers
        case ACCUMULATED_CHARGE_MSB :
        case CHARGE_THRESHOLD_HIGH_MSB :
        case CHARGE_THRESHOLD_LOW_MSB :

            // ------------- Write register address ----------------

            // Send START condition
            I2C_GenerateSTART(BAT_I2C, ENABLE);

            // EV5
             while(!I2C_CheckEvent(BAT_I2C, I2C_EVENT_MASTER_MODE_SELECT));  

            /* Send slave address for write */
            I2C_Send7bitAddress(BAT_I2C, BAT_I2C_ADDRESS, I2C_Direction_Transmitter);

            // EV6
            while(!I2C_CheckEvent(BAT_I2C, I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED));

            // ------------- Write register address ----------------

            // Send battery gauge register address
            I2C_SendData(BAT_I2C, address);

            // EV8
            while(!I2C_CheckEvent(BAT_I2C, I2C_EVENT_MASTER_BYTE_TRANSMITTED));

            // Send battery gauge register MSB value
            I2C_SendData(BAT_I2C, (uint8_t)(data >> 8));

            // EV8
            while(!I2C_CheckEvent(BAT_I2C, I2C_EVENT_MASTER_BYTE_TRANSMITTED));
            
            // Send battery gauge register LSB value
            I2C_SendData(BAT_I2C, (uint8_t)data); // & 0xFF

            // EV8
            while(!I2C_CheckEvent(BAT_I2C, I2C_EVENT_MASTER_BYTE_TRANSMITTED));
            
            // Set STOP Condition
            I2C_GenerateSTOP(BAT_I2C, ENABLE);

            break;


        default :

            break;
    }
}

uint16_t BAT_ReadRegister(BAT_RegisterAddress_Type address)
{
    uint8_t data;
							
	// ------------- Write register address ----------------

    // Send START condition
    I2C_GenerateSTART(BAT_I2C, ENABLE);

    // EV5
     while(!I2C_CheckEvent(BAT_I2C, I2C_EVENT_MASTER_MODE_SELECT));  

    // Send slave address for write
    I2C_Send7bitAddress(BAT_I2C, BAT_I2C_ADDRESS, I2C_Direction_Transmitter);

    // EV6
    while(!I2C_CheckEvent(BAT_I2C, I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED));

    // Send battery gauge register address
    I2C_SendData(BAT_I2C, address);

	// EV8
	while(!I2C_CheckEvent(BAT_I2C, I2C_EVENT_MASTER_BYTE_TRANSMITTED));
	

	// --------------- Read register value ----------------

    // Send repeated START condition
    I2C_GenerateSTART(BAT_I2C, ENABLE);

    // EV5
    while(!I2C_CheckEvent(BAT_I2C, I2C_EVENT_MASTER_MODE_SELECT));  

    // Send battery gauge I2C address for read
    I2C_Send7bitAddress(BAT_I2C, BAT_I2C_ADDRESS, I2C_Direction_Receiver);

    // EV6
    while(!I2C_CheckEvent(BAT_I2C, I2C_EVENT_MASTER_RECEIVER_MODE_SELECTED));
    
	// Disable I2C acknowledgement
  	I2C_AcknowledgeConfig(BAT_I2C, DISABLE);

    // Set STOP Condition
    I2C_GenerateSTOP(BAT_I2C, ENABLE);
									
    // EV7
    while(!I2C_CheckEvent(BAT_I2C, I2C_EVENT_MASTER_BYTE_RECEIVED));  

    // Receive data
    data = I2C_ReceiveData(BAT_I2C);

    return data;
}



void SD_SPI_Init(void)
{
	SPI_InitTypeDef  SPI_InitStructure;
	GPIO_InitTypeDef  GPIO_InitStructure;

	RCC->APB2ENR |= RCC_APB2ENR_IOPBEN;
	RCC->APB1ENR |= SD_SPI_CLK;

	//RCC->APB1ENR |= RCC_APB1ENR_SPI2EN;
    
    // Default value
	//SD_SPI_NSS_GPIO_PORT->BSRR = SD_SPI_NSS_PIN;
    GPIO_SetBits(SD_SPI_NSS_GPIO_PORT, SD_SPI_NSS_PIN);

	GPIO_InitStructure.GPIO_Pin = SD_SPI_NSS_PIN;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;
    GPIO_Init(SD_SPI_NSS_GPIO_PORT, &GPIO_InitStructure); 

    // SCK
    GPIO_InitStructure.GPIO_Pin = SD_SPI_SCK_PIN;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_PP;
    GPIO_Init(SD_SPI_SCK_GPIO_PORT, &GPIO_InitStructure);

    // MISO
    GPIO_InitStructure.GPIO_Pin = SD_SPI_MISO_PIN;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IPU; // !
    GPIO_Init(SD_SPI_MISO_GPIO_PORT, &GPIO_InitStructure);

    // MOSI
    GPIO_InitStructure.GPIO_Pin = SD_SPI_MOSI_PIN;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_PP;
    GPIO_Init(SD_SPI_MOSI_GPIO_PORT, &GPIO_InitStructure);

    // Initialize SPI as master
    SPI_InitStructure.SPI_Direction = SPI_Direction_2Lines_FullDuplex;
    SPI_InitStructure.SPI_Mode = SPI_Mode_Master;
    SPI_InitStructure.SPI_DataSize = SPI_DataSize_8b;
    SPI_InitStructure.SPI_CPOL = SPI_CPOL_Low;
    SPI_InitStructure.SPI_CPHA = SPI_CPHA_1Edge;
    SPI_InitStructure.SPI_NSS = SPI_NSS_Soft;
    SPI_InitStructure.SPI_BaudRatePrescaler = SPI_BaudRatePrescaler_8;
    SPI_InitStructure.SPI_FirstBit = SPI_FirstBit_MSB;
    SPI_InitStructure.SPI_CRCPolynomial = 7;
    SPI_Init(SD_SPI, &SPI_InitStructure);

    // Enable NSS as output
    SPI_SSOutputCmd(SD_SPI, ENABLE); // TODO: Check if this is needed

    // Enable SPI
    SPI_Cmd(SD_SPI, ENABLE);
}

void SD_SPI_SendData(uint16_t data)
{
	//SD_SPI_NSS_GPIO_PORT->BRR = SD_SPI_NSS_PIN;
    GPIO_ResetBits(SD_SPI_NSS_GPIO_PORT, SD_SPI_NSS_PIN);
    SPI_I2S_SendData(SD_SPI, data);
	//SD_SPI_NSS_GPIO_PORT->BSRR = SD_SPI_NSS_PIN;
	while (SD_SPI->SR & SPI_SR_BSY); // wait for busy flag
    GPIO_SetBits(SD_SPI_NSS_GPIO_PORT, SD_SPI_NSS_PIN);
}


