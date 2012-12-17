// tools.cpp : Defines the entry point for the console application.
//
#include <stdio.h>

#include "ExtractNsamples16bit.h"
#include "ExtractFrames.h"
#include "FrameConfig.h"
#include "FileSource.h"


int main(int argc, char* argv[])
{
	ExtractNsamples16Bit	eNs16b;
	DataFrameExtractor		dfe((unsigned char*) START_OF_FRAME, START_OF_FRAME_SIZE, (unsigned char*) DATA_FRAME_ID, DATA_FRAME_ID_SIZE);
//	FileSource				s("D:/Work/Measurements/BreakTest_AluminiumBeam/meas/1-0.5/rec_001.bin");
	FileSource				s("D:/Work/Measurements/BreakTest_AluminiumBeam/meas/1-0.5");

#define N_TEST_LEN	1000


	short* output_items0 = (short*) malloc( N_TEST_LEN * sizeof(short) );
	short* output_items1 = (short*) malloc( N_TEST_LEN * sizeof(short) );




	unsigned long N = N_TEST_LEN;

	if ( N == 0 )
	{
		printf("FrameSource error: No space in output buffers!\n");
		return 0;
	}
    
	unsigned long noutput;


do
{
	noutput = 0;


	while (1)
	{
		// 1. Some minor pre-processing steps
		eNs16b_ret_t ret_s = eNs16b.Process( dfe.byte_buff_len, dfe.frame_starts, dfe.frame_cnt, N - noutput ); 

		if ( ret_s.buff_len )
		{
			for (unsigned long i=0; i<N; i++)
			{
				output_items0[i] = *((short*) (&dfe.byte_buff[i*2*2]));
				output_items1[i] = *((short*) (&dfe.byte_buff[i*2*2+2]));
			}

			while ( !ret_s.frame_starts.empty() )
			{
				/*
				unsigned long offset0 = this->nitems_written(0) + noutput + ret_s.frame_starts.front()/2;
				unsigned long offset1 = this->nitems_written(1) + noutput + ret_s.frame_starts.front()/2;
				pmt::pmt_t key		= pmt::pmt_string_to_symbol( "Frame counter" );
				char temp[50];
				sprintf( temp, "%d", ret_s.frame_cnt.front() );
				pmt::pmt_t value	= pmt::pmt_string_to_symbol( temp );

				this->add_item_tag(0, offset0, key, value);
				this->add_item_tag(1, offset1, key, value);
				*/

				ret_s.frame_starts.pop();
				ret_s.frame_cnt.pop();
			}

			noutput += ret_s.buff_len/2/2;
		}

		dfe.ClearFromBeginning( ret_s.buff_len ); // Clear any previous data, that was already processed

		// If we have enough data
		if ( noutput >= N ) 
			break;

		// Not enough but there's not gonna be any new
		if ( s.SourceEmpty() )
			break;

              
		// 2. Get some brand new, raw data
		fs_ret_t ret_s2;
		ret_s2 = s.GetBuffer(10000);
            

		// 3. Find data frames (if any) in data
		unsigned long proc_bytes = dfe.ExtractDataFrames(ret_s2.accum, ret_s2.accum_len);
		s.ClearFromBeginning(proc_bytes);
	}
}
while ( noutput || !s.SourceEmpty() );

	if ( noutput == 0 && s.SourceEmpty() )
	{
		printf("Source empty.\n");
		return -1;
	}
	else 
		return noutput;
}

