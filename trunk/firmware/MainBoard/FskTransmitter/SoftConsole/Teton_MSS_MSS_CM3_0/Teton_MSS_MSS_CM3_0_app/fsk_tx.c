#include "fsk_tx.h"


void FSK_TX_init()
{
	FSK_TX->CTRL = 1;
    FSK_TX->MUX = 0;
	SystemCoreClockUpdate();
}


void FSK_TX_set_frequency( uint32_t freq )
{
	float dpha;

	dpha = (float)freq / (float)g_FrequencyFPGA;
	FSK_TX->DPHA_H = (uint32_t)(dpha * (float)((uint32_t)1 << 31));
	FSK_TX->DPHA_L = (uint32_t)(dpha);

	return;
}



uint32_t FSK_TX_get_frequency(void)
{
	float frequency;

	frequency = (float)FSK_TX->DPHA_H / (float)((uint32_t)1 << 31) * g_FrequencyFPGA;

	return (uint32_t)frequency;
}

