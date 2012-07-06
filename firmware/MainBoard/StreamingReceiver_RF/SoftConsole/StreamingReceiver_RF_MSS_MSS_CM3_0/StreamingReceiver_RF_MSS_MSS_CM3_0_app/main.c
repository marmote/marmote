#include "DMA_stuff.h"
#include "RF_IC_stuff.h"


// **************************************************************************
// **************************************************************************
//
// 								Functions
//
//
// **************************************************************************
void command_execution(uint8_t* buffer)
{
	uint32_t				frequency				= *((uint32_t*)				&(buffer[0]));

	float					TX_Attenuation			= *((float*)				&(buffer[4]));

	Max2830_LNA_Att_t		RX_Attenuation_LNA		= (Max2830_LNA_Att_t)		buffer[8];
	uint8_t					RX_Attenuation_VGA_ATT	= 							buffer[9];

	Max2830_RXTX_BW_t		BW                  	= (Max2830_RXTX_BW_t)		buffer[10];

	uint8_t					ENABLE                  =							buffer[11];
	uint8_t					CMOS_OUTPUT             =							buffer[12];
	uint8_t					PULL_UP                 =							buffer[13];

	uint8_t					Ref_Clk_Output_ENABLE   =							buffer[14];
	uint8_t					Ref_Clk_Output_DIVIDE   =							buffer[15];

	Max2830_RX_HPF_t		RX_HPF					= (Max2830_RX_HPF_t)		buffer[16];

	Max2830_Analog_Meas_t	RSSI_Output     		= (Max2830_Analog_Meas_t)	buffer[17];

	Max2830_IQ_Out_CM_t		RX_IQ_Output_CM 		= (Max2830_IQ_Out_CM_t)		buffer[18];

	uint16_t				PA_DELAY				= *((int16_t*) 				&(buffer[19]));

	Max2830_Mode_t			MODE					= (Max2830_Mode_t)			buffer[21];

	Max2830_TX_Cal_Gain_t	TX_CAL_GAIN				= (Max2830_TX_Cal_Gain_t)	buffer[22];

	Max2830_RX_Ant_t 		RX_Ant					= (Max2830_RX_Ant_t)		buffer[23];




	Max2830_Set_Frequency		(frequency);

    Max2830_Set_TX_Attenuation	(TX_Attenuation);

    Max2830_Set_RX_Attenuation	(RX_Attenuation_LNA,
                        		RX_Attenuation_VGA_ATT);

	Max2830_Set_RXTX_LPF		(BW);

	Max2830_Set_Lock_Detector	(ENABLE,
								CMOS_OUTPUT,
                        		PULL_UP);

	Max2830_Set_Ref_Clk_Output	(Ref_Clk_Output_ENABLE,
                        		Ref_Clk_Output_DIVIDE);

	Max2830_Set_RX_HPF			(RX_HPF );

	Max2830_Set_RSSI_Output		(RSSI_Output);

	Max2830_Set_RX_IQ_Output_CM	(RX_IQ_Output_CM);

	Max2830_Set_PA_Delay		(PA_DELAY);

	Max2830_Set_Mode			(MODE );

	Max2830_Set_TX_Cal_Gain		(TX_CAL_GAIN);

	Max2830_Set_RX_Ant			(RX_Ant);
}


#define COMMAND_ID_CONFIG_MSG           0x00


#define CMD_LENGTH			(4+4+14*1+2)  // = 24
#define SEQ_LENGTH			(3/*start sequence*/+1/*frame_type*/) // = 4
#define BUF_LENGTH			2*(CMD_LENGTH+SEQ_LENGTH)  //Must be dividable by CHUNK_LENGTH!!!!!!

		uint8_t	buffer[BUF_LENGTH];
		uint16_t	buffer_size = BUF_LENGTH;

extern	volatile uint8_t*	p_WR;
		volatile uint8_t*	p_RD;


#define COMMAND_WAITING_STATE        0
#define COMMAND_COLLECTING_STATE     1

#define FRAME_SEQ	{0xA1,0xBE,0xAF,0x02}		// A1BEAF  and  02 as message type

void command_parsing()
{
	static uint8_t	seq[SEQ_LENGTH]	= FRAME_SEQ;
    static uint8_t	seq_cnt	= 0;

    static uint8_t	temp[CMD_LENGTH];
    static uint16_t	temp_cnt = 0;

    static char		state = COMMAND_WAITING_STATE;

    while (p_RD != p_WR)
    {
		if (state == COMMAND_WAITING_STATE)
		{
			if (*p_RD == seq[seq_cnt])
				seq_cnt++;
			else
				seq_cnt = (*p_RD == seq[0]) ? 1 : 0;

			if (seq_cnt >= SEQ_LENGTH)
			{
				seq_cnt = 0;
				state = COMMAND_COLLECTING_STATE;
			}
		}
		if (state == COMMAND_COLLECTING_STATE)
		{
			temp[temp_cnt] = *p_RD;

			temp_cnt++;

			if (temp_cnt >= CMD_LENGTH)
			{
				command_execution(temp);

				temp_cnt = 0;
				state = COMMAND_WAITING_STATE;
			}
		}

		p_RD++;

		if (p_RD >= buffer + buffer_size)
			p_RD = buffer;
    }

}



// **************************************************************************
// **************************************************************************
//
// 						Functions for Interrupt Handlers
//
//
// **************************************************************************




// **************************************************************************
// **************************************************************************
//
// 								Init functions
//
//
// **************************************************************************



// **************************************************************************
// **************************************************************************
//
// 									Main
//
//
// **************************************************************************
int main()
{
	init_RF_IC_stuff();

	p_RD = buffer;

	init_DMA_stuff(/*buffer*/);


//	Max2830_Set_Frequency((uint32_t) 2437000000);

//	Max2830_Set_TX_Attenuation(0);


//////////////////////////////////////////////////////
	while( 1 )
	{
		command_parsing();
	}
}
