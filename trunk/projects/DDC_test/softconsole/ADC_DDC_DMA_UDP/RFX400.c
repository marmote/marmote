#include "io_ports.h"
#include "RFX400.h"

#include <stdint.h>
#include "flags.h"

/*
R counter latch
|------|------|------|------|------|------|------|------|
| DB23 | DB22 | DB21 | DB20 | DB19 | DB18 | DB17 | DB16 |
|------|------|------|------|------|------|------|------|
| RSV  | RSV  | BSC2 | BSC1 | TMB  | LDP  | ABP2 | ABP1 |
|------|------|------|------|------|------|------|------|
|  0   |  0   |  1   |  1   |  0   |  1   |  0   |  0   |
|------|------|------|------|------|------|------|------|

|------|------|------|------|------|------|------|------|
| DB15 | DB14 | DB13 | DB12 | DB11 | DB10 | DB9  | DB8  |
|------|------|------|------|------|------|------|------|
| R14  | R13  | R12  | R11  | R10  | R9   | R8   | R7   |
|------|------|------|------|------|------|------|------|
|  ?   |  ?   |  ?   |  ?   |  ?   |  ?   |  ?   |  ?   |
|------|------|------|------|------|------|------|------|

|------|------|------|------|------|------|------|------|
| DB7  | DB6  | DB5  | DB4  | DB3  | DB2  | DB1  | DB0  |
|------|------|------|------|------|------|------|------|
| R6   | R5   | R4   | R3   | R2   | R1   | C2(0)| C1(1)|
|------|------|------|------|------|------|------|------|
|  ?   |  ?   |  ?   |  ?   |  ?   |  ?   |  0   |  1   |
|------|------|------|------|------|------|------|------|
*/
#define R_COUNTER_LATCH_DB23_DB16	0x34
#define R_COUNTER_LATCH_DB1_DB0		0x1


/*
Control latch
|------|------|------|------|------|------|------|------|
| DB23 | DB22 | DB21 | DB20 | DB19 | DB18 | DB17 | DB16 |
|------|------|------|------|------|------|------|------|
| P2   | P1   | PD2  | PD1  | CPI6 | CPI5 | CPI4 | CPI3 |
|------|------|------|------|------|------|------|------|
|  0   |  0   |  0   |  0   |  1   |  1   |  1   |  1   |
|------|------|------|------|------|------|------|------|

|------|------|------|------|------|------|------|------|
| DB15 | DB14 | DB13 | DB12 | DB11 | DB10 | DB9  | DB8  |
|------|------|------|------|------|------|------|------|
| CPI2 | CPI1 | PL2  | PL1  | MTLD | CPG  | CP   | PDP  |
|------|------|------|------|------|------|------|------|
|  1   |  1   |  0   |  0   |  1   |  0   |  0   |  1   |
|------|------|------|------|------|------|------|------|

|------|------|------|------|------|------|------|------|
| DB7  | DB6  | DB5  | DB4  | DB3  | DB2  | DB1  | DB0  |
|------|------|------|------|------|------|------|------|
| M3   | M2   | M1   | CR   | PC2  | PC1  | C2(0)| C1(0)|
|------|------|------|------|------|------|------|------|
|  0   |  0   |  1   |  0   |  0   |  1   |  0   |  0   |
|------|------|------|------|------|------|------|------|
*/
#define CONTROL_LATCH_DB23_DB16	0x0F
#define CONTROL_LATCH_DB15_DB8	0xC9
#define CONTROL_LATCH_DB7_DB0	0x24


/*
N counter latch
|------|------|------|------|------|------|------|------|
| DB23 | DB22 | DB21 | DB20 | DB19 | DB18 | DB17 | DB16 |
|------|------|------|------|------|------|------|------|
|DIVSEL| DIV2 | CPG  | B13  | B12  | B11  | B10  | B9   |
|------|------|------|------|------|------|------|------|
|  0   |  0   |  0   |  ?   |  ?   |  ?   |  ?   |  ?   |
|------|------|------|------|------|------|------|------|

|------|------|------|------|------|------|------|------|
| DB15 | DB14 | DB13 | DB12 | DB11 | DB10 | DB9  | DB8  |
|------|------|------|------|------|------|------|------|
| B8   | B7   | B6   | B5   | B4   | B3   | B2   | B1   |
|------|------|------|------|------|------|------|------|
|  ?   |  ?   |  ?   |  ?   |  ?   |  ?   |  ?   |  ?   |
|------|------|------|------|------|------|------|------|

|------|------|------|------|------|------|------|------|
| DB7  | DB6  | DB5  | DB4  | DB3  | DB2  | DB1  | DB0  |
|------|------|------|------|------|------|------|------|
| RSV  | A5   | A4   | A3   | A2   | A1   | C2(1)| C1(0)|
|------|------|------|------|------|------|------|------|
|  0   |  ?   |  ?   |  ?   |  ?   |  ?   |  1   |  0   |
|------|------|------|------|------|------|------|------|
*/
#define N_COUNTER_LATCH_DB23_DB21	0x0
#define N_COUNTER_LATCH_DB7			0x0
#define N_COUNTER_LATCH_DB1_DB0		0x2


uint32_t R_latch;
uint32_t Control_latch;
uint32_t N_latch;



void RFX400init()
{
	io_ports_init();

	(*((uint32_t*)GPIO_OUTPUT)) =
		GPIO_IO_RX_05
		| GPIO_IO_RX_06
		| GPIO_IO_RX_07
		| GPIO_SEN_RX
//		| GPIO_SCLK
//		| GPIO_IO_TX_05
//		| GPIO_IO_TX_06
//		| GPIO_IO_TX_07
		| GPIO_SEN_TX; // GPIO_IO_RX_02 and GPIO_IO_TX_02 are input!
}

uint32_t create_R_latch(uint16_t R)
{
	R = R & 0x3FFF; //get rid of upper two bits

	uint32_t result;

	result = R_COUNTER_LATCH_DB23_DB16;

	result = result << 14;
	result = result | R;

	result = result << 2;
	result = result | R_COUNTER_LATCH_DB1_DB0;

	return result;
}

uint32_t create_Control_latch()
{
	uint32_t result;

	result = CONTROL_LATCH_DB23_DB16;

	result = result << 8;
	result = result | CONTROL_LATCH_DB15_DB8;

	result = result << 8;
	result = result | CONTROL_LATCH_DB7_DB0;

	return result;
}

uint32_t create_N_latch(uint16_t B, uint8_t A)
{
	B = B & 0x1FFF;	//get rid of upper three bits
	A = A & 0x1F;	//get rid of upper three bits

	uint32_t result;

	result = N_COUNTER_LATCH_DB23_DB21;

	result = result << 3;
	result = result | B;

	result = result << 1;
	result = result | N_COUNTER_LATCH_DB7;

	result = result << 5;
	result = result | A;

	result = result << 2;
	result = result | N_COUNTER_LATCH_DB1_DB0;

	return result;
}

void RFX400InitFrequency(uint32_t frequency)
{
/*
	f_VCO = ( (P*B)+A ) * f_ref/R

	P = 8
	f_ref = 50e6

	R := 200
//with the above settings B corresponds to 1MHz, and A corresponds to 125kHz
*/

	uint16_t R	= 200;									// min 1, max 16383
	uint16_t B	= frequency / 1000000;					// min 3, max 8191, B > A !!!!!!!!!!
	uint8_t A	= (frequency - B*1000000) / 125000;		// min 0, max 31

	R_latch			= create_R_latch(R);
	Control_latch	= create_Control_latch();
	N_latch			= create_N_latch(B, A);

	send_SPI(R_latch, 24);
	send_SPI(Control_latch, 24);
}

void RFX400SetFrequency()
{
	send_SPI(N_latch, 24);
}

void RFX400SetInput(uint8_t input)
{

	if (input == RFX400_TX_RX)
	{
		ResetFlag((flags_t*) GPIO_OUTPUT, GPIO_IO_RX_06);
		SetFlag((flags_t*) GPIO_OUTPUT, GPIO_IO_TX_06);
	}
	else
	{
		SetFlag((flags_t*) GPIO_OUTPUT, GPIO_IO_RX_06);
		SetFlag((flags_t*) GPIO_OUTPUT, GPIO_IO_TX_06);
	}

}
