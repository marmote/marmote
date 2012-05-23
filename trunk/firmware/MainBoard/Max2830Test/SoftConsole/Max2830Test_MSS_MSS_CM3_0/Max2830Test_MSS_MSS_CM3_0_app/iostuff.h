/*
 * iostuff.h
 *
 *  Created on: May 23, 2012
 *      Author: babjak
 */

#ifndef IOSTUFF_H_
#define IOSTUFF_H_

typedef enum __GPIO_t
{
	nSHDN = 13,
	RXHP = 14,
	ANTSEL = 15,
	RXTX = 28
} GPIOpin_t;

/*#define		nSHDN	13
#define 	RXHP	14
#define		ANTSEL	15
#define 	RXTX	28*/


void SetGPIO(GPIOpin_t GPIOpin, uint8_t value);
//void SetGPIO(uint8_t GPIOpin, uint8_t value);

void send_SPI(uint32_t tx_frame);

#endif /* IOSTUFF_H_ */
