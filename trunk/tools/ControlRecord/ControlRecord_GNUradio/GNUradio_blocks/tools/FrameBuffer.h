#include <queue>


class FrameBuffer
{
	public:
		FrameBuffer ();
		~FrameBuffer ();

		void IncreaseBufferSize( unsigned long inc_buff_len = 100 );
		void ClearFromBeginning( unsigned long buff_len );
		void AddToEnd( unsigned char* in_buff, unsigned long in_buff_len );


	protected:
		std::queue<unsigned long>	frame_starts;
		std::queue<unsigned long>	frame_cnt;

		unsigned char*				byte_buff;
		unsigned long				byte_buff_len;
		unsigned long				byte_buff_total_len;
};
