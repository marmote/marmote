//-----------------------------------------------------------------------------
// Title         : <+title+>
// Project       : Power Board
//-----------------------------------------------------------------------------
// File          : power_board.c
// Author        : Sandor Szilvasi
// Company       : Vanderbilt University, ISIS
// Created       : 2011-11-03 14:45
// Last update   : 2011-11-03 14:45
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

void LED_Init(void)
{
	// Enable peripheral clock
	RCC->APB2ENR |= RCC_APB2ENR_AFIOEN;
	RCC->APB2ENR |= RCC_APB2ENR_IOPAEN;
	RCC->APB2ENR |= RCC_APB2ENR_IOPBEN;

    // PA15 GPIO remap for LED1
    AFIO->MAPR |= AFIO_MAPR_SWJ_CFG_JTAGDISABLE;

	// Configure LEDs to open-drain (CNF[1:0] = 01), 2 MHz mode (MODE[1:0] = 10)
    GPIOA->BSRR = POWER_BOARD_LED1_Msk;
    GPIOA->CRH &= 0x0FFFFFFFUL;
    GPIOA->CRH |= 0x60000000UL;

	GPIOB->BSRR = POWER_BOARD_LED2_Msk;
	GPIOB->CRL = (uint32_t)0x06 << 8;
}

void LED_On (uint32_t led)
{
    if (led & LED1)
    {
        GPIOA->BRR = POWER_BOARD_LED1_Msk;
    }

    if (led & LED2)
    {
        GPIOB->BRR = POWER_BOARD_LED2_Msk;
    }
}

void LED_Off (uint32_t led)
{
    if (led & LED1)
    {
        GPIOA->BSRR = POWER_BOARD_LED1_Msk;
    }

    if (led & LED2)
    {
        GPIOB->BSRR = POWER_BOARD_LED2_Msk;
    }
}

void LED_Toggle (uint32_t led)
{
    if (led & LED1)
    {
        if (GPIOA->IDR & POWER_BOARD_LED1_Msk)
        {
            GPIOA->BRR = POWER_BOARD_LED1_Msk;
        }
        else
        {
            GPIOA->BSRR = POWER_BOARD_LED1_Msk;
        }
    }

    if (led & LED2)
    {
        if (GPIOB->IDR & POWER_BOARD_LED2_Msk)
        {
            GPIOB->BRR = POWER_BOARD_LED2_Msk;
        }
        else
        {
            GPIOB->BSRR = POWER_BOARD_LED2_Msk;
        }
    }
}


void CON_GPIO_Init(void)
{
	GPIO_InitTypeDef GPIO_InitStructure; 

	// Enable peripheral clocks
	RCC->APB2ENR |= RCC_APB2ENR_IOPAEN;
	RCC->APB2ENR |= RCC_APB2ENR_IOPBEN;
	RCC->APB2ENR |= RCC_APB2ENR_IOPCEN;

    // PC14
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_14; 
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP; 
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz; 
	GPIO_Init(GPIOC, &GPIO_InitStructure); 

    // PC15
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_15; 
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP; 
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz; 
	GPIO_Init(GPIOC, &GPIO_InitStructure); 

    // PA9
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_9; 
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP; 
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz; 
	GPIO_Init(GPIOA, &GPIO_InitStructure); 
    
    // PA10
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_10; 
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP; 
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz; 
	GPIO_Init(GPIOA, &GPIO_InitStructure); 
    
    // PB4
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_4; 
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP; 
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz; 
	GPIO_Init(GPIOB, &GPIO_InitStructure); 
}


void CON_GPIO_Set(uint32_t gpio)
{
	if (gpio & CON_GPIO0)
	{
		GPIOC->BSRR = CON_GPIO0_Msk;
	}

	if (gpio & CON_GPIO1)
	{
		GPIOC->BSRR = CON_GPIO1_Msk;
	}

	if (gpio & CON_GPIO2)
	{
		GPIOA->BSRR = CON_GPIO2_Msk;
	}

	if (gpio & CON_GPIO3)
	{
		GPIOA->BSRR = CON_GPIO3_Msk;
	}

	if (gpio & CON_GPIO4)
	{
		GPIOB->BSRR = CON_GPIO4_Msk;
	}
}

void CON_GPIO_Clear(uint32_t gpio)
{
	// PC14, PC15, PA9, PA10, PB4 as
	// GPIO0, GPIO1, GPIO2, GPIO3, GPIO4

	if (gpio & CON_GPIO0)
	{
		GPIOC->BRR = CON_GPIO0_Msk;
	}

	if (gpio & CON_GPIO1)
	{
		GPIOC->BRR = CON_GPIO1_Msk;
	}

	if (gpio & CON_GPIO2)
	{
		GPIOA->BRR = CON_GPIO2_Msk;
	}

	if (gpio & CON_GPIO3)
	{
		GPIOA->BRR = CON_GPIO3_Msk;
	}

	if (gpio & CON_GPIO4)
	{
		GPIOB->BRR = CON_GPIO4_Msk;
	}
}


void CON_SPI_Init(void)
{
	SPI_InitTypeDef  SPI_InitStructure;
	GPIO_InitTypeDef  GPIO_InitStructure;

	RCC->APB2ENR |= RCC_APB2ENR_IOPAEN;
    //RCC_AHBPeriphClockCmd( CON_SPI_NSS_GPIO_CLK  |
    //                       CON_SPI_SCK_GPIO_CLK  |
    //                       CON_SPI_MISO_GPIO_CLK |
    //                       CON_SPI_MOSI_GPIO_CLK,
    //                      ENABLE);

    // TODO: check if the above two has the same effect
	RCC->APB2ENR |= RCC_APB2ENR_SPI1EN;
    //RCC_APB2PeriphClockCmd(CON_SPI_CLK | RCC_APB2Periph_SYSCFG, ENABLE);
    
    // Calculate prescaler value based on SYSCLK > APB2CLK
    // TODO

    // Initialize NSS, SCK, MISO and MOSI pins

    // NSS
	/*
    GPIO_InitStructure.GPIO_Pin = CON_SPI_NSS_PIN;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_OD;
    GPIO_Init(CON_SPI_NSS_GPIO_PORT, &GPIO_InitStructure);
	*/

	//CON_SPI_NSS_GPIO_PORT->BSRR = CON_SPI_NSS_PIN;
    GPIO_SetBits(CON_SPI_NSS_GPIO_PORT, CON_SPI_NSS_PIN);

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
    SPI_SSOutputCmd(SPI1, ENABLE); // TODO: Check if this is needed

    // Enable SPI
    SPI_Cmd(SPI1, ENABLE);
}

void CON_SPI_SendData(uint16_t data)
{
	//CON_SPI_NSS_GPIO_PORT->BRR = CON_SPI_NSS_PIN;
    GPIO_ResetBits(CON_SPI_NSS_GPIO_PORT, CON_SPI_NSS_PIN);
    SPI_I2S_SendData(SPI1, data);
	//CON_SPI_NSS_GPIO_PORT->BSRR = CON_SPI_NSS_PIN;
    GPIO_SetBits(CON_SPI_NSS_GPIO_PORT, CON_SPI_NSS_PIN);
}


// Connector I2C

void CON_I2C_Init(void)
{
    GPIO_InitTypeDef  GPIO_InitStructure;
    I2C_InitTypeDef   I2C_InitStructure;

    //RCC_APB2PeriphClockCmd(RCC_APB2Periph_AFIO | CON_I2C_SCL_GPIO_CLK, ENABLE);
    //RCC_APB2PeriphClockCmd(RCC_APB2Periph_AFIO | RCC_APB2Periph_GPIOB, ENABLE);
	RCC->APB2ENR |= RCC_APB2ENR_IOPBEN;
    //RCC_AHBPeriphClockCmd( CON_I2C_SCL_GPIO_CLK  |
    //                       CON_I2C_SDA_GPIO_CLK,
    //                      ENABLE);
    
    //RCC_APB1PeriphClockCmd(CON_I2C_CLK, ENABLE);
    //RCC_APB1PeriphClockCmd(RCC_APB1Periph_I2C1, ENABLE);
	RCC->APB1ENR |= RCC_APB1Periph_I2C1;
    //RCC_APB1PeriphClockCmd(CON_I2C_CLK | RCC_APB1Periph_SYSCFG, ENABLE);

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

ErrorStatus CON_I2C_SendData(uint8_t address, uint8_t data)
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

			return ERROR;
	    }
	}  

    // Send data
    I2C_SendData(CON_I2C, data);
    
    // Check EV8_2
    while(!I2C_CheckEvent(CON_I2C, I2C_EVENT_MASTER_BYTE_TRANSMITTED));  

    /* Send STOP Condition */
    I2C_GenerateSTOP(CON_I2C, ENABLE);

    return SUCCESS;
}
