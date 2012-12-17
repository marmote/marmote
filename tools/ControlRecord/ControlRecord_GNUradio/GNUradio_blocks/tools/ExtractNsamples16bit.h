#include <queue>


typedef struct eNs16b_ret_s
{
	unsigned long				buff_len;
	std::queue<unsigned long>	frame_starts;
	std::queue<unsigned long>	frame_cnt;
} eNs16b_ret_t;


class ExtractNsamples16Bit
{
	public:
		ExtractNsamples16Bit ();
		~ExtractNsamples16Bit ();

		eNs16b_ret_t Process(unsigned long			byte_buff_len, 
						std::queue<unsigned long>	frame_starts, 
						std::queue<unsigned long>	frame_cnt,
						unsigned long				N);
};
