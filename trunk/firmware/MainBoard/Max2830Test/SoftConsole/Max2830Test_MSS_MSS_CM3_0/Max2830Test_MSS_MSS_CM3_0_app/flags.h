/*
 * flags.h
 *
 *  Created on: Nov 14, 2011
 *      Author: babjak
 */

#ifndef FLAGS_H_
#define FLAGS_H_

#include <stdint.h>

typedef     uint16_t       flags_t;

void        SetFlagVal  ( flags_t* p_f, flags_t b, unsigned char Value );
void        SetFlag     ( flags_t* p_f, flags_t b );
void        ResetFlag   ( flags_t* p_f, flags_t b );
void        FlipFlag    ( flags_t* p_f, flags_t b );

char        GetFlag     ( flags_t* p_f, flags_t b );

#endif /* FLAGS_H_ */
