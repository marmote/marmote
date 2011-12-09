/*
 * flags.c
 *
 *  Created on: Nov 14, 2011
 *      Author: babjak
 */

#include "flags.h"


/*******************************************************************************
*******************************************************************************
**	Set a given bit in a flag.
**
**	@param  TODO  TODO
**
*******************************************************************************/
void SetFlagVal( flags_t* p_f, flags_t b, unsigned char Value )
{
    if (Value)
    	SetFlag( p_f, b );
    else
    	ResetFlag( p_f, b );
}

void SetFlag( flags_t* p_f, flags_t b )
{
	(*p_f) = ((*p_f) & ~b) | b;
}

void ResetFlag( flags_t* p_f, flags_t b )
{
	(*p_f) &= ~b;
}

void FlipFlag( flags_t* p_f, flags_t b )
{
    SetFlagVal( p_f, b, !GetFlag( p_f, b ) );
}


/*******************************************************************************
*******************************************************************************
**	Read a given bit from flag.
**
**	@param  TODO  TODO
**
*******************************************************************************/
char GetFlag( flags_t* p_f, flags_t b )
{
    return (*p_f) & b;
}
