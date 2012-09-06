#pragma once

#include <Windows.h>


class CThroughput_Calculator
{
	private :

		unsigned long	bytes;
		LARGE_INTEGER	time_prev;
		LARGE_INTEGER	time_now;
		LARGE_INTEGER	frequency;


	public :

		CThroughput_Calculator();
		void Inc_Byte_Counter(unsigned long  add_bytes);
		void Calculate_Throughput();

};