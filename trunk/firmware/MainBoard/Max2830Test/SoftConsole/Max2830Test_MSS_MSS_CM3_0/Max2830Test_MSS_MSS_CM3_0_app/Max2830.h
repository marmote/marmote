/*
 * Max2830.h
 *
 *  Created on: Nov 14, 2011
 *      Author: babjak
 */

#ifndef MAX2830_H_
#define MAX2830_H_

#include <stdint.h>


typedef enum __Max2830_RXTX_BW_t
{
//8MHz
	MAX2830_RXTX_BW_7_2		= 0,
	MAX2830_RXTX_BW_7_6		= 1,
	MAX2830_RXTX_BW_8 		= 2,
	MAX2830_RXTX_BW_8_4		= 3,
	MAX2830_RXTX_BW_8_8		= 4,
	MAX2830_RXTX_BW_9_2		= 5,
//11MHz
	MAX2830_RXTX_BW_9_9		= 6,
	MAX2830_RXTX_BW_10_45	= 7,
	MAX2830_RXTX_BW_11		= 8,
	MAX2830_RXTX_BW_11_55	= 9,
	MAX2830_RXTX_BW_12_1	= 10,
	MAX2830_RXTX_BW_12_65	= 11,
//16.5MHz
	MAX2830_RXTX_BW_14_85	= 12,
	MAX2830_RXTX_BW_15_675	= 13,
	MAX2830_RXTX_BW_16_5	= 14,
	MAX2830_RXTX_BW_17_325	= 15,
	MAX2830_RXTX_BW_18_15	= 16,
	MAX2830_RXTX_BW_18_975	= 17,
//22.5MHz
	MAX2830_RXTX_BW_20_25	= 18,
	MAX2830_RXTX_BW_21_375	= 19,
	MAX2830_RXTX_BW_22_5	= 20,
	MAX2830_RXTX_BW_23_625	= 21,
	MAX2830_RXTX_BW_24_75	= 22,
	MAX2830_RXTX_BW_25_875	= 23
} Max2830_RXTX_BW_t;


//////////////////////////////////////////////////
//
// Functions provided by Max2830.c
//
//////////////////////////////////////////////////
//SPI and GPIO
void	Max2830init();


//SPI
void	SetFrequency(uint32_t f);
void	SetTXGain(uint8_t g);
void	Set_RXTX_BW(Max2830_RXTX_BW_t BW);
void	Set_Lock_Detector(char Enable, char CMOSOutput, char PullupForOpenDrain);
void	Set_Reference_Clk_Output(char Enable, char DivideByTwo);

//GPIO
void ShutDownEnable(char EnableFlag);

typedef enum __RXTX_t
{
	RX_MODE = 0,
	TX_MODE = 1
} RXTX_t;

void SetRXTX(RXTX_t RXTX_mode);


//////////////////////////////////////////////////
//
// Functions needed by Max2830.c but implemented somewhere else
//
//////////////////////////////////////////////////
typedef enum __GPIO_t
{
	nSHDN = 13,
	RXHP = 14,
	ANTSEL = 15,
	RXTX = 28
} GPIOpin_t;

void SetGPIO(GPIOpin_t GPIOpin, uint8_t value);
void send_SPI(uint32_t tx_frame);



#endif /* RFX400_H_ */
