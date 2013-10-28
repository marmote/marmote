/*
 * cmd_def.c
 *
 *  Created on: Aug 2, 2012
 *      Author: sszilvasi
 */

#include "cmd_def.h"

uint32_t g_rate = 500; // ms

CMD_Type CMD_List[] =
{
	{"help", 	CmdHelp},
	{"led",  	CmdLed},
//	{"sleep",	 CmdSleep},
//	{"clk",  	CmdClock},
//	{"afe",  	CmdAfe},
//	{"iqo",  	CmdIQOffset},

//	{"fpga", CmdFpga},

	// MAX2830
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

	// OFDM
	{"stat", 	CmdStatus},
	{"gain",  	CmdGain},
	{"ptrn",  	CmdPattern},
	{"mask",  	CmdMask},
	{"s", 		CmdStart},
	{"p", 		CmdStartPeriodic},
	{"sw",	 	CmdSweep},
	{"mlen", 	CmdMeasLength},
	{"e", 		CmdStop},
	{"tx", 		CmdTx}, // set tx role for the measurement
	{"rate",  	CmdRate},

	{NULL,   	NULL}
};


void sprint_binary(char* buf, uint32_t val);


uint32_t CmdHelp(uint32_t argc, char** argv)
{
	CMD_Type* cmdListItr = CMD_List;
	char buf[64];

	sprintf(buf, "\nMarmotE Teton Rev %c Node %d - %s\r\n", node_rev, node_id, fw_name);
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

	sprintf(buf, "\r\nMarmotE Teton Rev %c Node %d", node_rev, node_id);
	Yellowstone_print(buf);
	sprintf(buf, "\r\nTx:           %s", (TX_CTRL->CTRL & 0x4) ? "RUNNING" : "STOPPED");
	Yellowstone_print(buf);
	sprintf(buf, " %s", (TIMER_BITBAND->TIM1ENABLE) ? "PERIODIC" : "");
	Yellowstone_print(buf);

	sprintf(buf, "\r\nFrequency:    %.2f MHz", (double)Max2830_get_frequency()/1e6);
	Yellowstone_print(buf);
	sprintf(buf, "\r\nTx gain:      %.1f dB", Max2830_get_tx_gain());
	Yellowstone_print(buf);
	sprintf(buf, "\r\nTx bandwidth: %.2f MHz", (int)Max2830_get_tx_bandwidth()/1000.0);
	Yellowstone_print(buf);

	sprintf(buf, "\r\nGAIN:         %d", (1 << (int)TX_CTRL->GAIN));
	Yellowstone_print(buf);
	sprintf(buf, "\r\nPTRN:         0x%08X | ", (int)TX_CTRL->PTRN);
	Yellowstone_print(buf);
	sprint_binary(buf, TX_CTRL->PTRN);
	Yellowstone_print(buf);
	sprintf(buf, "\r\nMASK:         0x%08X | ", (int)TX_CTRL->MASK);
	Yellowstone_print(buf);
	sprint_binary(buf, TX_CTRL->MASK);
	Yellowstone_print(buf);
	sprintf(buf, "\r\nRATE:         ");
	Yellowstone_print(buf);
	if (g_rate)
	{
		sprintf(buf, "%u ms", (unsigned)g_rate);
	}
	else
	{
		sprintf(buf, "OFF");
	}
	Yellowstone_print(buf);
	sprintf(buf, "\r\nMLEN:         %u symbols", (unsigned)meas_len);
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
	float bandwidth;
	char buf[128];

	if (argc == 1)
	{
		sprintf(buf, "\r\nTx bandwidth: %.2f MHz", (int)Max2830_get_tx_bandwidth()/1000.0);
		Yellowstone_print(buf);
		return 0;
	}

	if (argc == 2)
	{
		bandwidth = atof(*(argv+1));
		if (bandwidth || !strcmp(*(argv+1), "0"))
		{
			Max2830_set_tx_bandwidth(bandwidth*1000);

			sprintf(buf, "\r\nTx bandwidth: %.2f MHz", (int)Max2830_get_tx_bandwidth()/1000.0);
			Yellowstone_print(buf);
			return 0;
		}
	}

	// Send help message
	Yellowstone_print("\r\nUsage: txbw [<bandwidth in MHz>]");
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
			sprintf(buf, "\r\n0x%03u", Max2830_get_rssi_value());
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


/********************************************************************
 *                         OFDM related
 ********************************************************************/

void sprint_binary(char* buf, uint32_t val)
{
	int j = 0;
	int i = 0;
	for (i = 0; i < 32; i++)
	{
		buf[j++] = (val >> (31-i)) & 1 ? '1' : '0';
		if ((i+1) % 4 == 0)
		{
			buf[j++] = ' ';
		}
	}
	buf[j] = '\0';
}

uint32_t count_bits32(uint32_t val)
{
	uint32_t cnt;

	cnt = (val & 0x55555555) + ((val >> 1) & 0x55555555);
	cnt = (cnt & 0x33333333) + ((cnt >> 2) & 0x33333333);
	cnt = (cnt & 0x0F0F0F0F) + ((cnt >> 4) & 0x0F0F0F0F);
	cnt = (cnt & 0x00FF00FF) + ((cnt >> 8) & 0x00FF00FF);
	cnt = (cnt & 0x0000FFFF) + ((cnt >> 16) & 0x0000FFFF);

	return cnt;
}

uint32_t CmdGain(uint32_t argc, char** argv)
{
	uint32_t gain;
	char buf[128];

	if (argc == 1)
	{
		gain = (1 << (uint32_t)TX_CTRL->GAIN);
		sprintf(buf, "\r\nGAIN: %d", (int)gain);
		Yellowstone_print(buf);

		return 0;
	}

	if (argc == 2)
	{
		gain = atoi(*(argv+1));
		if (gain || !strcmp(*(argv+1), "0"))
		{
			switch (gain)
			{
				case 1:
					TX_CTRL->GAIN = 0;
					break;
				case 2:
					TX_CTRL->GAIN = 1;
					break;
				case 4:
					TX_CTRL->GAIN = 2;
					break;
				case 8:
					TX_CTRL->GAIN = 3;
					break;
				default:
					sprintf(buf, "\r\nWARNING: Invalid GAIN value, ignoring request");
					Yellowstone_print(buf);
					return 1;
			}

			sprintf(buf, "\r\nGAIN: %d", (1 << (int)TX_CTRL->GAIN));
			Yellowstone_print(buf);

			return 0;
		}
	}

	Yellowstone_print("\r\nUsage: gain [1 | 2 | 4 | 8]");
	return 1;
}

uint32_t CmdPattern(uint32_t argc, char** argv)
{
	uint32_t ptrn;
	char buf[128];
	char *eptr = NULL;

	if (argc == 1)
	{
		ptrn = (uint32_t)TX_CTRL->PTRN;
		sprintf(buf, "\r\nPTRN: 0x%08X | ", (int)ptrn);
		Yellowstone_print(buf);

		sprint_binary(buf, ptrn);
		Yellowstone_print(buf);

		return 0;
	}

	if (argc == 2)
	{
		ptrn = strtoul(*(argv+1), &eptr, 16);
		if (eptr != *(argv+1))
		{
//			if (ptrn > 0xFFFFul)
//			{
//				sprintf(buf, "\r\nWARNING: Pattern 0x%0X is larger than 0xFFFF, ignoring request", (int)ptrn);
//				Yellowstone_print(buf);
//				sprintf(buf, "\r\nPTRN: 0x%04X", (int)TX_CTRL->PTRN);
//				Yellowstone_print(buf);
//				return 1;
//			}

			TX_CTRL->PTRN = ptrn;

			sprintf(buf, "\r\nPTRN: 0x%08X | ", (int)TX_CTRL->PTRN);
			Yellowstone_print(buf);

			sprint_binary(buf, ptrn);
			Yellowstone_print(buf);

			return 0;
		}
	}

	Yellowstone_print("\r\nUsage: ptrn [<16-bit hex value>]");
	return 1;
}


uint32_t CmdMask(uint32_t argc, char** argv)
{
	uint32_t mask;
	char buf[128];
	char *eptr = NULL;

	if (argc == 1)
	{
		mask = (int)TX_CTRL->MASK;
		sprintf(buf, "\r\nMASK: 0x%08X | ", (unsigned int)mask);
		Yellowstone_print(buf);

		sprint_binary(buf, mask);
		Yellowstone_print(buf);

		return 0;
	}

	if (argc == 2)
	{
		if (strcmp(*(argv+1),"even") == 0)
		{
			TX_CTRL->MASK = MASK_EVEN & MASK_DEFAULT;
			mask = TX_CTRL->MASK;
			sprintf(buf, "\r\nMASK: 0x%08X | ", (int)mask);
			Yellowstone_print(buf);
			sprint_binary(buf, mask);
			Yellowstone_print(buf);
			return 0;
		}

		if (strcmp(*(argv+1),"odd") == 0)
		{
			TX_CTRL->MASK = MASK_ODD & MASK_DEFAULT;
			mask = TX_CTRL->MASK;
			sprintf(buf, "\r\nMASK: 0x%08X | ", (int)mask);
			Yellowstone_print(buf);
			sprint_binary(buf, mask);
			Yellowstone_print(buf);
			return 0;
		}


		mask = strtoul(*(argv+1), &eptr, 16);
		if (eptr != *(argv+1))
		{
			TX_CTRL->MASK = mask;

			sprintf(buf, "\r\nMASK: 0x%08X | ", (int)TX_CTRL->MASK);
			Yellowstone_print(buf);

			sprint_binary(buf, mask);
			Yellowstone_print(buf);

			return 0;
		}
	}

	Yellowstone_print("\r\nUsage: mask [<16-bit value> | 'even' | 'odd']");
	return 1;
}


uint32_t CmdTx(uint32_t argc, char** argv)
{
	uint32_t role;

	if (argc == 2)
	{
		role = atoi(*(argv+1));
		switch (role)
		{
			case 1:
				// tx1 - even frequencies (continuous)
				TX_CTRL->CTRL &= ~0x4u;
				MSS_TIM1_stop();
				MSS_TIM1_disable_irq();

				TX_CTRL->MASK = MASK_EVEN & MASK_DEFAULT;

				set_mode(RADIO_TX_MODE);
				TX_CTRL->CTRL |= 0x4u | 0x2u;

				MSS_GPIO_set_output(MSS_GPIO_LED1, 1);
				Yellowstone_print("\r\nTx1 STARTED (even & continuous)");
				return 0;

			case 2:
				// tx2 - odd frequencies (periodic)
				if (g_rate == 0)
				{
					Yellowstone_print("\r\nRate is not set");
					return 1;
				}
				TX_CTRL->CTRL &= ~0x4u;
				MSS_TIM1_stop();
				MSS_TIM1_disable_irq();

				TX_CTRL->MASK = MASK_ODD & MASK_DEFAULT;

				set_mode(RADIO_TX_MODE);
				TX_CTRL->CTRL |= 0x4u | 0x2u;

				MSS_TIM1_load_background(g_rate * MILLI_SEC_DIV);
				MSS_TIM1_load_immediate(g_rate * MILLI_SEC_DIV); // reset timer
				MSS_TIM1_enable_irq();
				MSS_TIM1_start();

				MSS_GPIO_set_output(MSS_GPIO_LED1, 1);

				Yellowstone_print("\r\nTx2 STARTED (odd & periodic)");
				return 0;
		}
	}

	Yellowstone_print("\r\nUsage: tx [1 | 2]");
	return 1;
}

uint32_t CmdStart(uint32_t argc, char** argv)
{
	uint32_t meas_len;
	char buf[128];

	if (argc == 1)
	{
		set_mode(RADIO_TX_MODE);
		TX_CTRL->CTRL |= 0x4u | 0x2u;

		MSS_TIM1_stop();
		MSS_TIM1_disable_irq();

		MSS_GPIO_set_output(MSS_GPIO_LED1, 1);
		Yellowstone_print("\r\nTx STARTED");
		return 0;
	}

	if (argc == 2)
	{
		meas_len = atoi(*(argv+1));
		if (meas_len)
		{
			TX_CTRL->MLEN = meas_len;
		}

		set_mode(RADIO_TX_MODE);
		TX_CTRL->CTRL |= 0x2u;

		sprintf(buf, "\r\nMLEN: %u (%u)", (unsigned)TX_CTRL->MLEN, (unsigned)TX_CTRL->MLEN+1);
		Yellowstone_print(buf);

		return 0;
	}

	Yellowstone_print("\r\nUsage: start");
	return 1;
}

uint32_t CmdStartPeriodic(uint32_t argc, char** argv)
{
	if (argc == 1)
	{
		if (g_rate == 0)
		{
			Yellowstone_print("\r\nRate unset");
			return 1;
		}

		set_mode(RADIO_TX_MODE);
		TX_CTRL->CTRL |= 0x4u | 0x2u;

		MSS_TIM1_load_background(g_rate * MILLI_SEC_DIV);
		MSS_TIM1_load_immediate(g_rate * MILLI_SEC_DIV); // reset timer
		MSS_TIM1_enable_irq();
		MSS_TIM1_start();

		MSS_GPIO_set_output(MSS_GPIO_LED1, 1);

		Yellowstone_print("\r\nTx STARTED PERIODIC");
		return 0;
	}

	Yellowstone_print("\r\nUsage: start");
	return 1;
}

uint32_t CmdSweep(uint32_t argc, char** argv)
{
	char buf[64];
	uint32_t nfft = 32;
	uint32_t role;
	uint32_t mask;

	if (argc == 1)
	{
		mask = (int)TX_CTRL->MASK;
		sprintf(buf, "\r\nMASK: 0x%08X | ", (unsigned int)mask);
		Yellowstone_print(buf);

		sprint_binary(buf, mask);
		Yellowstone_print(buf);

		sprintf(buf, "\r\nRATE: ");
		Yellowstone_print(buf);
		if (g_rate)
		{
			sprintf(buf, "%u ms", (unsigned)g_rate);
		}
		else
		{
			sprintf(buf, "OFF");
		}
		Yellowstone_print(buf);
		return 0;
	}

	if (argc == 2)
	{
		role = atoi(*(argv+1));
		switch (role)
		{
			case 1:
				// Short periods
				g_rate = nfft*meas_len/20000ul;
				TX_CTRL->CTRL &= ~0x4u;
				MSS_TIM1_stop();
				MSS_TIM1_disable_irq();
				TX_CTRL->MASK = MASK_EVEN & MASK_DEFAULT; // FIXME
				break;

			case 2:
				// Long periods
				TX_CTRL->CTRL &= ~0x4u;
				MSS_TIM1_stop();
				MSS_TIM1_disable_irq();

				g_rate = (sizeof(fc_vec)/sizeof(uint32_t)+2)
						*nfft*meas_len/20000ul;
				TX_CTRL->MASK = MASK_ODD & MASK_DEFAULT; // FIXME
				break;

			default:
				Yellowstone_print("\r\nInvalid argument");
				return 1;
		}

		set_mode(RADIO_TX_MODE);
		TX_CTRL->CTRL |= 0x4u | 0x2u;

		MSS_TIM1_load_background(g_rate * MILLI_SEC_DIV);
		MSS_TIM1_load_immediate(g_rate * MILLI_SEC_DIV); // reset timer
		MSS_TIM1_enable_irq();
		MSS_TIM1_start();

		MSS_GPIO_set_output(MSS_GPIO_LED1, 1);

		Yellowstone_print("\r\nSweep STARTED");
		return 0;
	}

	Yellowstone_print("\r\nUsage: sweep [1 | 2]");
	return 1;
}

uint32_t CmdMeasLength(uint32_t argc, char** argv)
{
	char buf[128];
	uint32_t mlen;

	if (argc == 1)
	{
		sprintf(buf, "\r\nMLEN: %d", (int)meas_len);
		Yellowstone_print(buf);
		return 0;
	}

	if (argc == 2)
	{
		mlen = atoi(*(argv+1));
		if (mlen || !strcmp(*(argv+1), "0"))
		{
			if (mlen >= 1024 && mlen <= 32768)
			{
				meas_len = mlen;
			}
			sprintf(buf, "\r\nMLEN: %d", (int)meas_len);
			Yellowstone_print(buf);
			return 0;
		}
	}

	Yellowstone_print("\r\nUsage: mlen [1024..32768]");
	return 1;
}

uint32_t CmdStop(uint32_t argc, char** argv)
{
	if (argc == 1)
	{
		TX_CTRL->CTRL &= ~0x4u;
		set_mode(RADIO_STANDBY_MODE);

		MSS_TIM1_stop();
		MSS_TIM1_disable_irq();
		MSS_GPIO_set_output(MSS_GPIO_LED1, 0);

		Yellowstone_print("\r\nTx STOPPED");
		return 0;
	}

	Yellowstone_print("\r\nUsage: stop");
	return 1;
}

uint32_t CmdRate(uint32_t argc, char** argv)
{
	uint32_t rate;
	char buf[128];

	if (argc == 1)
	{
		sprintf(buf, "\r\nRATE: ");
		Yellowstone_print(buf);
		if (g_rate)
		{
			sprintf(buf, "%u ms", (unsigned)g_rate);
		}
		else
		{
			sprintf(buf, "OFF");
		}
		Yellowstone_print(buf);

		return 0;
	}

	if (argc == 2)
	{
		rate = atoi(*(argv+1));
		if (!strcmp(*(argv+1), "0"))
		{
			g_rate = 0;

			TX_CTRL->CTRL &= ~0x4u;
			MSS_TIM1_stop();
			MSS_TIM1_disable_irq();
			MSS_GPIO_set_output(MSS_GPIO_LED1, 0);
		}
		else if (rate)
		{
			g_rate = rate;
			MSS_TIM1_load_background(g_rate * MILLI_SEC_DIV);
		}

		sprintf(buf, "\r\nRATE: ");
		Yellowstone_print(buf);
		if (g_rate)
		{
			sprintf(buf, "%u ms", (unsigned)g_rate);
		}
		else
		{
			sprintf(buf, "OFF");
		}
		Yellowstone_print(buf);

		return 0;
	}

	Yellowstone_print("\r\nUsage: rate [0 | <interval in ms>]");
	return 1;
}
