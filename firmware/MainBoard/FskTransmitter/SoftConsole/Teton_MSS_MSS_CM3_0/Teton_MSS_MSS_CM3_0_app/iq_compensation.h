/*
 * iq_compensation.h
 *
 *  Created on: Mar 6, 2013
 *      Author: sszilvasi
 */

#ifndef IQ_COMPENSATION_H_
#define IQ_COMPENSATION_H_

#include <a2fxxxm3.h>
#include <Teton_hw_platform.h>

#define IQ_AMPL_UNIT 0x40000000uL

/**
  Memory mapped structure for the IQ compensation block
 */
typedef struct
{
  __IO uint32_t AMPL_I;                         /*!< Offset: 0x00  Amplitude I sfix(31, 29)  */
  __IO uint32_t AMPL_Q;                         /*!< Offset: 0x04  Amplitude Q sfix(31, 29)  */
  __IO uint32_t DELAY_I;                        /*!< Offset: 0x08  Delay I in FPGA clock cycles ufix(9,0) */
  __IO uint32_t DELAY_Q;		      	  		/*!< Offset: 0x0C  Delay Q in FPGA clock cycles ufix(9,0) */

} IQ_COMPENSATION_Type;

/**
 * IQ_COMPENSATION_0 : Memory Map [ 0x40050100 - 0x400501FF ]
 */
#define IQ_COMP            ((IQ_COMPENSATION_Type *)       IQ_COMPENSATION_0)


#endif /* IQ_COMPENSATION_H_ */
