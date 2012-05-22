#include "fsk_tx.h"


void FSK_TX_init(void)
{
	FSK_TX->CTRL = 1;
}



void FSK_TX_set_frequency(uint32_t freq)
{
	// FIXME: eliminate floats
	float dpha;

	dpha = (float)freq / (float)g_FrequencyFPGA;
	FSK_TX->DPHA = (uint32_t)(dpha * (float)((uint32_t)1 << 31) * 2);

	return;
}



uint32_t FSK_TX_get_frequency(void)
{
	float frequency;

	frequency = (float)FSK_TX->DPHA / (float)((uint32_t)1 << 31) / 2 * g_FrequencyFPGA;

	return (uint32_t)frequency;
}



void FSK_TX_set_amplitude(uint32_t amplitude)
{
	uint32_t ampl;
	// TODO: add parameter range check
//	if (amplitude > FSK_TX_AMPL_MAX)
//	{
//		amplitude = FSK_TX_AMPL_MAX;
//	}

	ampl = (amplitude << 8) / FSK_TX_AMPL_MAX;

	FSK_TX->AMPL = ampl;

	return;
}



uint32_t FSK_TX_get_amplitude(void)
{
	uint32_t amplitude;

	amplitude = (FSK_TX->AMPL * FSK_TX_AMPL_MAX) >> 8;

	return amplitude;
}
