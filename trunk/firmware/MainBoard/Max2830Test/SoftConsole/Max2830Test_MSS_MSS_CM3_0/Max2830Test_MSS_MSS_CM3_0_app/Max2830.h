/*
 * Max2830.h
 *
 *  Created on: Nov 14, 2011
 *      Author: babjak
 */

#ifndef MAX2830_H_
#define MAX2830_H_

#include <stdint.h>

//SPI and GPIO
void	Max2830init();
//SPI
void	SetFrequency(uint32_t f);
void	SetTXGain(uint8_t g);
//GPIO
void ShutDownEnable(char EnableFlag);

typedef enum __RXTX_t
{
	RX_MODE = 0,
	TX_MODE = 1
} RXTX_t;


#endif /* RFX400_H_ */
