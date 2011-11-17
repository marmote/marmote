//-----------------------------------------------------------------------------
// Title         : Power Monitor Functions Source
// Project       : Power Board
//-----------------------------------------------------------------------------
// File          : power_monitor.c
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
//---------------------------------------------------------------------------
// Revisions     :
// Date            Version  Author			Description
// 2011-11-04      1.0      Sandor Szilvasi	Created
// 2011-11-17      1.1      Sandor Szilvasi	Re-organized and cleaned up the
//                                          content
//---------------------------------------------------------------------------

#include "power_monitor.h"

void PowerMonitor_Init(void)
{
    LED_Init();
    BAT_I2C_Init();
    SD_SPI_Init();

	Logger_Init();
}

/*-------------------------------------------------------------------------*/
/*                                  LEDs                                   */
/*-------------------------------------------------------------------------*/

void LED_Init(void)
{
    GPIO_InitTypeDef  GPIO_InitStructure;

	// Enable peripheral clock
	RCC_APB2PeriphClockCmd( LED_LED1_GPIO_CLK |
                            LED_LED2_GPIO_CLK |
                            RCC_APB2Periph_AFIO,
                            ENABLE);
	
    // PA.15 GPIO remap for LED1
    AFIO->MAPR |= AFIO_MAPR_SWJ_CFG_JTAGDISABLE;

    // Make sure the LEDs are turned-off by default
    LED_LED1_GPIO_PORT->BSRR = LED_LED1_PIN;
	LED_LED2_GPIO_PORT->BSRR = LED_LED2_PIN;

	// Configure LEDs to open-drain
	GPIO_InitStructure.GPIO_Pin = LED_LED1_PIN;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_10MHz;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_OD;
    GPIO_Init(LED_LED1_GPIO_PORT, &GPIO_InitStructure); 

	GPIO_InitStructure.GPIO_Pin = LED_LED2_PIN;
    GPIO_Init(LED_LED2_GPIO_PORT, &GPIO_InitStructure);
}

void LED_On (uint32_t led)
{
    if (led & LED1)
    {
        GPIOA->BRR = LED_LED1_PIN;
    }

    if (led & LED2)
    {
        GPIOB->BRR = LED_LED2_PIN;
    }
}

void LED_Off (uint32_t led)
{
    if (led & LED1)
    {
        GPIOA->BSRR = LED_LED1_PIN;
    }

    if (led & LED2)
    {
        GPIOB->BSRR = LED_LED2_PIN;
    }
}

void LED_Toggle (uint32_t led)
{
    if (led & LED1)
    {
        if (GPIOA->IDR & LED_LED1_PIN)
        {
            GPIOA->BRR = LED_LED1_PIN;
        }
        else
        {
            GPIOA->BSRR = LED_LED1_PIN;
        }
    }

    if (led & LED2)
    {
        if (GPIOB->IDR & LED_LED2_PIN)
        {
            GPIOB->BRR = LED_LED2_PIN;
        }
        else
        {
            GPIOB->BSRR = LED_LED2_PIN;
        }
    }
}


/*-------------------------------------------------------------------------*/
/*                              ADC MONITOR                                */
/*-------------------------------------------------------------------------*/

// TODO: make it in a sort of subscriber style so that it can be logged to:
//       - USB CDC (Virtual COM port)
//       - USB Audio
//       - SD card
void Logger_Init(void)
{						   
  	NVIC_InitTypeDef NVIC_InitStructure;
	TIM_TimeBaseInitTypeDef TIM_InitStructure;

  	NVIC_PriorityGroupConfig(NVIC_PriorityGroup_1);

	// Configure TIM2 interrupts in NVIC
	NVIC_InitStructure.NVIC_IRQChannel = TIM2_IRQn;
  	NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 1;
  	NVIC_InitStructure.NVIC_IRQChannelSubPriority = 0;
  	NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;
  	NVIC_Init(&NVIC_InitStructure);

	// Enable peripheral clock
	RCC_APB1PeriphClockCmd(RCC_APB1Periph_TIM2, ENABLE);

	// Initialize peripheral
	TIM_InitStructure.TIM_Prescaler	= 7200; // 100 us at 72 MHz SysClk
	TIM_InitStructure.TIM_CounterMode = TIM_CounterMode_Down;
	TIM_InitStructure.TIM_Period = 10000;
	TIM_InitStructure.TIM_ClockDivision = TIM_CKD_DIV2;
	TIM_InitStructure.TIM_RepetitionCounter = 0;
	TIM_TimeBaseInit(TIM2, &TIM_InitStructure);					   
	
    // Enable auto-reload
	TIM_ARRPreloadConfig(TIM2, ENABLE);
							
    // Enable interrupt at peripheral level
	TIM_ITConfig(TIM2, TIM_IT_Update, ENABLE);

	// Enable Peripheral
	TIM_Cmd(TIM2, ENABLE);
}

static uint16_t ctr;

void TIM2_IRQHandler(void)
{
    uint32_t volt;
    uint32_t temp;
	
	if (TIM_GetITStatus(TIM2, TIM_IT_Update) == SET)
	{
		LED_Toggle(LED1);

		SD_SPI_SendData(ctr++);

        // TODO: Time critical part of logging here
        
        // For now, just log battery voltage and temperature through USB
        // NOTE: the current implementation is sub-optimal for an ISR
        BAT_WriteRegister(BAT_CONTROL, 0xB8);
        // U = 6V * volt / 0xFFFF
        volt = BAT_ReadRegister(BAT_VOLTAGE_MSB);


        BAT_WriteRegister(BAT_CONTROL, 0x78);
        // T = 600K * temp / 0xFFFF
        temp = BAT_ReadRegister(BAT_TEMPERATURE_MSB);

		sprintf((char*)&USB_Tx_Buffer[0], "%5.2f V \t%5.1f C\r\n",
                (float)volt * 6 / (float)0xFFFF,
                ((float)temp * 600 / (float)0xFFFF) - (float)273.15);

        USB_Tx_Length = strlen((char*)USB_Tx_Buffer);
        
        /*
		USB_Tx_Buffer[0] = 'x';
		USB_Tx_Buffer[1] = 'x';
		USB_Tx_Buffer[2] = '.';
		USB_Tx_Buffer[3] = 'y';
		USB_Tx_Buffer[4] = 'y';
		USB_Tx_Buffer[5] = ' ';
		USB_Tx_Buffer[6] = 'V';
		USB_Tx_Buffer[7] = '\r';
		USB_Tx_Length = 8;
        */
				
		UserToPMABufferCopy(USB_Tx_Buffer, ENDP1_TXADDR, USB_Tx_Length);
		SetEPTxCount(ENDP1, USB_Tx_Length);
		SetEPTxValid(ENDP1);

		TIM_ClearITPendingBit(TIM2, TIM_IT_Update);
	}
	else
	{
		LED_On(LED2);
		while(1);
	}
}



/*-------------------------------------------------------------------------*/
/*                              BATTERY GAUGE                              */
/*-------------------------------------------------------------------------*/

void BAT_I2C_Init(void)
{
    GPIO_InitTypeDef  GPIO_InitStructure;
    I2C_InitTypeDef   I2C_InitStructure;

	RCC_APB2PeriphClockCmd(BAT_I2C_SCL_GPIO_CLK |
                           BAT_I2C_SDA_GPIO_CLK,
                           ENABLE);
	
	GPIO_InitStructure.GPIO_Pin = BAT_I2C_SCL_PIN | BAT_I2C_SDA_PIN;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_10MHz;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_OD;
    GPIO_Init(BAT_I2C_SDA_GPIO_PORT, &GPIO_InitStructure); 

    
	// Enable peripheral clock
	RCC_APB1PeriphClockCmd(BAT_I2C_CLK, ENABLE);

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
}

void BAT_WriteRegister(BAT_RegisterAddress_Type address, uint16_t data)
{
    switch (address)
    {
        // 8-bit writable registers
        case BAT_CONTROL :
        case BAT_VOLTAGE_THRESHOLD_HIGH :
        case BAT_VOLTAGE_THRESHOLD_LOW :
        case BAT_TEMPERATURE_THRESHOLD_HIGH :
        case BAT_TEMPERATURE_THRESHOLD_LOW :

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
        case BAT_ACCUMULATED_CHARGE_MSB :
        case BAT_CHARGE_THRESHOLD_HIGH_MSB :
        case BAT_CHARGE_THRESHOLD_LOW_MSB :

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
    uint16_t data;

    switch (address)
    {
        // 8-bit readable registers
        case BAT_STATUS :
        case BAT_CONTROL :
        case BAT_VOLTAGE_THRESHOLD_HIGH :
        case BAT_VOLTAGE_THRESHOLD_LOW :
        case BAT_TEMPERATURE_THRESHOLD_HIGH :
        case BAT_TEMPERATURE_THRESHOLD_LOW :
							
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

            break;

        // 16-bit readable registers
        case BAT_ACCUMULATED_CHARGE_MSB :
        case BAT_CHARGE_THRESHOLD_HIGH_MSB :
        case BAT_CHARGE_THRESHOLD_LOW_MSB :
        case BAT_VOLTAGE_MSB :
        case BAT_TEMPERATURE_MSB :

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
            
            // Enable I2C acknowledgement
            I2C_AcknowledgeConfig(BAT_I2C, ENABLE);

            // EV7
            while(!I2C_CheckEvent(BAT_I2C, I2C_EVENT_MASTER_BYTE_RECEIVED));  

            // Receive MSB register value
            data = (uint16_t)(I2C_ReceiveData(BAT_I2C)) << 8;

            // Disable I2C acknowledgement
            I2C_AcknowledgeConfig(BAT_I2C, DISABLE);

            // Set STOP Condition
            I2C_GenerateSTOP(BAT_I2C, ENABLE);
                                            
            // EV7
            while(!I2C_CheckEvent(BAT_I2C, I2C_EVENT_MASTER_BYTE_RECEIVED));  

            // Receive data
            data |= (uint16_t)(I2C_ReceiveData(BAT_I2C));

            break;
            

        default :

            break;

    }

    return data;
}

/*-------------------------------------------------------------------------*/
/*                                  SD CARD                                */
/*-------------------------------------------------------------------------*/


void SD_SPI_Init(void)
{
	GPIO_InitTypeDef  GPIO_InitStructure;
	SPI_InitTypeDef  SPI_InitStructure;

	RCC_APB2PeriphClockCmd(SD_SPI_NSS_GPIO_CLK |
                           SD_SPI_SCK_GPIO_CLK |
                           SD_SPI_MISO_GPIO_CLK |
                           SD_SPI_MOSI_GPIO_CLK,
                           ENABLE);
    
	// Enable peripheral clock
	RCC_APB1PeriphClockCmd(RCC_APB1Periph_SPI2, ENABLE);

    // Default value
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
    SPI_SSOutputCmd(SD_SPI, ENABLE);

    // Enable SPI
    SPI_Cmd(SD_SPI, ENABLE);
}

void SD_SPI_SendData(uint16_t data)
{
    //GPIO_ResetBits(SD_SPI_NSS_GPIO_PORT, SD_SPI_NSS_PIN);
	SD_SPI_NSS_GPIO_PORT->BRR = SD_SPI_NSS_PIN;

    SPI_I2S_SendData(SD_SPI, data);
	while (SD_SPI->SR & SPI_SR_BSY); // wait for busy flag

    //GPIO_SetBits(SD_SPI_NSS_GPIO_PORT, SD_SPI_NSS_PIN);
	SD_SPI_NSS_GPIO_PORT->BSRR = SD_SPI_NSS_PIN;
}




