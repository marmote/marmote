#include "ExtractFrames.h"

#include <stdlib.h>
#include <string.h>

#define WAITING_STATE	0 // Waiting for frame start
#define ID_STATE		1
#define COUNTER_STATE	2 // Collecting the frame counter


DataFrameExtractor::DataFrameExtractor (const unsigned char SOF_in[],
										const unsigned char SOF_SIZE_in,
										const unsigned char ID_in[],
										const unsigned char ID_SIZE_in)
	: 
	SOF_SIZE(SOF_SIZE_in),
	ID_SIZE(ID_SIZE_in),
	state(WAITING_STATE),
	collect_state(0),
	SOF_cnt(0),
	CNT_cnt(0)
{
	SOF = (unsigned char*) malloc( SOF_SIZE * sizeof(unsigned char) );
	ID = (unsigned char*) malloc( ID_SIZE * sizeof(unsigned char) );

	memcpy( SOF, SOF_in, SOF_SIZE );
	memcpy( ID, ID_in, ID_SIZE );
}


DataFrameExtractor::~DataFrameExtractor () 
{
	free(SOF);
	free(ID);
}


unsigned long DataFrameExtractor::ExtractDataFrames( unsigned char* input_buff, unsigned long input_buff_len )
{
	// Check to see if the buffer is large enough, if not increase size
	unsigned long worst_case_size = byte_buff_len + input_buff_len + 2 * SOF_SIZE;
	if ( byte_buff_total_len < worst_case_size )
		IncreaseBufferSize( worst_case_size - byte_buff_total_len );


    ////////////////////////////////////////
    // Extract frames
	for ( unsigned long i = 0; i < input_buff_len; i++ )
	{
		///////////////////
		// Do something with the sample according to the state we are in
		if ( state == WAITING_STATE )
		{
			// if we are storing the bytes
			if ( collect_state )
			{
				// We are looking for the start of frame sequence and we are storing data
                // Obvioulsy the start of frame sequence is not stored, but if only parts of it
                // are encountered that we have to store
                if ( input_buff[i] != SOF[SOF_cnt] )
				{
//					  memcpy( (void*) (byte_buff + byte_buff_len), (void*) SOF, SOF_cnt );
//                    byte_buff_len += SOF_cnt;
					AddToEnd( SOF, SOF_cnt );

                    if ( input_buff[i] != SOF[0] )
					{
						byte_buff[byte_buff_len] = input_buff[i];
                        byte_buff_len += 1;
					}
				}
			}
		}
        else if ( state == COUNTER_STATE )
		{
			CNT[CNT_cnt] = input_buff[i];

			if ( CNT_cnt == 3 )
			{
				frame_starts.push(byte_buff_len);
				frame_cnt.push( *( (unsigned int*) CNT ) );
			}
		}

		///////////////////
        // State transitions
		if ( state == WAITING_STATE )
		{
			if ( input_buff[i] == SOF[0] )
				SOF_cnt = 1;
			else if ( input_buff[i] == SOF[SOF_cnt] )
				SOF_cnt += 1;
			else 
				SOF_cnt = 0;

			if ( SOF_cnt >= SOF_SIZE )
			{
				SOF_cnt = 0;
				state = ID_STATE;

				collect_state = 0;
			}
		}
		else if ( state == ID_STATE )
		{
			if ( input_buff[i] == ID[0] )
				state = COUNTER_STATE;
			else 
				state = WAITING_STATE;
		}
		else if ( state == COUNTER_STATE )
		{
			CNT_cnt += 1;                

			if ( CNT_cnt >= 4 )
			{
				CNT_cnt = 0;
				state = WAITING_STATE;
				collect_state = 1;
			}
		}

	}

    return input_buff_len;
}
