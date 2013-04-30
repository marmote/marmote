/*
 * yellowstone.h
 *
 *  Created on: Aug 2, 2012
 *      Author: sszilvasi
 */

#ifndef YELLOWSTONE_H_
#define YELLOWSTONE_H_

#include <mss_spi.h>
#include <mss_gpio.h>
#include <stdio.h>
#include <string.h>

#define MSS_GPIO_SPI_0_IT    	MSS_GPIO_28		// SPI0 slave interrupt from Yellowstone
#define MSS_GPIO_SPI_0_IT_MASK	MSS_GPIO_28_MASK
#define MSS_GPIO_SPI_0_IT_IRQn  GPIO28_IRQn

uint8_t spi_cmd_length;

void Yellowstone_Init(void);

void Yellowstone_write( const char* data, uint8_t len );
void Yellowstone_print( const char* data );



#endif /* YELLOWSTONE_H_ */
