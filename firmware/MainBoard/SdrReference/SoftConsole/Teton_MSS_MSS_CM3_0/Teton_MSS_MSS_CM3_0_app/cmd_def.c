/*
 * cmd_def.c
 *
 *  Created on: Aug 2, 2012
 *      Author: sszilvasi
 */

#include "cmd_def.h"


CMD_Type CMD_List[] =
{
	{"help", CmdHelp},
	{"led",  CmdLed},
	{"afe",  CmdAfe},

	{"reg",  	CmdReg},
	{"freq", 	CmdFreq},
	{"txg", 	CmdTxGain},
	{"txbw",  	CmdTxBw},
	{"rxg", 	CmdRxGain},
	//{"rxlna", 	CmdRxLna},
	//{"rxvga", 	CmdRxVga},
	{"rxbw",   	CmdRxBw},
	{"mode",   	CmdMode},
	{"rssi",   	CmdRssi},
	{"pa",     	CmdPa},
	//{"cal",  CmdCal},
	{NULL,   NULL}
};


uint32_t CmdHelp(uint32_t argc, char** argv)
{
	CMD_Type* cmdListItr = CMD_List;

	Yellowstone_print("\nAvailable commands:\n");

	while (cmdListItr->CmdString)
	{
		Yellowstone_write("\n  ", 3);
		Yellowstone_print((const char*)cmdListItr->CmdString);
		cmdListItr++;
	}
	Yellowstone_write("\n", 1);

	return 0;
}

uint32_t CmdLed(uint32_t argc, char** argv)
{
	if (argc == 2)
	{
		if (!strcmp(*(argv+1), "on"))
		{
			MSS_GPIO_set_output( MSS_GPIO_0, 1 );
			return 0;
		}

		if (!strcmp(*(argv+1), "off"))
		{
			MSS_GPIO_set_output( MSS_GPIO_0, 0 );
			return 0;
		}
	}

	// Send help message
  	Yellowstone_print("\nUsage: t led [on | off]");
	return 1;
}


uint32_t CmdAfe(uint32_t argc, char** argv)
{
	if (argc == 2)
	{
		if (!strcmp(*(argv+1), "on"))
		{
			MSS_GPIO_set_outputs( MSS_GPIO_get_outputs() & ~MSS_GPIO_AFE1_SHDN_MASK );
			return 0;
		}

		if (!strcmp(*(argv+1), "off"))
		{
			MSS_GPIO_set_outputs( MSS_GPIO_get_outputs() | MSS_GPIO_AFE1_SHDN_MASK );
			return 0;
		}
	}

	// Send help message
	Yellowstone_print("\nUsage: t afe [on | off ]");
	return 1;
}

/*
 * MAX2830 related commands
 */
uint32_t CmdReg(uint32_t argc, char** argv)
{
	uint32_t addr;
	uint32_t data;
	int8_t i;

	char buf[128];

	if (argc == 2)
	{
		addr = atoi(*(argv+1));
		if (addr || !strcmp(*(argv+1), "0"))
		{
			data = Max2830_read_register(addr);
			sprintf(buf, "\r\nAddr: %2d (0x%02x) Data: %3d (0x%04x 0b'",
					(unsigned int)addr,	(unsigned int)addr,
					(unsigned int)data,	(unsigned int)data);
			// Binary format
			for ( i = 13; i >= 0; i-- )
			{
				strcat(buf, ((data >> i) & 0x0001) ? "1" : "0");
				if ( i % 4 == 0 && i != 0)
				{
					strcat(buf, " ");
				}
			}
			strcat(buf, ") (R)");
			Yellowstone_print( buf );
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
				Yellowstone_print(buf);
				return 0;
			}
		}
	}

	Yellowstone_print("\nUsage: reg <address> [<data>]");
	return 1;
}


uint32_t CmdFreq(uint32_t argc, char** argv)
{
	uint32_t freq;
	char buf[128];

	if (argc == 1)
	{
		sprintf(buf, "\r\nFrequency: %12.6f MHz", (double)Max2830_get_frequency()/1e6);
		Yellowstone_print(buf);

		/*
		sprintf(buf, "\r\nFrequency: %u Hz", Max2830_get_frequency());
		Yellowstone_print(buf);
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
			Yellowstone_print(buf);
			sprintf(buf, "\r\nFrequency: %12.6f MHz", (float)Max2830_get_frequency()/1e6);
			*/

			Max2830_set_frequency((uint32_t) (freq*1e6));

			//sprintf(buf, "\r\nFrequency: %12.6f MHz", Max2830_get_frequency()/1e6);
			sprintf(buf, "\r\nFrequency: %u Hz", (unsigned int)Max2830_get_frequency());
			Yellowstone_print(buf);

			/*
			sprintf(buf, "\r\nFrequency: %u Hz (R)", Max2830_get_frequency());
			Yellowstone_print(buf);
			*/

			return 0;
		}
	}

	// Send help message
	Yellowstone_print("\nUsage: freq [<frequency value in MHz>]");
	return 1;
}


uint32_t CmdTxGain(uint32_t argc, char** argv)
{
	float gain;
	char buf[128];

	if (argc == 1)
	{
		sprintf(buf, "\r\nTx gain: %4.1f dB", Max2830_get_tx_gain());
		Yellowstone_print(buf);
		return 0;
	}

	if (argc == 2)
	{
		gain = atof(*(argv+1));
		if (gain || !strcmp(*(argv+1), "0")) // FIXME: test how this condition is handled
		{
			Max2830_set_tx_gain(gain);

			sprintf(buf, "\r\nTx gain: %4.1f dB", Max2830_get_tx_gain());
			Yellowstone_print(buf);
			return 0;
		}
	}

	// Send help message
	Yellowstone_print("\r\nUsage: txg [<gain in dB>]");
	return 1;
}

uint32_t CmdRxLna(uint32_t argc, char** argv)
{
	float gain;
	char buf[128];

	if (argc == 1)
	{
		//sprintf(buf, "\r\nRx gain: %4.1f dB", Max2830_get_rx_gain());
		sprintf(buf, "\r\nRx LNA: %4.1f dB", Max2830_get_rx_lna_gain());
		Yellowstone_print(buf);
		return 0;
	}

	if (argc == 2)
	{
		gain = atof(*(argv+1));
		if (gain || !strcmp(*(argv+1), "0"))
		{
			Max2830_set_rx_lna_gain(gain);

			sprintf(buf, "\r\nRx LNA: %4.1f dB", Max2830_get_rx_lna_gain());
			Yellowstone_print(buf);
			return 0;
		}
	}

	// Send help message
	Yellowstone_print("\r\nUsage: rxlna [<gain in dB>]");
	return 1;
}

uint32_t CmdRxVga(uint32_t argc, char** argv)
{
	float gain;
	char buf[128];

	if (argc == 1)
	{
		//sprintf(buf, "\r\nRx gain: %4.1f dB", Max2830_get_rx_gain());
		sprintf(buf, "\r\nRx VGA: %4.1f dB", Max2830_get_rx_vga_gain());
		Yellowstone_print(buf);
		return 0;
	}

	if (argc == 2)
	{
		gain = atof(*(argv+1));
		if (gain || !strcmp(*(argv+1), "0"))
		{
			Max2830_set_rx_vga_gain(gain);

			sprintf(buf, "\r\nRx VGA: %4.1f dB", Max2830_get_rx_vga_gain());
			Yellowstone_print(buf);
			return 0;
		}
	}

	// Send help message
	Yellowstone_print("\r\nUsage: rxvga [<gain in dB>]");
	return 1;
}

// TODO: make this command rxgain <total gain> | (<lna gain> <vga gain>)
uint32_t CmdRxGain(uint32_t argc, char** argv)
{
	float gain;
	char buf[128];

	if (argc == 1)
	{
		//sprintf(buf, "\r\nRx gain: %4.1f dB", Max2830_get_rx_gain());
		sprintf(buf, "\r\nRx gain: %4.1f dB\r\nLNA: %4.1f dB\r\nVGA: %4.1f dB",
				Max2830_get_rx_gain(),
				Max2830_get_rx_lna_gain(),
				Max2830_get_rx_vga_gain());
		Yellowstone_print(buf);
		return 0;
	}

	if (argc == 2)
	{
		gain = atof(*(argv+1));
		if (gain || !strcmp(*(argv+1), "0"))
		{
			Max2830_set_rx_gain(gain);

			sprintf(buf, "\r\nRx gain: %4.1f dB", Max2830_get_rx_gain());
			Yellowstone_print(buf);
			return 0;
		}
	}

	if (argc == 3)
	{
		float lna_gain = atof(*(argv+1));
		float vga_gain = atof(*(argv+2));

		if ( (lna_gain || !strcmp(*(argv+1), "0")) &&
			 (vga_gain || !strcmp(*(argv+2), "0")) )
		{
			Max2830_set_rx_lna_gain(lna_gain);
			Max2830_set_rx_vga_gain(vga_gain);

			sprintf(buf, "\r\nRx gain: %4.1f dB\r\nLNA: %4.1f dB\r\nVGA: %4.1f dB",
				Max2830_get_rx_gain(),
				Max2830_get_rx_lna_gain(),
				Max2830_get_rx_vga_gain());
			Yellowstone_print(buf);
			return 0;
		}
	}

	// Send help message
	Yellowstone_print("\r\nUsage: rxg [<total gain> | (<LNA gain> <VGA gain>)]");
	return 1;
}

uint32_t CmdTxBw(uint32_t argc, char** argv)
{
	uint32_t bandwidth;
	char buf[128];

	if (argc == 1)
	{
		sprintf(buf, "\r\nTx bandwidth: %5u kHz", (int)Max2830_get_tx_bandwidth());
		Yellowstone_print(buf);
		return 0;
	}

	if (argc == 2)
	{
		bandwidth = atoi(*(argv+1));
		if (bandwidth || !strcmp(*(argv+1), "0"))
		{
			Max2830_set_tx_bandwidth(bandwidth);

			sprintf(buf, "\r\nTx bandwidth: %5u kHz", (int)Max2830_get_tx_bandwidth());
			Yellowstone_print(buf);
			return 0;
		}
	}

	// Send help message
	Yellowstone_print("\r\nUsage: txbw [<bandwidth in kHz>]");
	return 1;
}


uint32_t CmdRxBw(uint32_t argc, char** argv)
{
	uint32_t bandwidth;
	char buf[128];

	if (argc == 1)
	{
		sprintf(buf, "\r\nRx bandwidth: %5u kHz", (int)Max2830_get_rx_bandwidth());
		Yellowstone_print(buf);
		return 0;
	}

	if (argc == 2)
	{
		bandwidth = atoi(*(argv+1));
		if (bandwidth || !strcmp(*(argv+1), "0"))
		{
			Max2830_set_rx_bandwidth(bandwidth);

			sprintf(buf, "\r\nBandwidth: %5u kHz", (int)Max2830_get_rx_bandwidth());
			Yellowstone_print(buf);
			return 0;
		}
	}

	// Send help message
	Yellowstone_print("\r\nUsage: rxbw [<bandwidth in kHz>]");
	return 1;
}

uint32_t CmdMode(uint32_t argc, char** argv)
{
	char buf[32];

	if (argc == 1)
	{
		switch (Max2830_get_mode())
		{
			case MAX2830_SHUTDOWN_MODE :
				sprintf(buf, "\r\nshutdown");
				break;
			case MAX2830_STANDBY_MODE :
				sprintf(buf, "\r\nidle (standby)");
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

		Yellowstone_print(buf);
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
	Yellowstone_print("\r\nUsage: mode [shdn | idle | rx | tx | rxc | txc]");
	return 1;
}


uint32_t CmdRssi(uint32_t argc, char** argv)
{
	char buf[32];

	if (argc == 1)
	{
		switch (Max2830_get_rssi_config())
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

		Yellowstone_print(buf);

		uint8_t i;
		for ( i = 0; i < 20; i++ )
		{
			sprintf(buf, "\r\n0x%02u", Max2830_get_rssi_value() >> 4);
			Yellowstone_print(buf);
		}

		return 0;
	}

	if (argc == 2)
	{
		if (!strcmp(*(argv+1), "rssi"))
		{
			Max2830_set_rssi_config( MAX2830_ANALOG_MEAS_RSSI );
			return 0;
		}

		if (!strcmp(*(argv+1), "temp"))
		{
			Max2830_set_rssi_config( MAX2830_ANALOG_MEAS_TEMP );
			return 0;
		}

		if (!strcmp(*(argv+1), "txpow"))
		{
			Max2830_set_rssi_config( MAX2830_ANALOG_MEAS_TXPOW );
			return 0;
		}
	}

	// Send help message
	Yellowstone_print("\r\nUsage: mode [rssi | temp | txpow]");
	return 1;
}


uint32_t CmdPa(uint32_t argc, char** argv)
{
	uint32_t delay;
	char buf[64];

	if (argc == 1)
	{
		sprintf(buf, "\r\nPA delay: %5u us", (int)Max2830_get_pa_delay());
		Yellowstone_print(buf);
		return 0;
	}

	if (argc == 2)
	{
		delay = atoi(*(argv+1));
		if (delay || !strcmp(*(argv+1), "0"))
		{
			Max2830_set_pa_delay(delay);

			sprintf(buf, "\r\nPA delay: %5u us", (int)Max2830_get_pa_delay());
			Yellowstone_print(buf);
			return 0;
		}
	}

	// Send help message
	Yellowstone_print("\r\nUsage: pa [<delay in us>]");
	return 1;
}
