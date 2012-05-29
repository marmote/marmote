#include "fsk_tx.h"


void FSK_TX_init(
		uint32_t baud_rate,
		uint32_t center_freq,
		uint32_t separation_freq )
{
	FSK_TX->CTRL = 1;
    FSK_TX->MUX = 0;
	FSK_TX_set_amplitude(0);

	fsk_tx_busy = 0;

	SystemCoreClockUpdate();

	// Calculate direct parameters
	f_low = center_freq - separation_freq/2;
	f_high = center_freq + separation_freq/2;

	delta_phase_high = ((uint64_t)f_high << 32)/g_FrequencyFPGA;
	delta_phase_low = ((uint64_t)f_low << 32)/g_FrequencyFPGA;


	// Initialize timer
	MSS_TIM1_init( MSS_TIMER_PERIODIC_MODE );
	MSS_TIM1_load_background( g_FrequencyPCLK0 / baud_rate );
}

void FSK_TX_set_if_freq( uint32_t center_freq, uint32_t separation_freq )
{
	SystemCoreClockUpdate();

	// Calculate direct parameters
	f_low = center_freq - separation_freq/2;
	f_high = center_freq + separation_freq/2;

	delta_phase_high = ((uint64_t)f_high << 32)/g_FrequencyFPGA;
	delta_phase_low = ((uint64_t)f_low << 32)/g_FrequencyFPGA;
}

uint8_t FSK_TX_is_busy( )
{
	return fsk_tx_busy;
}

void FSK_TX_transmit( uint32_t payload_ )
{
	if ( !FSK_TX_is_busy() )
	{
		fsk_tx_busy = 1;

		// Set up transmission parameters
		payload = payload_;
		//tx_bit_ctr = 8;
		tx_bit_ctr = payload;

		// Start the timer
		MSS_TIM1_clear_irq();
		MSS_TIM1_enable_irq();
		MSS_TIM1_start();
	}
}

void Timer1_IRQHandler( void )
{
	// Toggle LED1

	//if ( tx_bit_ctr > 0 )
	if ( 1 )
	{
		// Enable AFE
		//MSS_GPIO_set_outputs( MSS_GPIO_get_outputs() & ~MSS_GPIO_0_MASK );
		FSK_TX_set_amplitude(300);


		// Time-critical section
		//if ( payload & 0x01 )
		if ( tx_bit_ctr & 0x04 )
		{
			//MSS_GPIO_set_outputs( MSS_GPIO_get_outputs() | MSS_GPIO_1_MASK );
			// Load delta-phase register with value corresponding to f_high
			FSK_TX->DPHA = delta_phase_high;
		}
		else
		{
			//MSS_GPIO_set_outputs( MSS_GPIO_get_outputs() & ~MSS_GPIO_1_MASK );
			// Load delta-phase register with value corresponding to f_low
			FSK_TX->DPHA = delta_phase_low;
		}

		// Housekeeping section
		payload >>= 1;
		tx_bit_ctr--;
	}
	else
	{
		// Disable AFE
		//MSS_GPIO_set_outputs( MSS_GPIO_get_outputs() | MSS_GPIO_0_MASK );
		FSK_TX_set_amplitude(0);
		MSS_TIM1_disable_irq();
		MSS_TIM1_stop();
		//MSS_GPIO_set_outputs( MSS_GPIO_get_outputs() & ~MSS_GPIO_1_MASK );
		fsk_tx_busy = 0;
	}

	// Clear current interrupt
	MSS_TIM1_clear_irq();
}


void FSK_TX_set_frequency( uint32_t freq )
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
