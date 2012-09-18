#include "MarmoteControl.h"


void sendMsg(FT_HANDLE ftHandle, MsgClass_t msg_class, MsgId_t msg_id, uint8_t* payload, uint16_t len)
{
	FT_STATUS ftStatus;
	DWORD bytesWritten;

	PktHdr_t* pkt;
	uint8_t* chk_a_ptr; // pointer to checksum A
	uint8_t* chk_itr; // iterator for calculating checksum
	uint8_t i;	
	uint8_t tx_buf[256];

	len = (len > 128) ? 128 : len;

	pkt = (PktHdr_t*)tx_buf;

	pkt->sync_1 = SYNC_CHAR_1;
	pkt->sync_2 = SYNC_CHAR_2;
	pkt->msg_class = msg_class;
	pkt->msg_id = msg_id;
	pkt->len = len;

	memcpy(&(pkt->payload), payload, len);

	chk_a_ptr = pkt->payload + pkt->len;
	chk_itr = &(pkt->msg_class);

	// Checksum calculation (over msg_class, msg_id, len and payload)
	*chk_a_ptr = 0;
	*(chk_a_ptr+1) = 0;
	for (i = 0; i < 4 + pkt->len; i++) // TODO: remove 4
	{
		*(chk_a_ptr) += *(chk_itr+i);
		*(chk_a_ptr+1) += *(chk_a_ptr);
	}


	ftStatus = FT_Write(ftHandle, (uint8_t*)pkt, sizeof(PktHdr_t) + len + PKT_CHK_LENGTH, &bytesWritten);
	if (ftStatus == FT_OK)
	{
		/*
		printf("Sent packet (%d bytes):\n", bytesWritten);
		for (i = 0; i < sizeof(PktHdr_t) + len + PKT_CHK_LENGTH; i++)
		{
			printf("%02X ", *((uint8_t*)pkt + i));
		}
		printf("\n");
		printPkt(pkt);
		*/
	}
	else
	{
		printf("sendMsg(): FT_Write failed\n");
	}
}


void printPkt(PktHdr_t* pkt)
{
	uint8_t i;
	uint8_t* chk_a_ptr;
	uint8_t* chk_itr; // iterator for calculating checksum
	uint8_t chk_a;
	uint8_t chk_b;
	
	printf("Sync:\t\t%2X %02X\nClass:\t\t%02X\nId:\t\t%02X\nLength:\t\t%02X\n", pkt->sync_1, pkt->sync_2, pkt->msg_class, pkt->msg_id, pkt->len);

	printf("Payload:\t");
	for (i = 0; i < pkt->len; i++)
	{
		printf("%02X ", *(pkt->payload+i));
	}
	printf("\n");
		
	chk_a_ptr = pkt->payload + pkt->len;
	chk_itr = &(pkt->msg_class);

	chk_a = 0;
	chk_b = 0;
	for (i = 0; i < 4 + pkt->len; i++)
	{
		chk_a += *(chk_itr+i);
		chk_b += chk_a;
	}

	printf("Checksum:\t%02X %02X -> ", *chk_a_ptr, *(chk_a_ptr+1));

	if (*chk_a_ptr == chk_a && *(chk_a_ptr+1) == chk_b)
	{
		printf("OK\n");
	}
	else
	{
		printf("ERROR\n");
	}
}


void Marmote_SetFrequency(FT_HANDLE ftHandle, uint32_t freq_hz)
{
	uint8_t txBuffer[4];
	memcpy(txBuffer, &freq_hz, sizeof(freq_hz));
	sendMsg(ftHandle, SDR, SET_FREQUENCY, txBuffer, sizeof(freq_hz));
}

uint32_t Marmote_GetFrequency(FT_HANDLE ftHandle)
{
	uint32_t freq;

	uint8_t dummy;
	uint8_t rxBuffer[150];
	PktHdr_t* pkt;

	DWORD bytesRequested;
	DWORD bytesReceived;
	FT_STATUS ftStatus;

	sendMsg(ftHandle, SDR, GET_FREQUENCY, &dummy, 0);
	bytesRequested = sizeof(rxBuffer);
	ftStatus = FT_Read(ftHandle, rxBuffer, bytesRequested, &bytesReceived);
	if (ftStatus != FT_OK)
	{
		printf("readReg(): FT_Read failed\n");
		return -1;
	}

	pkt = NULL;
	printf("Read  %4d chars: ", bytesReceived);
	for (DWORD i = 0; i < bytesReceived; i++)
	{
		if (rxBuffer[i] == SYNC_CHAR_1)
		{
			pkt = (PktHdr_t*)(rxBuffer+i);
		}
	}
	printf("\n");

	if (!pkt)
	{
		// ERROR
		return 0;
	}
	
	freq = *(uint32_t*)pkt->payload;
	
	return freq;
}

void Marmote_StartStreaming(FT_HANDLE ftHandle)
{
	uint8_t dummy;
	sendMsg(ftHandle, SDR, START_STREAMING, &dummy, 0);
}

void Marmote_StopStreaming(FT_HANDLE ftHandle)
{
	uint8_t dummy;
	sendMsg(ftHandle, SDR, STOP_STREAMING, &dummy, 0);
}