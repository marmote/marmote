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

	GPIO_InitStructure.GPIO_Pin = CON_SGPIO2; 
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING; 
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz; 
	GPIO_Init(CON_SGPIO2_GPIO_PORT, &GPIO_InitStructure); 

	GPIO_InitStructure.GPIO_Pin = CON_SGPIO3; 
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING; 
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz; 
	GPIO_Init(CON_SGPIO3_GPIO_PORT, &GPIO_InitStructure); 

	GPIO_InitStructure.GPIO_Pin = CON_SGPIO4; 
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING; 
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz; 
	GPIO_Init(CON_SGPIO4_GPIO_PORT, &GPIO_InitStructure); 

	GPIO_InitStructure.GPIO_Pin = CON_SGPIO5; 
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING; 
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz; 
	GPIO_Init(CON_SGPIO5_GPIO_PORT, &GPIO_InitStructure); 

	GPIO_InitStructure.GPIO_Pin = CON_ALERT; 
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING; 
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz; 
	GPIO_Init(CON_ALERT_GPIO_PORT, &GPIO_InitStructure); 

	GPIO_InitStructure.GPIO_Pin = CON_I2C_SCL; 
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING; 
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz; 
	GPIO_Init(CON_I2C_SCL_GPIO_PORT, &GPIO_InitStructure); 

	GPIO_InitStructure.GPIO_Pin = CON_I2C_SDA; 
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING; 
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz; 
	GPIO_Init(CON_I2C_SDA_GPIO_PORT, &GPIO_InitStructure); 
}


void CON_SPI_Init(void)
{
	SPI_InitTypeDef  SPI_InitStructure;
	GPIO_InitTypeDef  GPIO_InitStructure;

	//RCC->APB2ENR |= RCC_APB2ENR_IOPAEN;
    RCC_APB2PeriphClockCmd( CON_SPI_NSS_GPIO_CLK  |
                            CON_SPI_SCK_GPIO_CLK  |
                            CON_SPI_MISO_GPIO_CLK |
                            CON_SPI_MOSI_GPIO_CLK,
                            ENABLE);

    // Enable peripheral clock
	//RCC->APB2ENR |= RCC_APB2ENR_SPI1EN;
    RCC_APB2PeriphClockCmd(CON_SPI_CLK, ENABLE);
    
    // Initialize NSS, SCK, MISO and MOSI pins

    // NSS
	CON_SPI_NSS_GPIO_PORT->BSRR = CON_SPI_NSS_PIN;
    //GPIO_SetBits(CON_SPI_NSS_GPIO_PORT, CON_SPI_NSS_PIN);

	GPIO_InitStructure.GPIO_Pin = CON_SPI_NSS_PIN;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;
    GPIO_Init(CON_SPI_NSS_GPIO_PORT, &GPIO_InitStructure); 

    // SCK
    GPIO_InitStructure.GPIO_Pin = CON_SPI_SCK_PIN;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_PP;
    GPIO_Init(CON_SPI_SCK_GPIO_PORT, &GPIO_InitStructure);

    // MISO
    GPIO_InitStructure.GPIO_Pin = CON_SPI_MISO_PIN;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IPU; // !
    GPIO_Init(CON_SPI_MISO_GPIO_PORT, &GPIO_InitStructure);

    // MOSI
    GPIO_InitStructure.GPIO_Pin = CON_SPI_MOSI_PIN;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_PP;
    GPIO_Init(CON_SPI_MOSI_GPIO_PORT, &GPIO_InitStructure);

    // Initialize SPI
    // NOTE: SPI1 is initialized as master for hardware testing only, it is
    // supposed to act as slave later on
    // FIXME: Target clock rate?
    // TODO: Calculate prescaler value based on SYSCLK > APB2CLK
    SPI_InitStructure.SPI_Direction = SPI_Direction_2Lines_FullDuplex;
    SPI_InitStructure.SPI_Mode = SPI_Mode_Master;
    SPI_InitStructure.SPI_DataSize = SPI_DataSize_8b;
    SPI_InitStructure.SPI_CPOL = SPI_CPOL_Low;
    SPI_InitStructure.SPI_CPHA = SPI_CPHA_1Edge;
    SPI_InitStructure.SPI_NSS = SPI_NSS_Soft;
    SPI_InitStructure.SPI_BaudRatePrescaler = SPI_BaudRatePrescaler_32;
    SPI_InitStructure.SPI_FirstBit = SPI_FirstBit_MSB;
    SPI_InitStructure.SPI_CRCPolynomial = 7;
    SPI_Init(SPI1, &SPI_InitStructure);

    // Enable NSS as output
    SPI_SSOutputCmd(CON_SPI, ENABLE);

    // Enable SPI
    SPI_Cmd(CON_SPI, ENABLE);
}

void CON_SPI_WriteRegister(uint8_t addr, uint8_t data)
{
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
}

uint8_t CON_SPI_ReadRegister(uint8_t addr)
{
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
}

