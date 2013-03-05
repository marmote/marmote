/*
 * MessageFormat.h
 *
 *  Created on: August 15, 2012
 *      Author: babjak
 */

#ifndef MESSAGEFORMAT_H_
#define MESSAGEFORMAT_H_


#define CMD_LENGTH			(4+4+14*1+2)  // = 24
#define SEQ_LENGTH			(3/*start sequence*/+1/*frame_type*/) // = 4
#define BUF_LENGTH			2*(CMD_LENGTH+SEQ_LENGTH)  //Must be dividable by CHUNK_LENGTH!!!!!!

#define FRAME_SEQ	{0xA1,0xBE,0xAF,0x02}		// A1BEAF  and  02 as message type

#endif /* DMA_STUFF_H_ */
