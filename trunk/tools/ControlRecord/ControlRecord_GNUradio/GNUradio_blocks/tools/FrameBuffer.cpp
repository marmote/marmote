#include "FrameBuffer.h"

#include <stdlib.h>
#include <string.h>


FrameBuffer::FrameBuffer ()
	: byte_buff(NULL),
	byte_buff_len(0),
	byte_buff_total_len(0)
{
}


FrameBuffer::~FrameBuffer () 
{
	if (!byte_buff)
		return;

	free(byte_buff);
	byte_buff = NULL;
}


void FrameBuffer::IncreaseBufferSize( unsigned long inc_buff_len )
{
	byte_buff_total_len += inc_buff_len;
	byte_buff = (unsigned char*) realloc( (void*) byte_buff, byte_buff_total_len );
}


void FrameBuffer::ClearFromBeginning( unsigned long buff_len )
{
	buff_len = buff_len < byte_buff_len ? buff_len : byte_buff_len;

	while ( !frame_starts.empty() && frame_starts.front() < buff_len )
	{
		frame_starts.pop();
		frame_cnt.pop();
	}

	for ( unsigned long i = 0; i < frame_starts.size(); i++ )
	{
		frame_starts.push( frame_starts.front() - buff_len );
		frame_starts.pop();
	}

	memmove( (void*) byte_buff, (void*) (byte_buff + buff_len), byte_buff_len - buff_len );

	byte_buff_len -= buff_len;
}


void FrameBuffer::AddToEnd( unsigned char* in_buff, unsigned long in_buff_len )
{
	unsigned long worst_case_size = byte_buff_len + in_buff_len;
	if ( byte_buff_total_len < worst_case_size )
		IncreaseBufferSize( worst_case_size - byte_buff_total_len );

	memcpy( (void*) (byte_buff + byte_buff_len), (void*) in_buff, in_buff_len );
	byte_buff_len += in_buff_len;
}
