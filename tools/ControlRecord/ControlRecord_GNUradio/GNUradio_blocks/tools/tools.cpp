// tools.cpp : Defines the entry point for the console application.
//
#include <stdio.h>

#include "ExtractNsamples16bit.h"
#include "ExtractFrames.h"
#include "FrameConfig.h"


int main(int argc, char* argv[])
{
	ExtractNsamples16Bit	eNs16b();
	DataFrameExtractor		dfe(START_OF_FRAME, START_OF_FRAME_SIZE, DATA_FRAME_ID, DATA_FRAME_ID_SIZE);




	unsigned long N = 1000;

	if ( N == 0 )
	{
		printf("FrameSource error: No space in output buffers!");
		return 0;
	}
    
	unsigned long noutput = 0;


	while (1)
	{
		// 1. Some minor pre-processing steps
		eNs16b_ret_t ret_s = eNs16b.Process(dfe.byte_buff_len, dfe.frame_starts, dfe.frame_cnt, N - noutput ) 

		if self.int_buff.size :
			output_items[0][noutput_items : noutput_items + self.int_buff.size/2] = self.int_buff[0::2]
			output_items[1][noutput_items : noutput_items + self.int_buff.size/2] = self.int_buff[1::2]

			for ii in xrange(len(self.frame_starts)) :
				offset0 = self.nitems_written(0) + noutput_items + self.frame_starts[ii]/2
				offset1 = self.nitems_written(1) + noutput_items + self.frame_starts[ii]/2
				key = pmt.pmt_string_to_symbol( "Frame counter" )
				value = pmt.pmt_string_to_symbol( "%d"%self.frame_cnt[ii] )

				self.add_item_tag(0, offset0, key, value)
				self.add_item_tag(1, offset1, key, value)

			noutput_items += self.int_buff.size/2


		self.dfe.ClearFromBeginning( self.processed_bytes ) # Clear any previous data, that was already processed

		// If we have enough data
		if noutput_items >= N :
			break

		// Not enough but there's not gonna be any new
		if self.s.SourceEmpty() :
			break

              
		// 2. Get some brand new, raw data
		accum, accum_length = self.s.GetBuffer(10000)
            

		// 3. Find data frames (if any) in data
		proc_bytes = self.dfe.ExtractDataFrames(accum, accum_length)
		self.s.ClearFromBeginning(proc_bytes) 
	}


	if noutput_items == 0 and self.s.SourceEmpty() :
		print 'Source empty.'
		return -1
	else :
		return noutput_items

	return 0;
}

