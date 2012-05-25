/*
 * Max2830.h
 *
 *  Created on: Nov 14, 2011
 *      Author: babjak
 */

#ifndef MAX2830_H_
#define MAX2830_H_

#include <stdint.h>

typedef enum __GPIOpin_t
{
	nSHDN = 13,
	RXHP = 14,
	ANTSEL = 15,
	RXTX = 28
} GPIOpin_t;


typedef enum __LNA_Attenuation_t
{
	LNA_HIGH_GAIN				= 0,
	LNA_MEDIUM_GAIN_16dB_LESS	= 1,
	LNA_LOW_GAIN_33dB_LESS		= 2
} LNA_Attenuation_t;


typedef enum __RXTX_BW_t
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
} RXTX_BW_t;


typedef enum __RX_HPF_Corner_Frequency_t
{
	RX_HPF_0_1kHz	= 0,
	RX_HPF_4kHz		= 1,
	RX_HPF_30kHz	= 2,
	RX_HPF_600kHz	= 3
} RX_HPF_Corner_Frequency_t;


typedef enum __ANALOG_MEASUREMENT_t
{
	ANALOG_MEAS_RSSI	= 0,
	ANALOG_MEAS_TEMP	= 1,
	ANALOG_MEAS_TXPOWER = 2
} ANALOG_MEASUREMENT_t;


typedef enum __IQ_Output_CM_t
{
	IQ_OUTPUT_CM_1_1V	= 0,
	IQ_OUTPUT_CM_1_2V	= 1,
	IQ_OUTPUT_CM_1_3V	= 2,
	IQ_OUTPUT_CM_1_45V	= 3
} IQ_Output_CM_t;


typedef enum __RXTX_t
{
	RX_MODE = 0,
	TX_MODE = 1
} RXTX_t;


//////////////////////////////////////////////////
//
// Functions provided by Max2830.c
//
//////////////////////////////////////////////////
//SPI and GPIO
void		Max2830_Init();

//SPI
uint32_t	Max2830_Set_Frequency		(uint32_t				f);
void		Max2830_Set_TX_Attenuation	(float					VGA_att_dB);
void		Max2830_Set_RX_Attenuation	(LNA_Attenuation_t LNA_att, uint8_t VGA_att_dB);
void		Max2830_Set_RXTX_LPF		(RXTX_BW_t				BW);
void		Max2830_Set_Lock_Detector	(char Enable,	char CMOSOutput,	char PullupForOpenDrain);
void		Max2830_Set_Ref_Clk_Output	(char Enable,	char DivideByTwo);
void		Max2830_Set_RSSI_Output		(ANALOG_MEASUREMENT_t	value);
void		Max2830_Set_RX_IQ_Output_CM (IQ_Output_CM_t			value);

//GPIO
void		ShutDownEnable		(char			EnableFlag);
void		SetRXTX				(RXTX_t			RXTX_mode);


//////////////////////////////////////////////////
//
// Functions needed by Max2830.c but implemented somewhere else
//
//////////////////////////////////////////////////
void		SetGPIO				(GPIOpin_t GPIOpin,	uint8_t value);
void		send_SPI			(uint32_t		tx_frame);



#endif /* RFX400_H_ */
