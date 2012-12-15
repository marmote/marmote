#include "FrameBuffer.h"


class ExtractFrames
	: public FrameBuffer
{
	public:
		ExtractFrames ();
		~ExtractFrames ();

		unsigned long ExtractDataFrames( unsigned char* input_buff, unsigned long input_buff_len );

	private:
		unsigned char state;
		unsigned char collect_state;

		// indicates how much of the START_OF_FRAME pattern was found
        unsigned char SOF_cnt;

        // for the frame counter temporary storage
        unsigned char CNT [4]; 
        unsigned char CNT_cnt;

};
