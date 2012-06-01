/*
 * cmd_defs.c
 *
 *  Created on: May 31, 2012
 *      Author: sszilvasi
 */

#include "cmd_defs.h"


extern cmd_t cmd_list[] =
{
	"help", CmdHelp,
	"led",  CmdLed,
	"afe",  CmdAfe,
	"fsk",  CmdFsk,
	"tx",   CmdTx,
	"ampl", CmdAmpl,
	"iq",   CmdIQ,
	"path", CmdPath,
	"if",   CmdIfFreq,
	"reg",  CmdReg,
	"freq", CmdFreq,
	"gain", CmdGain,
	"lpf",  CmdLpf,
	"mode", CmdMode,
	"rssi", CmdRssi,
	"pa",   CmdPa,
	"cal",  CmdCal,
	NULL,   NULL
};

uint32_t CmdHelp(uint32_t argc, char** argv)
{
	char buf[128];
	cmd_t* cmdListItr = cmd_list;

	SystemCoreClockUpdate();
	while ( !MSS_UART_tx_complete(&g_mss_uart0) );
	sprintf(buf, "\r\nClocks:\r\nMSS 0:\t%4u Hz\r\nMSS 1:\t%4u Hz\r\nFPGA:\t%4u Hz\r\n",
			g_FrequencyPCLK0, g_FrequencyPCLK1, g_FrequencyFPGA );
	MSS_UART_polled_tx_string( &g_mss_uart0, buf );

	while ( !MSS_UART_tx_complete(&g_mss_uart0) );
	MSS_UART_polled_tx_string( &g_mss_uart0, "\r\nAvailable commands:\r\n" );

	while (cmdListItr->CmdString)
	{
		MSS_UART_polled_tx_string( &g_mss_uart0, "\r\n  " );
		MSS_UART_polled_tx_string( &g_mss_uart0, cmdListItr->CmdString );
		cmdListItr++;
	}
	MSS_UART_polled_tx_string( &g_mss_uart0, "\r\n" );

	return 0;
}

uint32_t CmdLed(uint32_t argc, char** argv)
{
	while ( !MSS_UART_tx_complete(&g_mss_uart0) );

	if (argc == 2) {
		if (!strcmp(*(argv+1), "on"))
		{
			MSS_GPIO_set_outputs( MSS_GPIO_get_outputs() | MSS_GPIO_LED1_MASK );
			MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)"\r\nLED is ON");
			return 0;
		}

		if (!strcmp(*(argv+1), "off"))
		{
			MSS_GPIO_set_outputs( MSS_GPIO_get_outputs() & ~MSS_GPIO_LED1_MASK );
			MSS_UART_polled_tx_string( &g_mss_uart0, "\r\nLED is OFF");
			return 0;
		}
	}

	// Send help message
	MSS_UART_polled_tx_string( &g_mss_uart0, "\r\nUsage: led [on | off]");
	return 1;
}

uint32_t CmdAfe(uint32_t argc, char** argv)
{
	while ( !MSS_UART_tx_complete(&g_mss_uart0) );

	if (argc == 2)
	{
		if (!strcmp(*(argv+1), "on"))
		{
			MSS_GPIO_set_outputs( MSS_GPIO_get_outputs() & ~MSS_GPIO_AFE1_SHDN_MASK );
			MSS_UART_polled_tx_string( &g_mss_uart0, "\r\nAFE is ON");
			return 0;
		}

		if (!strcmp(*(argv+1), "off"))
		{
			MSS_GPIO_set_outputs( MSS_GPIO_get_outputs() | MSS_GPIO_AFE1_SHDN_MASK );
			MSS_UART_polled_tx_string( &g_mss_uart0, "\r\nAFE is OFF");
			return 0;
		}

	}

	// Send help message
	MSS_UART_polled_tx_string( &g_mss_uart0, "\r\nUsage: afe [ on | off ]");
	return 1;
}


uint32_t CmdFsk(uint32_t argc, char** argv)
{
	uint32_t dphase;
	//uint32_t payload;
	char parse_buf[128];

	while ( !MSS_UART_tx_complete(&g_mss_uart0) );

	if (argc == 2)
	{
		if (!strcmp(*(argv+1), "on"))
		{
			dphase = FSK_TX->CTRL;
			FSK_TX->CTRL = 1;
			dphase = FSK_TX->CTRL;

			if (FSK_TX->CTRL & 1)
			{
				MSS_UART_polled_tx_string( &g_mss_uart0, "\r\nfsk is ON");
			}
			else
			{
				MSS_UART_polled_tx_string( &g_mss_uart0, "\r\nError: fsk is OFF");
			}
			return 0;
		}

		if (!strcmp(*(argv+1), "off"))
		{
			FSK_TX->CTRL = 0;

			if (FSK_TX->CTRL == 0)
			{
				MSS_UART_polled_tx_string( &g_mss_uart0, "\r\nfsk is OFF");
			}
			else
			{
				MSS_UART_polled_tx_string( &g_mss_uart0, "\r\nError: fsk is ON");
			}
			return 0;
		}

		dphase = atoi(*(argv+1));
		if (dphase || !strcmp(*(argv+1), "0")) // TODO: use errno
		{
			FSK_TX->DPHA = dphase;

			sprintf(parse_buf, "\r\nParsed: %d (0x%08x)", (int)dphase, (uint32_t)dphase);
			MSS_UART_polled_tx_string( &g_mss_uart0, parse_buf );
			return 0;
		}
	}

	while ( !MSS_UART_tx_complete(&g_mss_uart0) );

	sprintf( parse_buf, "\r\nStatus: fsk is %s\r\ndphase = %8d (0x%08x)\r\nampl = %8d (0x%08x)", FSK_TX->CTRL ? "ON" : "OFF",
			(uint32_t)FSK_TX->DPHA, (uint32_t)FSK_TX->DPHA,
			(uint32_t)FSK_TX->AMPL, (uint32_t)FSK_TX->AMPL );

	// Send status
	MSS_UART_polled_tx_string( &g_mss_uart0, parse_buf );
	while ( !MSS_UART_tx_complete(&g_mss_uart0) );

	// Send help message
	MSS_UART_polled_tx_string( &g_mss_uart0, "\r\nUsage: fsk [on | off | <dphase>]");
	return 1;
}



uint32_t CmdTx(uint32_t argc, char** argv)
{
	uint32_t payload;
	uint8_t parse_buf[128];

	while ( !MSS_UART_tx_complete(&g_mss_uart0) );

	if (argc == 2)
	{
		payload = atoi(*(argv+1));
		if (payload || !strcmp(*(argv+1), "0")) // TODO: use errno
		{
			sprintf((char*)parse_buf, "\r\nParsed: %u (0x%08x)", (unsigned int)payload, (unsigned int)payload);
			MSS_UART_polled_tx_string( &g_mss_uart0, parse_buf );

			FSK_TX_transmit(payload);

			//FSK_TX->DPHA = ((uint64_t)1000 << 32)/g_FrequencyFPGA;;
			return 0;
		}
	}

	while ( !MSS_UART_tx_complete(&g_mss_uart0) );

	// Send help message
	MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)"\r\nUsage: tx <payload>");
	return 1;
}





uint32_t CmdAmpl(uint32_t argc, char** argv)
{
	uint32_t ampl;
	char buf[128];

	if (argc == 1)
	{
		sprintf(buf, "\r\nAmplitude: %d mVpp", FSK_TX_get_amplitude());
		MSS_UART_polled_tx_string( &g_mss_uart0, buf );
		return 0;
	}

	while ( !MSS_UART_tx_complete(&g_mss_uart0) );

	if (argc == 2)
	{
		ampl = atoi(*(argv+1));
		if (ampl || !strcmp(*(argv+1), "0")) // TODO: use errno instead
		{
			FSK_TX_set_amplitude(ampl);

			//sprintf(buf, "\r\nParsed: %8d", (int)ampl);
			sprintf(buf, "\r\nAmplitude: %8d mVpp", (int)FSK_TX_get_amplitude());
			MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)buf );
			return 0;
		}
	}

	while ( !MSS_UART_tx_complete(&g_mss_uart0) );

	// Send status
	sprintf( buf, "\r\nampl = %8d mVpp", FSK_TX_get_amplitude() );
	MSS_UART_polled_tx_string( &g_mss_uart0, buf );
	while ( !MSS_UART_tx_complete(&g_mss_uart0) );

	// Send help message
	MSS_UART_polled_tx_string( &g_mss_uart0, "\r\nUsage: ampl [<amplitude value in mV>]");
	return 1;
}




uint32_t CmdPath(uint32_t argc, char** argv)
{
	char buf[128];
	uint32_t path;

	while ( !MSS_UART_tx_complete(&g_mss_uart0) );

	if (argc == 1)
	{
		sprintf(buf, "\r\nActive path: %s", FSK_TX->MUX ? "CONST" : "FSK");
		MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)buf );
		return 0;
	}


	if (argc == 2)
	{
		//FSK_TX->MUX = (uint32_t)1;
		//return 0;

		path = atoi(*(argv+1));
		if (path == 0)
		{
			FSK_TX->MUX = 0;
			sprintf(buf, "\r\nActive path: FSK");
			while ( !MSS_UART_tx_complete(&g_mss_uart0) );
			MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)buf );
			return 0;
		}
		else if (path == 1)
		{
			FSK_TX->MUX = 1;
			sprintf(buf, "\r\nActive path: CONST");
			while ( !MSS_UART_tx_complete(&g_mss_uart0) );
			MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)buf );
			return 0;
		}
		else if (path == 2)
		{
			FSK_TX->MUX = 2;
			sprintf(buf, "\r\nActive path: NOISE");
			while ( !MSS_UART_tx_complete(&g_mss_uart0) );
			MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)buf );
			return 0;
		}
	}

	// Send status
	while ( !MSS_UART_tx_complete(&g_mss_uart0) );
	sprintf( buf, "\r\nActive path: %s", FSK_TX->MUX ? "CONST" : "FSK");
	MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)buf );

	// Send help message
	while ( !MSS_UART_tx_complete(&g_mss_uart0) );
	MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)"\r\nUsage: path [ 0 | 1 ]\t0 : FSK\t1 : CONST");

	return 1;
}

uint32_t CmdIQ(uint32_t argc, char** argv)
{
	char buf[128];
	uint32_t i, q;

	while ( !MSS_UART_tx_complete(&g_mss_uart0) );


	if (argc == 1)
	{
		sprintf(buf, "\r\nI : %d\t0x%03x\r\nQ : %d\t0x%03x",
				(int)FSK_TX->I, (unsigned int)FSK_TX->I,
				(int)FSK_TX->Q, (unsigned int)FSK_TX->Q);
		MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)buf );
		return 0;
	}

	while ( !MSS_UART_tx_complete(&g_mss_uart0) );

	if (argc == 3)
	{
		i = atoi(*(argv+1));
		q = atoi(*(argv+2));
		if ((i || !strcmp(*(argv+1), "0")) && (q || !strcmp(*(argv+2), "0")))
		{

			//!
			//FSK_TX->MUX = (uint32_t)1;

			FSK_TX->I = i;
			FSK_TX->Q = q;

			// Readback
			sprintf(buf, "\r\nI : %d\t0x%03x\r\nQ : %d\t0x%03x",					(int)FSK_TX->I, (unsigned int)FSK_TX->I,
					(int)FSK_TX->Q, (unsigned int)FSK_TX->Q);
			MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)buf );
			return 0;
		}
	}

	while ( !MSS_UART_tx_complete(&g_mss_uart0) );

	// Send status
	sprintf( buf, "\r\nActive path: %s", FSK_TX->MUX ? "CONST" : "FSK");
	MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)buf );
	while ( !MSS_UART_tx_complete(&g_mss_uart0) );

	// Send help message
	MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)"\r\nUsage: path [0 | 1]\t where 0 : FSK, 1 : CONST");
	return 1;
}

uint32_t CmdIfFreq(uint32_t argc, char** argv)
{
	char buf[128];
	uint32_t center_freq, separation_freq;

	while ( !MSS_UART_tx_complete(&g_mss_uart0) );


	if (argc == 1)
	{
		sprintf(buf, "\r\nLow : %d\tHigh : %d",	delta_phase_low, delta_phase_high);
		MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)buf );
		return 0;
	}

	while ( !MSS_UART_tx_complete(&g_mss_uart0) );

	if (argc == 3)
	{
		center_freq = atoi(*(argv+1));
		separation_freq = atoi(*(argv+2));
		if ((center_freq || !strcmp(*(argv+1), "0")) && (separation_freq || !strcmp(*(argv+2), "0")))
		{
			FSK_TX_set_if_freq(center_freq, separation_freq);

			// Readback
			sprintf(buf, "\r\nLow : %d\tHigh : %d",	delta_phase_low, delta_phase_high);
			MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)buf );
			return 0;
		}
	}

	while ( !MSS_UART_tx_complete(&g_mss_uart0) );

	// Send help message
	MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)"\r\nUsage: iffreq <center freq> <separation freq>");
	return 1;
}



uint32_t CmdReg(uint32_t argc, char** argv)
{
	uint32_t addr;
	uint32_t data;

	char buf[128];

	while ( !MSS_UART_tx_complete(&g_mss_uart0) );

	if (argc == 2)
	{
		addr = atoi(*(argv+1));
		if (addr || !strcmp(*(argv+1), "0"))
		{
			data = Max2830_read_register(addr);
			sprintf(buf, "\r\nAddr: %2d (0x%02x) Data: %3d (0x%04x) (R)",
					(unsigned int)addr,	(unsigned int)addr,
					(unsigned int)data,	(unsigned int)data);
			MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)buf );
			return 0;
		}
	}

	if (argc == 3)
	{
		addr = atoi(*(argv+1));
		if (addr || !strcmp(*(argv+1), "0"))
		{
			data = atoi(*(argv+2));
			if (data || !strcmp(*(argv+2), "0"))
			{
				Max2830_write_register(addr, data);
				sprintf(buf, "\r\nAddr: %2d (0x%02x) Data: %3d (0x%04x) (W)",
						(unsigned int)addr,	(unsigned int)addr,
						(unsigned int)data,	(unsigned int)data);
				MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)buf );
				return 0;
			}
		}
	}

	while ( !MSS_UART_tx_complete(&g_mss_uart0) );

	// Send help message
	MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)"\r\nUsage: reg <address> [<data>]");
	return 1;
}


uint32_t CmdFreq(uint32_t argc, char** argv)
{
	uint32_t freq;
	char buf[128];

	while ( !MSS_UART_tx_complete(&g_mss_uart0) );

	if (argc == 1)
	{
		sprintf(buf, "\r\nFrequency: %12.6f MHz", (double)Max2830_get_frequency()/1e6);
		MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)buf );

		/*
		while ( !MSS_UART_tx_complete(&g_mss_uart0) );
		sprintf(buf, "\r\nFrequency: %u Hz", Max2830_get_frequency());
		MSS_UART_polled_tx_string( &g_mss_uart0, buf );
		*/

		return 0;
	}

	if (argc == 2)
	{
		freq = atoi(*(argv+1));
		if (freq || !strcmp(*(argv+1), "0"))
		{

			/*
			sprintf(buf, "\r\nFrequency: %u Hz (passing)", (uint32_t) (freq*1e6));
			MSS_UART_polled_tx_string( &g_mss_uart0, buf );
			sprintf(buf, "\r\nFrequency: %12.6f MHz", (float)Max2830_get_frequency()/1e6);
			*/

			Max2830_set_frequency((uint32_t) (freq*1e6));

			//sprintf(buf, "\r\nFrequency: %12.6f MHz", Max2830_get_frequency()/1e6);
			sprintf(buf, "\r\nFrequency: %u Hz", Max2830_get_frequency());
			MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)buf );

			/*
			while ( !MSS_UART_tx_complete(&g_mss_uart0) );
			sprintf(buf, "\r\nFrequency: %u Hz (R)", Max2830_get_frequency());
			MSS_UART_polled_tx_string( &g_mss_uart0, buf );
			*/

			return 0;
		}
	}

	while ( !MSS_UART_tx_complete(&g_mss_uart0) );

	// Send help message
	MSS_UART_polled_tx_string( &g_mss_uart0, "\r\nUsage: freq [<frequency value in MHz>]");
	return 1;
}


uint32_t CmdGain(uint32_t argc, char** argv)
{
	float gain;
	char buf[128];

	while ( !MSS_UART_tx_complete(&g_mss_uart0) );

	if (argc == 1)
	{
		sprintf(buf, "\r\nTx gain: %4.1f dB", Max2830_get_tx_gain());
		MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)buf );
		return 0;
	}

	if (argc == 2)
	{
		gain = atof(*(argv+1));
		if (gain || !strcmp(*(argv+1), "0")) // FIXME: test how this condition is handled
		{
			Max2830_set_tx_gain(gain);

			sprintf(buf, "\r\nTx gain: %4.1f dB", Max2830_get_tx_gain());
			MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)buf );
			return 0;
		}
	}

	while ( !MSS_UART_tx_complete(&g_mss_uart0) );

	// Send help message
	MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)"\r\nUsage: gain [<gain in dB>]");
	return 1;
}


uint32_t CmdLpf(uint32_t argc, char** argv)
{
	uint32_t bandwidth;
	char buf[128];

	while ( !MSS_UART_tx_complete(&g_mss_uart0) );

	if (argc == 1)
	{
		sprintf(buf, "\r\nBandwidth: %5u kHz", (int)Max2830_get_bandwidth());
		MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)buf );
		return 0;
	}

	if (argc == 2)
	{
		bandwidth = atoi(*(argv+1));
		if (bandwidth || !strcmp(*(argv+1), "0"))
		{
			Max2830_set_bandwidth(bandwidth);

			sprintf(buf, "\r\nBandwidth: %5u kHz", (int)Max2830_get_bandwidth());
			MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)buf );
			return 0;
		}
	}

	while ( !MSS_UART_tx_complete(&g_mss_uart0) );

	// Send help message
	MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)"\r\nUsage: lpf [<bandwidth in kHz>]");
	return 1;
}


uint32_t CmdMode(uint32_t argc, char** argv)
{
	char buf[32];
	while ( !MSS_UART_tx_complete(&g_mss_uart0) );

	if (argc == 1)
	{
		switch (Max2830_get_mode())
		{
			case MAX2830_SHUTDOWN_MODE :
				sprintf(buf, "\r\nshutdown");
				break;
			case MAX2830_STANDBY_MODE :
				sprintf(buf, "\r\nstandby");
				break;
			case MAX2830_RX_MODE :
				sprintf(buf, "\r\nrx");
				break;
			case MAX2830_TX_MODE :
				sprintf(buf, "\r\ntx");
				break;
			case MAX2830_RX_CALIBRATION_MODE :
				sprintf(buf, "\r\nrx calibration");
				break;
			case MAX2830_TX_CALIBRATION_MODE :
				sprintf(buf, "\r\ntx calibration");
				break;
			default:
				sprintf(buf, "\r\n?");
		}

		MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)buf);
		return 0;
	}

	if (argc == 2)
	{
		if (!strcmp(*(argv+1), "shdn"))
		{
			Max2830_set_mode( MAX2830_SHUTDOWN_MODE );
			return 0;
		}

		if (!strcmp(*(argv+1), "idle"))
		{
			Max2830_set_mode( MAX2830_STANDBY_MODE );
			return 0;
		}

		if (!strcmp(*(argv+1), "rx"))
		{
			Max2830_set_mode( MAX2830_RX_MODE );
			return 0;
		}

		if (!strcmp(*(argv+1), "tx"))
		{
			Max2830_set_mode( MAX2830_TX_MODE );
			return 0;
		}

		if (!strcmp(*(argv+1), "rxc"))
		{
			Max2830_set_mode( MAX2830_RX_CALIBRATION_MODE );
			return 0;
		}

		if (!strcmp(*(argv+1), "txc"))
		{
			Max2830_set_mode( MAX2830_TX_CALIBRATION_MODE );
			return 0;
		}
	}

	// Send help message
	MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)"\r\nUsage: mode [shdn | idle | rx | tx | rxc | txc ]");
	return 1;
}


uint32_t CmdRssi(uint32_t argc, char** argv)
{
	char buf[32];
	while ( !MSS_UART_tx_complete(&g_mss_uart0) );

	if (argc == 1)
	{
		switch (Max2830_get_rssi_output())
		{
			case MAX2830_ANALOG_MEAS_RSSI :
				sprintf(buf, "\r\nrssi");
				break;
			case MAX2830_ANALOG_MEAS_TEMP :
				sprintf(buf, "\r\ntemp");
				break;
			case MAX2830_ANALOG_MEAS_TXPOW :
				sprintf(buf, "\r\ntxpow");
				break;
			default:
				sprintf(buf, "\r\n?");
		}

		MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)buf);
		return 0;
	}

	if (argc == 2)
	{
		if (!strcmp(*(argv+1), "rssi"))
		{
			Max2830_set_rssi_output( MAX2830_ANALOG_MEAS_RSSI );
			return 0;
		}

		if (!strcmp(*(argv+1), "temp"))
		{
			Max2830_set_rssi_output( MAX2830_ANALOG_MEAS_TEMP );
			return 0;
		}

		if (!strcmp(*(argv+1), "txpow"))
		{
			Max2830_set_rssi_output( MAX2830_ANALOG_MEAS_TXPOW );
			return 0;
		}
	}

	// Send help message
	MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)"\r\nUsage: mode [rssi | temp | txpow ]");
	return 1;
}


uint32_t CmdPa(uint32_t argc, char** argv)
{
	uint32_t delay;
	char buf[64];

	while ( !MSS_UART_tx_complete(&g_mss_uart0) );

	if (argc == 1)
	{
		sprintf(buf, "\r\nPA delay: %5u us", (int)Max2830_get_pa_delay());
		MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)buf );
		return 0;
	}

	if (argc == 2)
	{
		delay = atoi(*(argv+1));
		if (delay || !strcmp(*(argv+1), "0"))
		{
			Max2830_set_pa_delay(delay);

			sprintf(buf, "\r\nPA delay: %5u us", (int)Max2830_get_pa_delay());
			MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)buf );
			return 0;
		}
	}

	while ( !MSS_UART_tx_complete(&g_mss_uart0) );

	// Send help message
	MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)"\r\nUsage: pa [<delay in us>]");
	return 1;
}


uint32_t CmdCal(uint32_t argc, char** argv)
{
	char buf[64];

	while ( !MSS_UART_tx_complete(&g_mss_uart0) );

	if (argc == 1)
	{
		sprintf(buf, "\r\nStarting calibration...");
		MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)buf );

		// Set calibration I/Q signals
		FSK_TX_set_if_freq(10000, 0);

		//


		while ( !MSS_UART_tx_complete(&g_mss_uart0) );
		sprintf(buf, "\r\nDone");
		MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)buf );

		return 0;
	}

	while ( !MSS_UART_tx_complete(&g_mss_uart0) );

	// Send help message
	MSS_UART_polled_tx_string( &g_mss_uart0, (uint8_t*)"\r\nUsage: cal");
	return 1;
}
