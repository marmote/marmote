//-----------------------------------------------------------------------------
// Title         : Teton (Main) board source
// Project       : Marmote Yellowstone (Power Supply) Board Firmware
//-----------------------------------------------------------------------------
// File          : teton.h
// Author        : Sandor Szilvasi
// Company       : Vanderbilt University, ISIS
// Created       : 2012-07-30
// Last update   : 2012-07-30 14:20
// Platform      : Marmote
// Target device : STM32F102CB
// Tool version  : ARM uVision 4 (v4.22.22.0)
// Standard      : CMSIS
//-----------------------------------------------------------------------------
// Description   : Source file for the Marmote Teton (Main) board with GPIO
//                 pin definitions and SPI interface.
//-----------------------------------------------------------------------------
// Copyright (c) 2006-2012, Vanderbilt University
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
// 2012-07-30      1.0      Sandor Szilvasi	Created
//-----------------------------------------------------------------------------

#include "teton.h"

void Teton_Init(void)
{
    CON_GPIO_Init();
	CON_SPI_Init();
}

void CON_GPIO_Init(void)
{
	GPIO_InitTypeDef GPIO_InitStructure; 

	// Enable peripheral clocks
//	RCC->APB2ENR |= ( CON_SGPIO2_GPIO_CLK |
//                      CON_SGPIO3_GPIO_CLK |
//                      CON_SGPIO4_GPIO_CLK |
//                      CON_SGPIO5_GPIO_CLK |
//                      CON_ALERT_GPIO_CLK |
//                      CON_I2C_SCL_GPIO_CLK |
//                      CON_I2C_SDA_GPIO_CLK);
    RCC_APB2PeriphClockCmd( CON_SGPIO2_GPIO_CLK |
                            CON_SGPIO3_GPIO_CLK |
                            CON_SGPIO4_GPIO_CLK |
                            CON_SGPIO5_GPIO_CLK |
                            CON_ALERT_GPIO_CLK |
                            CON_I2C_SCL_GPIO_CLK |
                            CON_I2C_SDA_GPIO_CLK,
                            ENABLE);

	GPIO_InitStructure.GPIO_Pin = CON_SGPIO2_PIN; 
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING; 
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz; 
	GPIO_Init(CON_SGPIO2_GPIO_PORT, &GPIO_InitStructure); 

	GPIO_InitStructure.GPIO_Pin = CON_SGPIO3_PIN; 	
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING; 
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz; 
	GPIO_Init(CON_SGPIO3_GPIO_PORT, &GPIO_InitStructure); 

	GPIO_InitStructure.GPIO_Pin = CON_SGPIO4_PIN; 
	//GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING; 
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP; 
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz; 
	GPIO_Init(CON_SGPIO4_GPIO_PORT, &GPIO_InitStructure); 

	GPIO_InitStructure.GPIO_Pin = CON_SGPIO5_PIN; 
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING; 
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz; 
	GPIO_Init(CON_SGPIO5_GPIO_PORT, &GPIO_InitStructure); 

	GPIO_InitStructure.GPIO_Pin = CON_ALERT_PIN; 
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING; 
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz; 
	GPIO_Init(CON_ALERT_GPIO_PORT, &GPIO_InitStructure); 

	GPIO_InitStructure.GPIO_Pin = CON_I2C_SCL_PIN; 
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING; 
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz; 
	GPIO_Init(CON_I2C_SCL_GPIO_PORT, &GPIO_InitStructure); 

	GPIO_InitStructure.GPIO_Pin = CON_I2C_SDA_PIN; 
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING; 
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz; 
	GPIO_Init(CON_I2C_SDA_GPIO_PORT, &GPIO_InitStructure);
}


void CON_SPI_Init(void)
{
	NVIC_InitTypeDef NVIC_InitStructure;
	SPI_InitTypeDef  SPI_InitStructure;
	GPIO_InitTypeDef GPIO_InitStructure;

	RCC_APB2PeriphClockCmd( CON_SPI_NSS_GPIO_CLK  |
                            CON_SPI_SCK_GPIO_CLK  |
                            CON_SPI_MISO_GPIO_CLK |
                            CON_SPI_MOSI_GPIO_CLK,
                            ENABLE);

    // Enable peripheral clock
	RCC_APB2PeriphClockCmd(CON_SPI_CLK, ENABLE);
    
    // Initialize NSS, SCK, MISO and MOSI pins

    // NSS
	CON_SPI_NSS_GPIO_PORT->BSRR = CON_SPI_NSS_PIN;
    //GPIO_SetBits(CON_SPI_NSS_GPIO_PORT, CON_SPI_NSS_PIN);

	GPIO_InitStructure.GPIO_Pin = CON_SPI_NSS_PIN;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IPU;
    GPIO_Init(CON_SPI_NSS_GPIO_PORT, &GPIO_InitStructure); 

    // SCK
    GPIO_InitStructure.GPIO_Pin = CON_SPI_SCK_PIN;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IPU;
    GPIO_Init(CON_SPI_SCK_GPIO_PORT, &GPIO_InitStructure);

    // MISO
    GPIO_InitStructure.GPIO_Pin = CON_SPI_MISO_PIN;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_PP;
    GPIO_Init(CON_SPI_MISO_GPIO_PORT, &GPIO_InitStructure);

    // MOSI
    GPIO_InitStructure.GPIO_Pin = CON_SPI_MOSI_PIN;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IPU; // !
    GPIO_Init(CON_SPI_MOSI_GPIO_PORT, &GPIO_InitStructure);

    // Initialize SPI (slave)
    // TODO: Calculate prescaler value based on SYSCLK > APB2CLK
    SPI_InitStructure.SPI_Direction = SPI_Direction_2Lines_FullDuplex;
    SPI_InitStructure.SPI_Mode = SPI_Mode_Slave;
    SPI_InitStructure.SPI_DataSize = SPI_DataSize_8b;
    SPI_InitStructure.SPI_CPOL = SPI_CPOL_Low;
    SPI_InitStructure.SPI_CPHA = SPI_CPHA_1Edge;
    //SPI_InitStructure.SPI_NSS = SPI_NSS_Soft;
    SPI_InitStructure.SPI_BaudRatePrescaler = SPI_BaudRatePrescaler_32;
    SPI_InitStructure.SPI_FirstBit = SPI_FirstBit_MSB;
    SPI_InitStructure.SPI_CRCPolynomial = 7;
    SPI_Init(CON_SPI, &SPI_InitStructure);

	// Enable interrupt
	NVIC_PriorityGroupConfig(NVIC_PriorityGroup_1); // ?

	NVIC_InitStructure.NVIC_IRQChannel = CON_SPI_IRQn;
	NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 0;
	NVIC_InitStructure.NVIC_IRQChannelSubPriority = 1;
	NVIC_Init(&NVIC_InitStructure);		   

  	SPI_I2S_ITConfig(CON_SPI, SPI_I2S_IT_TXE, DISABLE);
	SPI_I2S_ITConfig(CON_SPI, SPI_I2S_IT_RXNE, ENABLE);

    // Enable SPI
    SPI_Cmd(CON_SPI, ENABLE);
}

/*
const uint8_t spi_rx_buffer_size = 64;
uint8_t ridx;
uint8_t widx;
uint8_t CON_SPI_rx_buffer[spi_rx_buffer_size];
*/


const uint8_t spi_tx_buffer_size = 64;
static uint8_t CON_SPI_tx_buffer[spi_tx_buffer_size];
static uint8_t CON_SPI_tx_buffer_len;
static uint8_t CON_SPI_tx_buffer_idx;

void SPI1_IRQHandler(void)	// TODO: rename to CON_SPI_IRQHandler
{
	
	uint8_t data;

	if ( SPI_I2S_GetITStatus(CON_SPI, SPI_I2S_IT_TXE) == SET )
	{
		if ( CON_SPI_tx_buffer_idx < CON_SPI_tx_buffer_len )
		{
			// Transmit further bytes
			SPI_I2S_SendData(CON_SPI, CON_SPI_tx_buffer[CON_SPI_tx_buffer_idx++]);
			SPI_I2S_ITConfig(CON_SPI, SPI_I2S_IT_TXE , ENABLE);
		}
		else
		{
			// Deassert IT request GPIO line
			CON_SGPIO4_GPIO_PORT->BRR = CON_SGPIO4_PIN;
			SPI_I2S_ITConfig(CON_SPI, SPI_I2S_IT_TXE , DISABLE);
		}

		SPI_I2S_ClearITPendingBit(CON_SPI, SPI_I2S_IT_TXE);		
	}
	
	if ( SPI_I2S_GetITStatus(CON_SPI, SPI_I2S_IT_RXNE) == SET )
	{
		// Forwared received data to USB console
		data = SPI_I2S_ReceiveData(CON_SPI);
		USB_SendMsg((const char*)&data, 1);
	}
	
}

void CON_SPI_Write(const uint8_t* data, uint8_t len)
{
	// TODO: Currently overwrites the buffer content -> implement a circular buffer (?)
	memcpy(CON_SPI_tx_buffer, data, len);
	CON_SPI_tx_buffer_len = len;
	CON_SPI_tx_buffer_idx = 0;

	SPI_I2S_SendData(CON_SPI, CON_SPI_tx_buffer[CON_SPI_tx_buffer_idx++]);
	SPI_I2S_ITConfig(CON_SPI, SPI_I2S_IT_TXE, ENABLE);
	CON_SGPIO4_GPIO_PORT->BSRR = CON_SGPIO4_PIN;
	//CON_SGPIO4_GPIO_PORT->BRR = CON_SGPIO4_PIN;
}


void CON_SPI_WriteRegister(uint8_t addr, uint8_t data)
{
	/*
	uint8_t header;							   
	header = addr & 0x3F; // write, no burst

    // Assert NSS (CSn)
	CON_SPI_NSS_GPIO_PORT->BRR = CON_SPI_NSS_PIN;
 
    // TODO: Wait for MISO (SO) to go low
	    
    // Send header byte (R/#W, B, A[5:0])
    SPI_I2S_SendData(SPI1, header);
	while (CON_SPI->SR & SPI_SR_BSY);
    
    // Send data byte (D[7:0])
    SPI_I2S_SendData(SPI1, data);
	while (CON_SPI->SR & SPI_SR_BSY);

    // Deassert NSS (CSn)
	CON_SPI_NSS_GPIO_PORT->BSRR = CON_SPI_NSS_PIN;
	*/
}

uint8_t CON_SPI_ReadRegister(uint8_t addr)
{
	/*
	uint8_t header;
    uint8_t data;

	header = ((addr & 0x3F) | 0x80); // read, no burst

    // Assert NSS (CSn)
	CON_SPI_NSS_GPIO_PORT->BRR = CON_SPI_NSS_PIN;

    // TODO: Wait for MISO (SO) to go low
	    
    // Send header byte (R/#W, B, A[5:0])
    SPI_I2S_SendData(SPI1, header);
	while (CON_SPI->SR & SPI_SR_BSY);

	data = SPI_I2S_ReceiveData(SPI1); // dummy
    
    // Read data byte (D[7:0])
    SPI_I2S_SendData(SPI1, 0x00);
	while (CON_SPI->SR & SPI_SR_BSY);

    data = SPI_I2S_ReceiveData(SPI1);

    // Deassert NSS (CSn)
	CON_SPI_NSS_GPIO_PORT->BSRR = CON_SPI_NSS_PIN;
    
    return data;
	*/
	return 0;
}

