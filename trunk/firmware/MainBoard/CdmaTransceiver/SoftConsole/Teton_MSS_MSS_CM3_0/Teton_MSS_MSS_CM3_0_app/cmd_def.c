/*
 * cmd_def.c
 *
 *  Created on: Aug 2, 2012
 *      Author: sszilvasi
 */

#include "cmd_def.h"

CMD_Type CMD_List[] =
{
	{"help", 	CmdHelp},
	{"status", 	CmdStatus},
	{"led",  	CmdLed},
//	{"sleep",	 CmdSleep},
	{"clk",  	CmdClock},
	{"afe",  	CmdAfe},
	{"iqo",  	CmdIQOffset},

//	{"fpga", CmdFpga},

	{"reg",  	CmdReg},
	{"freq", 	CmdFreq},
	{"txg", 	CmdTxGain},
	{"txbw",  	CmdTxBw},
	{"rxg", 	CmdRxGain},
	//{"rxlna", 	CmdRxLna},
	//{"rxvga", 	CmdRxVga},
	{"rxbw",   	CmdRxBw},
	{"rxhp",   	CmdRxHp},
	{"mode",   	CmdMode},
	{"rssi",   	CmdRssi},
	{"pa",     	CmdPa},
	//{"cal",  CmdCal},

	{"iq",   	CmdIQ},
	{"mux1",  	CmdMux1},
	{"mux2",  	CmdMux2},

	{"modmux",  CmdModMux},

	// CDMA measurement
	{"pktlen",  CmdPacketLength},
	{"pktrate", CmdPacketRate},
	{"sf", 		CmdSpreadFactor},
	{"prelen", 	CmdPreambleLen},
	{NULL,   	NULL}
};


uint32_t CmdHelp(uint32_t argc, char** argv)
{
	CMD_Type* cmdListItr = CMD_List;
	char buf[64];

//	sprintf(buf, "\nMarmotE Rev %c Node %d\r\n", (char)((MM_BOARD->REV & 0xFF) + 'A' - 1), (int)(MM_BOARD->ID & 0xFF));
	sprintf(buf, "\nMarmotE Rev %c Node %d\r\n", node_rev, node_id);
	Yellowstone_print(buf);

	Yellowstone_print("\nAvailable commands:\n");

	Yellowstone_print("\n  env");
	while (cmdListItr->CmdString)
	{
		Yellowstone_write("\n  ", 3);
		Yellowstone_print((const char*)cmdListItr->CmdString);
		cmdListItr++;
	}
	Yellowstone_write("\n", 1);

	return 0;
}

uint32_t CmdStatus(uint32_t argc, char** argv)
{
	char buf[64];

	sprintf(buf, "\nMarmotE Main Board (Teton) Rev %c Node %d\r\n", node_rev, node_id);
	Yellowstone_print(buf);

	sprintf(buf, "MASK:    0x%X\r\nSF:      %d\r\n", (int)TX_CTRL->MASK, (int)TX_CTRL->SF);
	Yellowstone_print(buf);
	sprintf(buf, "PRELEN:  %u\r\nPKTLEN:  %d\r\n", (int)TX_CTRL->PRE_LEN, (int)TX_CTRL->PAY_LEN);
	Yellowstone_print(buf);
	sprintf(buf, "PKTRATE: %7.3f\r\n", packet_rate);
	Yellowstone_print(buf);

	return 0;
}

uint32_t CmdLed(uint32_t argc, char** argv)
{
	if (argc == 2)
	{
		if (!strcmp(*(argv+1), "on"))
		{
			MSS_GPIO_set_output( MSS_GPIO_LED1, 1 );
			return 0;
		}

		if (!strcmp(*(argv+1), "off"))
		{
			MSS_GPIO_set_output( MSS_GPIO_LED1, 0 );
			return 0;
		}
	}

	// Send help message
  	Yellowstone_print("\nUsage: led [on | off]");
	return 1;
}

/*
uint32_t CmdSleep(uint32_t argc, char** argv)
{
	uint32_t timeout;
	uint32_t current_time;
    uint64_t match;

	char buf[128];

	if (argc == 2)
	{
		timeout = atoi(*(argv+1));
		if (timeout || !strcmp(*(argv+1), "0"))
		{
			current_time = MSS_RTC_get_seconds_count();

			sprintf(buf, "\nGoing to sleep at %02d:%02d:%02d for %d s", (int)current_time/3600%24, (int)current_time/60%60, (int)current_time%60, (int)timeout);
			Yellowstone_print(buf);

			MSS_RTC_disable_irq();

			match = MSS_RTC_get_rtc_count();
			match = match + ((uint64_t)timeout << 8);
			MSS_RTC_set_rtc_match( match );
			MSS_RTC_enable_irq();

	        // Clear RTC match event
	        //SYSREG->CLR_MSS_SR |= CLR_MSS_SR_RTC_MATCH_IRQ;
			//SYSREG->SOFT_RST_CR |= SYSREG_FPGA_SOFTRESET_MASK;

			SwitchMssClock(LP_OSC_CLK_SRC);
			// Wait for interrupt
			__ASM volatile ("WFI");
			SwitchMssClock(MAIN_OSC_CLK_SRC);

			//SYSREG->SOFT_RST_CR &= ~SYSREG_FPGA_SOFTRESET_MASK;

			current_time = MSS_RTC_get_seconds_count();
			sprintf(buf, "\nWoke up at %02d:%02d:%02d", (int)current_time/3600%24, (int)current_time/60%60, (int)current_time%60);
			Yellowstone_print(buf);

			return 0;
		}
	}

	// Send help message
	Yellowstone_print("\r\nUsage: sleep <timeout in seconds>");
	return 1;
}
*/

#define STATASEL_MASK   (1 << 0)
#define RXASEL_MASK 	(1 << 1)
#define DYNASEL_MASK 	(1 << 2)
#define BYPASSA_MASK	(1 << 6)
#define STATCSEL_MASK	(1 << 16)
#define RXCSEL_MASK 	(1 << 17)
#define DYNCSEL_MASK	(1 << 18)
#define BYPASSC_MASK	(1 << 22)


uint32_t CmdClock(uint32_t argc, char** argv)
{
	CLK_SRC_Type clock;

	char buf[128];

	if (argc == 1)
	{
		clock = GetMssClock();

		Yellowstone_print("\nCLKSRC\t");
		switch ( clock )
		{
			case RC_OSC_CLK_SRC:
				Yellowstone_print("RC OSC");
				break;
			case LP_OSC_CLK_SRC:
				Yellowstone_print("LP OSC");
				break;
			case MAIN_OSC_CLK_SRC :
				Yellowstone_print("MAIN OSC");
				break;
			default:
				Yellowstone_print("?");
				break;
		}

		/*
		pll_cr = SYSREG->MSS_CCC_PLL_CR;

		n = (pll_cr & 0x7F) + 1;
		m = ((pll_cr >> 7) & 0x7F) + 1;
		*/

		SystemCoreClockUpdate();

		sprintf(buf, "\nSYSCLK\t%d Hz", (int)SystemCoreClock);
		Yellowstone_print(buf);

		sprintf(buf, "\nPCLK0\t%d Hz", (int)g_FrequencyPCLK0);
		Yellowstone_print(buf);

		sprintf(buf, "\nPCLK1\t%d Hz", (int)g_FrequencyPCLK1);
		Yellowstone_print(buf);

		sprintf(buf, "\nACE\t%d Hz", (int)g_FrequencyACE);
		Yellowstone_print(buf);

		sprintf(buf, "\nFPGA\t%d Hz", (int)g_FrequencyFPGA);
		Yellowstone_print(buf);

		return 0;
	}

	// Send help message
  	Yellowstone_print("\nUsage: clk");
	return 1;
}

/*
uint32_t CmdFpga(uint32_t argc, char** argv)
{
	if (argc == 1)
	{
		Yellowstone_print("\nFPGA fabric is ");
		if ( MSS_GPIO_get_outputs() & MSS_GPIO_FPGA_ENABLE_MASK )
		{
			Yellowstone_print("ON");
		}
		else
		{
			Yellowstone_print("OFF");
		}
		return 0;
	}

	if (argc == 2)
	{
		if (!strcmp(*(argv+1), "on"))
		{
			MSS_GPIO_set_output( MSS_GPIO_FPGA_ENABLE, 1 );
			return 0;
		}

		if (!strcmp(*(argv+1), "off"))
		{
			MSS_GPIO_set_output( MSS_GPIO_FPGA_ENABLE, 0 );
			return 0;
		}
	}

	// Send help message
  	Yellowstone_print("\nUsage: fpga [on | off]");
	return 1;
}
*/



uint32_t CmdAfe(uint32_t argc, char** argv)
{
	if (argc == 1)
	{
		Yellowstone_print("\nAFE is ");
		if ( MSS_GPIO_get_outputs() & MSS_GPIO_AFE1_ENABLE_MASK )
		{
			Yellowstone_print("ON");
		}
		else
		{
			Yellowstone_print("OFF");
		}
		return 0;
	}

	if (argc == 2)
	{
		if (!strcmp(*(argv+1), "on"))
		{
			MSS_GPIO_set_output( MSS_GPIO_AFE1_ENABLE, 1 );
			return 0;
		}

		if (!strcmp(*(argv+1), "off"))
		{
			MSS_GPIO_set_output( MSS_GPIO_AFE1_ENABLE, 0 );
			return 0;
		}
	}

	// Send help message
	Yellowstone_print("\nUsage: afe [on | off ]");
	return 1;
}

uint32_t CmdIQOffset(uint32_t argc, char** argv)
{
	char buf[128];
	int32_t i, q;

	if (argc == 1)
	{
		sprintf(buf, "\r\nI : %d\r\nQ : %d",
				Max19706_get_dac_i_offset(MAX19706_AFE1),
				Max19706_get_dac_q_offset(MAX19706_AFE1) );
		Yellowstone_print(buf);
		return 0;
	}

	if (argc == 3)
	{
		i = atoi(*(argv+1));
		q = atoi(*(argv+2));
		if ((i || !strcmp(*(argv+1), "0")) && (q || !strcmp(*(argv+2), "0")))
		{
			Max19706_set_dac_i_offset(MAX19706_AFE1, i);
			Max19706_set_dac_q_offset(MAX19706_AFE1, q);

			// Readback
			sprintf(buf, "\r\nI : %d\r\nQ : %d",
							Max19706_get_dac_i_offset(MAX19706_AFE1),
							Max19706_get_dac_q_offset(MAX19706_AFE1) );
					Yellowstone_print(buf);
			return 0;
		}
	}

	// Send help message
	Yellowstone_print("\r\nUsage: iqo [<i offset in LSB> <q offset in LSB>]");
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
	float freq;
	char buf[128];

	if (argc == 1)
	{
		sprintf(buf, "\r\nFrequency: %12.6f MHz", (double)Max2830_get_frequency()/1e6);
		Yellowstone_print(buf);
		return 0;
	}

	if (argc == 2)
	{
		freq = atof(*(argv+1));
		if (freq || !strcmp(*(argv+1), "0"))
		{
			Max2830_set_frequency((uint32_t) (freq*1e6));

			sprintf(buf, "\r\nFrequency: %12.6f MHz", Max2830_get_frequency()/1e6);
			Yellowstone_print(buf);
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
		if (gain || !strcmp(*(argv+1), "0"))
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


uint32_t CmdRxHp(uint32_t argc, char** argv)
{
	uint32_t rxhp;
	uint32_t reg;
	char buf[128];

	if (argc == 1)
	{
		reg = Max2830_read_register(0x7);
		reg = (reg >> 12) & 0x3; // R7[13:12]
		// Note: RXHP is assumed to be 0
		switch (reg)
		{
			case 0:
				rxhp = 100;
				break;
			case 2:
				rxhp = 30000;
				break;
			default:
				rxhp = 4000;
		}
		sprintf(buf, "\r\nRx LPF cut-off: %5u Hz", (unsigned int)rxhp);
		Yellowstone_print(buf);
		return 0;
	}

	if (argc == 2)
	{
		rxhp = atoi(*(argv+1));
		if (rxhp || !strcmp(*(argv+1), "0"))
		{
			reg = Max2830_read_register(0x7);
			reg &= ~(0x3 << 12); // Zero R[13:12]
			switch (rxhp)
			{
				case 100:
					break;
				case 4000:
					reg |= 0x1 << 12;
					break;
				case 30000:
					reg |= 0x2 << 12;
					break;
			}

			if (reg != 0)
			{
				Max2830_write_register(7, reg);
			}

			// Readcheck
			reg = Max2830_read_register(0x7);
			reg = (reg >> 12) & 0x3; // R7[13:12]
			// Note: RXHP is assumed to be 0
			switch (reg)
			{
				case 0:
					rxhp = 100;
					break;
				case 2:
					rxhp = 30000;
					break;
				default:
					rxhp = 4000;
			}
			sprintf(buf, "\r\nRx LPF cut-off: %5u Hz", (unsigned int)rxhp);
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
			MSS_GPIO_set_output( MSS_GPIO_AFE1_MODE, AFE_RX_MODE );
			Max2830_set_mode( MAX2830_RX_MODE );
			return 0;
		}

		if (!strcmp(*(argv+1), "tx"))
		{
			// !
			Max2830_set_mode( MAX2830_TX_MODE );
			MSS_GPIO_set_output( MSS_GPIO_AFE1_MODE, AFE_TX_MODE );
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
			sprintf(buf, "\r\n0x%03u", Max2830_get_rssi_value()); // TODO: print voltage level too
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


uint32_t CmdIQ(uint32_t argc, char** argv)
{
	char buf[128];
	uint32_t i, q;

	if (argc == 1)
	{
		sprintf(buf, "\r\nI : %d\t0x%03x\r\nQ : %d\t0x%03x",
				(int)BB_CTRL->TX_I, (unsigned int)BB_CTRL->TX_I,
				(int)BB_CTRL->TX_Q, (unsigned int)BB_CTRL->TX_Q);
		Yellowstone_print(buf);
		return 0;
	}

	if (argc == 3)
	{
		i = atoi(*(argv+1));
		q = atoi(*(argv+2));
		if ((i || !strcmp(*(argv+1), "0")) && (q || !strcmp(*(argv+2), "0")))
		{
			BB_CTRL->MUX1 = 3;
			BB_CTRL->MUX2 = 3;

			BB_CTRL->TX_I = i & 0x3FF;
			BB_CTRL->TX_Q = q & 0x3FF;

			// Readback
			sprintf(buf, "\r\nI : %d\t0x%03x\r\nQ : %d\t0x%03x",
					(int16_t)BB_CTRL->TX_I, (unsigned int)(BB_CTRL->TX_I & 0x3FF),
					(int16_t)BB_CTRL->TX_Q, (unsigned int)(BB_CTRL->TX_Q & 0x3FF));
			Yellowstone_print(buf);
			return 0;
		}
	}

	// Send help message
	Yellowstone_print("\r\nUsage: iq [I Q]");
	return 1;
}

uint32_t CmdMux1(uint32_t argc, char** argv)
{
	char buf[128];
	uint32_t mux;

	if (argc == 1)
	{
		mux = BB_CTRL->MUX1 & 0x3;
		sprintf( buf, "\r\nMUX1 path: ");
		Yellowstone_print(buf);
		switch (mux)
		{
			case 0x0 :
				sprintf( buf, "OFF");
				break;
			case 0x1 :
				sprintf( buf, "RX" );
				break;
			case 0x2 :
				sprintf( buf, "TX" );
				break;
			case 0x3 :
				sprintf( buf, "I/Q REG" );
				break;
		}
		Yellowstone_print(buf);
		sprintf(buf, "(%d)", (unsigned)BB_CTRL->MUX1);
		Yellowstone_print(buf);
		return 0;
	}

	if (argc == 2)
	{
		mux = atoi(*(argv+1)) & 0x3;
		if ((mux || !strcmp(*(argv+1), "0")))
		{
			BB_CTRL->MUX1 = mux;

			// Readback
			mux = BB_CTRL->MUX1;
			sprintf( buf, "\r\nMUX1 path: ");
			Yellowstone_print(buf);
			switch (mux)
			{
				case MUX_PATH_OFF :
					sprintf( buf, "OFF");
					break;
				case MUX_PATH_RX :
					sprintf( buf, "RX" );
					break;
				case MUX_PATH_TX :
					sprintf( buf, "TX" );
					break;
				case MUX_PATH_IQ_REG :
					sprintf( buf, "I/Q REG" );
					break;
			}
			Yellowstone_print(buf);
			sprintf(buf, "(%d)", (unsigned)BB_CTRL->MUX1);
			Yellowstone_print(buf);
			return 0;
		}
	}

	// Send help message
	Yellowstone_print("\r\nUsage: mux1 [<index>] (0: OFF, 1: RX, 2: TX, 3: I/Q REG)");
	return 1;
}

uint32_t CmdMux2(uint32_t argc, char** argv)
{
	char buf[128];
	uint32_t mux;

	if (argc == 1)
	{
		mux = BB_CTRL->MUX2 & 0x3;
		sprintf( buf, "\r\nMUX2 path: ");
		Yellowstone_print(buf);
		switch (mux)
		{
			case 0x0 :
				sprintf( buf, "OFF");
				break;
			case 0x1 :
				sprintf( buf, "RX" );
				break;
			case 0x2 :
				sprintf( buf, "TX" );
				break;
			case 0x3 :
				sprintf( buf, "I/Q REG" );
				break;
		}
		Yellowstone_print(buf);
		sprintf(buf, "(%d)", (unsigned)BB_CTRL->MUX2);
		Yellowstone_print(buf);
		return 0;
	}

	if (argc == 2)
	{
		mux = atoi(*(argv+1)) & 0x3;
		if ((mux || !strcmp(*(argv+1), "0")))
		{
			BB_CTRL->MUX2 = mux;

			// Readback
			mux = BB_CTRL->MUX2;
			sprintf( buf, "\r\nMUX2 path: ");
			Yellowstone_print(buf);
			switch (mux)
			{
				case MUX_PATH_OFF :
					sprintf( buf, "OFF");
					break;
				case MUX_PATH_RX :
					sprintf( buf, "RX" );
					break;
				case MUX_PATH_TX :
					sprintf( buf, "TX" );
					break;
				case MUX_PATH_IQ_REG :
					sprintf( buf, "I/Q REG" );
					break;
			}
			Yellowstone_print(buf);
			sprintf(buf, "(%d)", (unsigned)BB_CTRL->MUX2);
			Yellowstone_print(buf);
			return 0;
		}
	}

	// Send help message
	Yellowstone_print("\r\nUsage: mux2 [<index>] (0: OFF, 1: RX, 2: TX, 3: I/Q REG)");
	return 1;
}


uint32_t CmdModMux(uint32_t argc, char** argv)
{
	char buf[128];
	uint32_t mux;

	if (argc == 1)
	{
		mux = TX_CTRL->MOD_MUX & 0x3;
		sprintf( buf, "\r\nActive path: ");
		Yellowstone_print(buf);
		switch (mux)
		{
			case 0x0 :
				sprintf( buf, "PACKET");
				break;
			case 0x1 :
				sprintf( buf, "CONST 0" );
				break;
			case 0x2 :
				sprintf( buf, "CONST 1" );
				break;
			case 0x3 :
				sprintf( buf, "RANDOM" );
				break;
		}
		Yellowstone_print(buf);
		sprintf(buf, "\r\nMOD MUX: %u", (unsigned)TX_CTRL->MOD_MUX);
		Yellowstone_print(buf);
		return 0;
	}

	if (argc == 2)
	{
		mux = atoi(*(argv+1)) & 0x3;
		if ((mux || !strcmp(*(argv+1), "0")))
		{
			TX_CTRL->MOD_MUX = mux;

			// Readback
			mux = TX_CTRL->MOD_MUX & 0x3;
			sprintf( buf, "\r\nActive path: ");
			Yellowstone_print(buf);
			switch (mux)
			{
				case 0x0 :
					sprintf( buf, "PACKET");
					break;
				case 0x1 :
					sprintf( buf, "CONST 0" );
					break;
				case 0x2 :
					sprintf( buf, "CONST 1" );
					break;
				case 0x3 :
					sprintf( buf, "RANDOM" );
					break;
			}
			Yellowstone_print(buf);
			sprintf(buf, "\r\nMOD MUX: %u", (unsigned)TX_CTRL->MOD_MUX);
			Yellowstone_print(buf);
			return 0;
		}
	}

	// Send help message
	Yellowstone_print("\r\nUsage: modmux [<index>]");
	return 1;
}



/********************************************************************
 *                         CDMA measurement
 ********************************************************************/

uint32_t CmdPacketLength(uint32_t argc, char** argv)
{
	uint32_t pkt_len;
	char buf[64];

	if (argc == 1)
	{
		sprintf(buf, "\r\nPacket length: %3u", (int)(TX_CTRL->PAY_LEN & 0xFF));
		Yellowstone_print(buf);
		return 0;
	}

	if (argc == 2)
	{
		pkt_len = atoi(*(argv+1));
		if (pkt_len || !strcmp(*(argv+1), "0"))
		{
			TX_CTRL->PAY_LEN = pkt_len & 0xFF;

			sprintf(buf, "\r\nPacket length: %3u", (int)(TX_CTRL->PAY_LEN & 0xFF));
			Yellowstone_print(buf);
			return 0;
		}
	}

	Yellowstone_print("\r\nUsage: pktlen [<new packet length>]");
	return 1;
}

uint32_t CmdPacketRate(uint32_t argc, char** argv)
{
	float pkt_rate;
	char buf[64];

	if (argc == 1)
	{
		sprintf(buf, "\r\nPacket rate: %7.3f", packet_rate);
		Yellowstone_print(buf);
		return 0;
	}

	if (argc == 2)
	{
		pkt_rate = atof(*(argv+1));
		if (pkt_rate || !strcmp(*(argv+1), "0"))
		{
			packet_rate = pkt_rate;

			sprintf(buf, "\r\nPacket rate: %7.3f", packet_rate);
			Yellowstone_print(buf);
			return 0;
		}
	}

	Yellowstone_print("\r\nUsage: pktrate [<packets per sec>] - NOT IMPLEMENTED YET");
	return 1;
}

uint32_t CmdSpreadFactor(uint32_t argc, char** argv)
{
	uint32_t spread_factor;
	char buf[64];

	if (argc == 1)
	{
		sprintf(buf, "\r\nSpread factor: %3u", (int)(TX_CTRL->SF & 0xFF));
		Yellowstone_print(buf);
		return 0;
	}

	if (argc == 2)
	{
		spread_factor = atoi(*(argv+1));
		if (spread_factor || !strcmp(*(argv+1), "0"))
		{
			TX_CTRL->SF = spread_factor & 0xFF;

			sprintf(buf, "\r\nSpread factor: %3u", (int)(TX_CTRL->SF & 0xFF));
			Yellowstone_print(buf);
			return 0;
		}
	}

	Yellowstone_print("\r\nUsage: sf [<new spread factor>]");
	return 1;
}

uint32_t CmdPreambleLen(uint32_t argc, char** argv)
{
	uint32_t preamble_length;
	char buf[64];

	if (argc == 1)
	{
		sprintf(buf, "\r\nPreamble length: %3u", (int)(TX_CTRL->PRE_LEN & 0xFF));
		Yellowstone_print(buf);
		return 0;
	}

	if (argc == 2)
	{
		preamble_length = atoi(*(argv+1));
		if (preamble_length || !strcmp(*(argv+1), "0"))
		{
			TX_CTRL->PRE_LEN = preamble_length & 0xFF;

			sprintf(buf, "\r\nPreamble length: %3u", (int)(TX_CTRL->PRE_LEN & 0xFF));
			Yellowstone_print(buf);
			return 0;
		}
	}

	Yellowstone_print("\r\nUsage: prelen [<new preamble_length>]");
	return 1;
}
