/*
 * RFX400.h
 *
 *  Created on: Nov 14, 2011
 *      Author: babjak
 */

#ifndef RFX400_H_
#define RFX400_H_

#include <stdint.h>


void RFX400init();
void RFX400InitFrequency(uint32_t frequency);
void RFX400SetFrequency();

#define	RFX400_TX_RX	0
#define RFX400_RX2		1

void RFX400SetInput(uint8_t input);


#endif /* RFX400_H_ */
