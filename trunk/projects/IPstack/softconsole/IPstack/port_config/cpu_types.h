/*******************************************************************************
 * (c) Copyright 2007 Actel Corporation.  All rights reserved.
 * 
 * Base types definitions.
 * 
 * SVN $Revision: 505 $
 * SVN $Date: 2008-07-09 11:05:43 +0100 (Wed, 09 Jul 2008) $
 */
#ifndef __CPU_TYPES_H
#define __CPU_TYPES_H	1

/*------------------------------------------------------------------------------
 * Use the standard definitions provided with the compiler for uint32_t, int32_t
 * uint16_t, int16_t, uint8_t, int8_t...
 */
#include <stdint.h>
#include <stddef.h>

/*------------------------------------------------------------------------------
 * addr_t: address type.
 * Used to specify the address of peripherals present in the processor's memory
 * map.
 */
//typedef uint32_t addr_t;

/*------------------------------------------------------------------------------
 * psr_t: processor state register.
 * Used by HAL_disable_interrupts() and HAL_restore_interrupts() to store the
 * processor's state between disabling and restoring interrupts.
 */
typedef unsigned int psr_t;

#endif	/* __CPU_TYPES_H */


