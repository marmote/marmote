//-----------------------------------------------------------------------------
// Title         : <+title+>
// Project       : Power Board
//-----------------------------------------------------------------------------
// File          : power_board.c
// Author        : Sandor Szilvasi
// Company       : Vanderbilt University, ISIS
// Created       : 2011-11-03 14:45
// Last update   : 2011-11-17 17:45
// Platform      : Marmote
// Target device : STM32F102CB
// Tool version  : ARM uVision 4 (v4.22.22.0)
// Standard      : CMSIS
//-----------------------------------------------------------------------------
// Description   : <+description+>
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
// 2011-11-03      1.0      Sandor Szilvasi	Created
//-----------------------------------------------------------------------------

#include "power_board.h"

volatile uint32_t msTicks;                       /* timeTicks counter */
uint32_t ctr;
int16_t sampleValue;

void SysTick_Handler(void) {
	msTicks++;                                     /* increment timeTicks counter */
	if (msTicks % 500 == 0)
	{
		LED_Toggle(LED1);
		ctr++;		
	}
	if (msTicks % 50 == 0)
	{				  	
		sampleValue++;
	}
}

void Delay (uint32_t dlyTicks) {
	uint32_t curTicks = msTicks;

	while ((msTicks - curTicks) < dlyTicks);
}


void CON_GPIO_Init(void)
{
	GPIO_InitTypeDef GPIO_InitStructure; 

	// Enable peripheral clocks
	RCC->APB2ENR |= RCC_APB2ENR_IOPAEN;
	RCC->APB2ENR |= RCC_APB2ENR_IOPBEN;
	RCC->APB2ENR |= RCC_APB2ENR_IOPCEN;

    // PC14
	GPIO_InitStructure.GPIO_Pin = CON_GPIO0_PIN; 
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP; 
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz; 
	GPIO_Init(CON_GPIO0_GPIO_PORT, &GPIO_InitStructure); 

    // PC15
	GPIO_InitStructure.GPIO_Pin = CON_GPIO1_PIN; 
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP; 
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz; 
	GPIO_Init(CON_GPIO1_GPIO_PORT, &GPIO_InitStructure); 

    // PA9
	GPIO_InitStructure.GPIO_Pin = CON_GPIO2_PIN; 
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP; 
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz; 
	GPIO_Init(CON_GPIO2_GPIO_PORT, &GPIO_InitStructure); 
    
    // PA10
	GPIO_InitStructure.GPIO_Pin = CON_GPIO3_PIN; 
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP; 
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz; 
	GPIO_Init(CON_GPIO3_GPIO_PORT, &GPIO_InitStructure); 
    
    // PB4
	GPIO_InitStructure.GPIO_Pin = CON_GPIO4_PIN; 
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP; 
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz; 
	GPIO_Init(CON_GPIO4_GPIO_PORT, &GPIO_InitStructure); 
}


void CON_GPIO_Set(uint32_t gpio)
{
	if (gpio & CON_GPIO0)
	{
		CON_GPIO0_GPIO_PORT->BSRR = CON_GPIO0_PIN;
	}

	if (gpio & CON_GPIO1)
	{
		CON_GPIO1_GPIO_PORT->BSRR = CON_GPIO1_PIN;
	}

	if (gpio & CON_GPIO2)
	{
		CON_GPIO2_GPIO_PORT->BSRR = CON_GPIO2_PIN;
	}

	if (gpio & CON_GPIO3)
	{
		CON_GPIO3_GPIO_PORT->BSRR = CON_GPIO3_PIN;
	}

	if (gpio & CON_GPIO4)
	{
		CON_GPIO4_GPIO_PORT->BSRR = CON_GPIO4_PIN;
	}
}

void CON_GPIO_Clear(uint32_t gpio)
{
	// PC14, PC15, PA9, PA10, PB4 as
	// GPIO0, GPIO1, GPIO2, GPIO3, GPIO4

	if (gpio & CON_GPIO0)
	{
		CON_GPIO0_GPIO_PORT->BRR = CON_GPIO0_PIN;
	}

	if (gpio & CON_GPIO1)
	{
		CON_GPIO1_GPIO_PORT->BRR = CON_GPIO1_PIN;
	}

	if (gpio & CON_GPIO2)
	{
		CON_GPIO2_GPIO_PORT->BRR = CON_GPIO2_PIN;
	}

	if (gpio & CON_GPIO3)
	{
		CON_GPIO3_GPIO_PORT->BRR = CON_GPIO3_PIN;
	}

	if (gpio & CON_GPIO4)
	{
		CON_GPIO4_GPIO_PORT->BRR = CON_GPIO4_PIN;
	}
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
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;
    GPIO_Init(CON_SPI_NSS_GPIO_PORT, &GPIO_InitStructure); 

    // SCK
    GPIO_InitStructure.GPIO_Pin = CON_SPI_SCK_PIN;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_PP;
    GPIO_Init(CON_SPI_SCK_GPIO_PORT, &GPIO_InitStructure);

    // MISO
    GPIO_InitStructure.GPIO_Pin = CON_SPI_MISO_PIN;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IPU; // !
    GPIO_Init(CON_SPI_MISO_GPIO_PORT, &GPIO_InitStructure);

    // MOSI
    GPIO_InitStructure.GPIO_Pin = CON_SPI_MOSI_PIN;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_PP;
    GPIO_Init(CON_SPI_MOSI_GPIO_PORT, &GPIO_InitStructure);

    // Initialize SPI
    // NOTE: SPI1 is initialized as master for hardware testing only, it is
    // supposed to act as slave later on
    // TODO: Calculate prescaler value based on SYSCLK > APB2CLK
    SPI_InitStructure.SPI_Direction = SPI_Direction_2Lines_FullDuplex;
    SPI_InitStructure.SPI_Mode = SPI_Mode_Master;
    SPI_InitStructure.SPI_DataSize = SPI_DataSize_8b;
    SPI_InitStructure.SPI_CPOL = SPI_CPOL_Low;
    SPI_InitStructure.SPI_CPHA = SPI_CPHA_1Edge;
    SPI_InitStructure.SPI_NSS = SPI_NSS_Soft;
    SPI_InitStructure.SPI_BaudRatePrescaler = SPI_BaudRatePrescaler_8;
    SPI_InitStructure.SPI_FirstBit = SPI_FirstBit_MSB;
    SPI_InitStructure.SPI_CRCPolynomial = 7;
    SPI_Init(SPI1, &SPI_InitStructure);

    // Enable NSS as output
    SPI_SSOutputCmd(CON_SPI, ENABLE);

    // Enable SPI
    SPI_Cmd(CON_SPI, ENABLE);
}

void CON_SPI_SendData(uint16_t data)
{
	CON_SPI_NSS_GPIO_PORT->BRR = CON_SPI_NSS_PIN;
    //GPIO_ResetBits(CON_SPI_NSS_GPIO_PORT, CON_SPI_NSS_PIN);
    SPI_I2S_SendData(SPI1, data);
	while (CON_SPI->SR & SPI_SR_BSY); // wait for busy flag
	CON_SPI_NSS_GPIO_PORT->BSRR = CON_SPI_NSS_PIN;
    //GPIO_SetBits(CON_SPI_NSS_GPIO_PORT, CON_SPI_NSS_PIN);
}


// Connector I2C

void CON_I2C_Init(void)
{
    GPIO_InitTypeDef  GPIO_InitStructure;
    I2C_InitTypeDef   I2C_InitStructure;

	RCC->APB2ENR |= RCC_APB2ENR_IOPBEN;
    //RCC_APB2PeriphClockCmd( CON_I2C_SCL_GPIO_CLK  |
    //                       CON_I2C_SDA_GPIO_CLK,
    //                      ENABLE);
    
	RCC->APB1ENR |= RCC_APB1Periph_I2C1;
    //RCC_APB1PeriphClockCmd(CON_I2C_CLK, ENABLE);

	CON_I2C_SDA_GPIO_PORT->BRR = CON_I2C_SDA_PIN;
	CON_I2C_SCL_GPIO_PORT->BRR = CON_I2C_SCL_PIN;

	GPIO_InitStructure.GPIO_Pin = CON_I2C_SCL_PIN | CON_I2C_SDA_PIN;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_OD;
    GPIO_Init(CON_I2C_SDA_GPIO_PORT, &GPIO_InitStructure); 

    // Init
    I2C_DeInit(CON_I2C);

    I2C_InitStructure.I2C_Mode = I2C_Mode_I2C; 
    I2C_InitStructure.I2C_DutyCycle = I2C_DutyCycle_2;
    I2C_InitStructure.I2C_OwnAddress1 = 0x00;
    I2C_InitStructure.I2C_Ack = I2C_Ack_Enable;
    I2C_InitStructure.I2C_AcknowledgedAddress = I2C_AcknowledgedAddress_7bit;
    I2C_InitStructure.I2C_ClockSpeed = 100000;
    I2C_Init(CON_I2C, &I2C_InitStructure);

    // Enable I2C peripheral
    I2C_Cmd(CON_I2C, ENABLE);
}

void CON_I2C_SendData(uint8_t address, uint8_t data)
{
    /* Send START condition */
    I2C_GenerateSTART(CON_I2C, ENABLE);

    /* Test EV5 and clear it */
    while(!I2C_CheckEvent(CON_I2C, I2C_EVENT_MASTER_MODE_SELECT));  

    /* Send slave address for write */
    I2C_Send7bitAddress(CON_I2C, address << 1, I2C_Direction_Transmitter);

    /* Test EV6 and clear it */
    while(!I2C_CheckEvent(CON_I2C, I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED))
	{
		// Check for ACK ERROR
	    if (I2C_CheckEvent(CON_I2C, I2C_EVENT_SLAVE_ACK_FAILURE))
	    {	        
			I2C_GenerateSTOP(CON_I2C, ENABLE);

			return; // ERROR;
	    }
	}  

    // Send data
    I2C_SendData(CON_I2C, data);
    
    // Check EV8_2
    while(!I2C_CheckEvent(CON_I2C, I2C_EVENT_MASTER_BYTE_TRANSMITTED));  

    /* Send STOP Condition */
    I2C_GenerateSTOP(CON_I2C, ENABLE);
}

/*
void Get_SerialNum(void)
{
    // Not implemented
}
*/
