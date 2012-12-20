#include "ExtractNsamples16bit.h"


ExtractNsamples16Bit::ExtractNsamples16Bit()
{
}


ExtractNsamples16Bit::~ExtractNsamples16Bit()
{
}


eNs16b_ret_t ExtractNsamples16Bit::Process(unsigned long			byte_buff_len, 
										std::queue<unsigned long>	frame_starts, 
										std::queue<unsigned long>	frame_cnt,
										unsigned long				N = 0)
{
	////////////////////////////////////////
    // Fixed values
	unsigned char	channels	= 2;
	unsigned char	res			= 2; // resolution in bytes


    ////////////////////////////////////////
    // Set variables    
    unsigned long nominal_len = N * channels * res;

	if ( nominal_len > 0 )
		byte_buff_len = byte_buff_len < nominal_len ? byte_buff_len : nominal_len;

	eNs16b_ret_t	ret_s;
	ret_s.buff_len = byte_buff_len - byte_buff_len % (channels * res);

	while (!frame_starts.empty() && frame_starts.front() < ret_s.buff_len)
	{
		ret_s.frame_starts.push( frame_starts.front() );
		ret_s.frame_cnt.push( frame_cnt.front() );

		frame_starts.pop();
		frame_cnt.pop();
	}

	return ret_s;
}