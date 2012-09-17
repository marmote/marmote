#ifndef _MARMOTE_CONTROL_H
#define _MARMOTE_CONTROL_H

#include <stdio.h>
#include <string.h>

#include <windows.h>
#include "ftd2xx.h"


typedef unsigned char uint8_t;
typedef unsigned short uint16_t;
typedef unsigned int uint32_t;

#define SYNC_CHAR_1 0xB5
#define SYNC_CHAR_2 0x63 // ASCII 'b'

#define PKT_CHK_LENGTH 2

typedef enum _MsgClass
{
	MARMOTE = 1,
	SDR = 2,
	MAX2830 = 3,
} MsgClass_t;

typedef enum _MsgId
{	
	// Marmote
	SET_LED = 1,
	START_STREAM = 2,
	STOP_STREAM,
	// SDR
	SET_FREQUENCY = 3,
	GET_FREQUENCY = 4,
	// MAX2830
	SET_REG = 5,
	GET_REG = 6,
} MsgId_t;

typedef struct _PktHdr
{
	uint8_t sync_1;
	uint8_t sync_2;
	uint8_t msg_class;
	uint8_t msg_id;
	uint16_t len; // payload length (little-endian, max. 128 excluding sync chars, class, id and checksum fields)
	uint8_t payload[0];
	//uint8_t chk_a;
	//uint8_t chk_b;
} PktHdr_t;

void sendMsg(FT_HANDLE ftHandle, MsgClass_t pkt_class, MsgId_t msg_id, uint8_t* payload, uint16_t len);
void printPkt(PktHdr_t* pkt);

void Marmote_SetFrequency(FT_HANDLE ftHandle, uint32_t freq_hz);
uint32_t Marmote_GetFrequency(FT_HANDLE ftHandle);

#endif