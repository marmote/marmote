#include "fsk_tx.h"


void FSK_TX_init(
		uint32_t baud_rate,
		uint32_t center_freq,
		uint32_t separation_freq )
{
	FSK_TX->CTRL = 1;
    FSK_TX->MUX = 0;
	FSK_TX_set_amplitude(0);

	SystemCoreClockUpdate();
}


void FSK_TX_set_frequency( uint32_t freq )
{
	float dpha;

	dpha = (float)freq / (float)g_FrequencyFPGA;
	FSK_TX->DPHA = (uint32_t)(dpha * (float)((uint32_t)1 << 31));

	return;
}



uint32_t FSK_TX_get_frequency(void)
{
	float frequency;

	frequency = (float)FSK_TX->DPHA / (float)((uint32_t)1 << 31) * g_FrequencyFPGA;

	return (uint32_t)frequency;
}



void FSK_TX_set_amplitude(uint32_t amplitude)
{
	uint32_t ampl;
	// TODO: add parameter range check
	if (amplitude > FSK_TX_AMPL_MAX)
	{
		amplitude = FSK_TX_AMPL_MAX;
	}

	ampl = (amplitude << 9) / FSK_TX_AMPL_MAX;

	FSK_TX->AMPL = ampl;

	return;
}



uint32_t FSK_TX_get_amplitude(void)
{
	uint32_t amplitude;

	amplitude = (FSK_TX->AMPL * FSK_TX_AMPL_MAX) >> 9;

	return amplitude;
}
