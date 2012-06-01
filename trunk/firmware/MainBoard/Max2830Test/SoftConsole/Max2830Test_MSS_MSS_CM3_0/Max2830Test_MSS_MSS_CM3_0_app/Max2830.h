/*
 * Max2830.h
 *
 *  Created on: Nov 14, 2011
 *      Author: babjak
 */

#ifndef MAX2830_H_
#define MAX2830_H_

#include <stdint.h>

typedef enum __Max2830_GPIO_t
{
	MAX2830_nSHDN	= 13,
	MAX2830_RXHP 	= 14,
	MAX2830_ANTSEL 	= 15,
	MAX2830_RXTX 	= 28
} Max2830_GPIO_t;


typedef enum __Max2830_LNA_Att_t
{
	MAX2830_LNA_HIGH_GAIN			= 0,
	MAX2830_LNA_MED_GAIN_16dB_LESS	= 1,
	MAX2830_LNA_LOW_GAIN_33dB_LESS	= 2
} Max2830_LNA_Att_t;


typedef enum __Max2830_RXTX_BW_t
{
//8MHz
	MAX2830_RXTX_BW_7_2MHz		= 0,
	MAX2830_RXTX_BW_7_6MHz		= 1,
	MAX2830_RXTX_BW_8MHz 		= 2,
	MAX2830_RXTX_BW_8_4MHz		= 3,
	MAX2830_RXTX_BW_8_8MHz		= 4,
	MAX2830_RXTX_BW_9_2MHz		= 5,
//11MHz
	MAX2830_RXTX_BW_9_9MHz		= 6,
	MAX2830_RXTX_BW_10_45MHz	= 7,
	MAX2830_RXTX_BW_11MHz		= 8,
	MAX2830_RXTX_BW_11_55MHz	= 9,
	MAX2830_RXTX_BW_12_1MHz		= 10,
	MAX2830_RXTX_BW_12_65MHz	= 11,
//16.5MHz
	MAX2830_RXTX_BW_14_85MHz	= 12,
	MAX2830_RXTX_BW_15_675MHz	= 13,
	MAX2830_RXTX_BW_16_5MHz		= 14,
	MAX2830_RXTX_BW_17_325MHz	= 15,
	MAX2830_RXTX_BW_18_15MHz	= 16,
	MAX2830_RXTX_BW_18_975MHz	= 17,
//22.5MHz
	MAX2830_RXTX_BW_20_25MHz	= 18,
	MAX2830_RXTX_BW_21_375MHz	= 19,
	MAX2830_RXTX_BW_22_5MHz		= 20,
	MAX2830_RXTX_BW_23_625MHz	= 21,
	MAX2830_RXTX_BW_24_75MHz	= 22,
	MAX2830_RXTX_BW_25_875MHz	= 23
} Max2830_RXTX_BW_t;


typedef enum __Max2830_RX_HPF_t
{
	MAX2830_RX_HPF_0_1kHz	= 0,
	MAX2830_RX_HPF_4kHz		= 1,
	MAX2830_RX_HPF_30kHz	= 2,
	MAX2830_RX_HPF_600kHz	= 3
} Max2830_RX_HPF_t;


typedef enum __Max2830_Analog_Meas_t
{
	MAX2830_ANALOG_MEAS_RSSI	= 0,
	MAX2830_ANALOG_MEAS_TEMP	= 1,
	MAX2830_ANALOG_MEAS_TXPOW	= 2
} Max2830_Analog_Meas_t;


typedef enum __Max2830_IQ_Out_CM_t
{
	MAX2830_IQ_OUT_CM_1_1V	= 0,
	MAX2830_IQ_OUT_CM_1_2V	= 1,
	MAX2830_IQ_OUT_CM_1_3V	= 2,
	MAX2830_IQ_OUT_CM_1_45V	= 3
} Max2830_IQ_Out_CM_t;


typedef enum __Max2830_RX_Ant_t
{
	MAX2830_RX_ANT_MAIN			= 0,
	MAX2830_RX_ANT_DIVERSITY	= 1
} Max2830_RX_Ant_t;


typedef enum __Max2830_Mode_t
{
	MAX2830_SHUTDOWN_MODE	= 0,
	MAX2830_STANDBY_MODE 	= 1,
	MAX2830_RX_MODE			= 2,
	MAX2830_TX_MODE 		= 3,
	MAX2830_RX_CALIB_MODE	= 4,
	MAX2830_TX_CALIB_MODE	= 5
} Max2830_Mode_t;


typedef enum __Max2830_TX_Cal_Gain_t
{
	MAX2830_TX_CAL_GAIN_9dB		= 0,
	MAX2830_TX_CAL_GAIN_19dB	= 1,
	MAX2830_TX_CAL_GAIN_29dB	= 2,
	MAX2830_TX_CAL_GAIN_39dB	= 3
} Max2830_TX_Cal_Gain_t;

//////////////////////////////////////////////////
//
// Functions provided by Max2830.c
//
//////////////////////////////////////////////////
//SPI and GPIO
void		Max2830_Init();

uint32_t	Max2830_Set_Frequency		(uint32_t				freq_Hz);

void		Max2830_Set_TX_Attenuation	(float					VGA_att_dB);

void		Max2830_Set_RX_Attenuation	(Max2830_LNA_Att_t		LNA_att,
										uint8_t					VGA_att_dB);

void		Max2830_Set_RXTX_LPF		(Max2830_RXTX_BW_t		BW);

void		Max2830_Set_Lock_Detector	(char					Enable,
										char					CMOSOutput,
										char					PullupForOpenDrain);

void		Max2830_Set_Ref_Clk_Output	(char					Enable,
										char					DivideByTwo);

void		Max2830_Set_RX_HPF			(Max2830_RX_HPF_t		value);

void		Max2830_Set_RSSI_Output		(Max2830_Analog_Meas_t	value);

void		Max2830_Set_RX_IQ_Output_CM (Max2830_IQ_Out_CM_t	value);

uint16_t	Max2830_Set_PA_Delay		(uint16_t				delay_ns);

void		Max2830_Set_Mode			(Max2830_Mode_t			mode);

void		Max2830_Set_TX_Cal_Gain		(Max2830_TX_Cal_Gain_t	value);

void		Max2830_Set_RX_Ant			(Max2830_RX_Ant_t		RX_Ant);


//////////////////////////////////////////////////
//
// Functions needed by Max2830.c but implemented somewhere else
//
//////////////////////////////////////////////////
void		set_GPIO			(Max2830_GPIO_t GPIOpin,	uint8_t value);
void		send_SPI			(uint32_t		tx_frame);



#endif /* RFX400_H_ */
