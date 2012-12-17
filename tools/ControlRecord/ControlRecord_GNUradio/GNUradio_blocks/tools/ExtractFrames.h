#include "FrameBuffer.h"


class DataFrameExtractor
	: public FrameBuffer
{
	public:
		DataFrameExtractor (const unsigned char SOF_in[],
							const unsigned char SOF_SIZE_in,
							const unsigned char ID_in[],
							const unsigned char ID_SIZE_in);
		~DataFrameExtractor ();

		unsigned long ExtractDataFrames( unsigned char* input_buff, unsigned long input_buff_len );

	private:
		unsigned char*	SOF;
		unsigned char	SOF_SIZE;
		unsigned char*	ID;
		unsigned char	ID_SIZE;

		unsigned char state;
		unsigned char collect_state;

		// indicates how much of the START_OF_FRAME pattern was found
        unsigned char SOF_cnt;

        // for the frame counter temporary storage
        unsigned char CNT [4]; 
        unsigned char CNT_cnt;

};
