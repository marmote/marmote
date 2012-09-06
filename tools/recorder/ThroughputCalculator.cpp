#include "ThroughputCalculator.h"
#include <stdio.h>


CThroughput_Calculator::CThroughput_Calculator() :
	bytes(0)

{
	QueryPerformanceFrequency(&frequency);
	QueryPerformanceCounter(&time_prev);
}


void CThroughput_Calculator::Inc_Byte_Counter(unsigned long  add_bytes)
{
	bytes += add_bytes;
}


void CThroughput_Calculator::Calculate_Throughput()
{
	QueryPerformanceCounter(&time_now);

	double elapsed_time;

	elapsed_time = (time_now.QuadPart - time_prev.QuadPart) * 1.0 / frequency.QuadPart;

	if (elapsed_time < 3)
		return;

	printf("Throughput: %6.2f MB/s\n", (double)bytes / (double)(1 << 20) / elapsed_time);

	bytes = 0;
	time_prev = time_now;
}