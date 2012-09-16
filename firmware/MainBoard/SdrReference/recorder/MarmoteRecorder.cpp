// MarmoteRecorder.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"

#include <direct.h>
#include "argtable2.h"

#include <conio.h>



// FTDI device parameters
static int default_dev;
#define INTERVAL_TIMEOUT 200

#define CTRL_SOF 0x5F

enum _cmdID
{
	CMD_ID_SET,
	CMD_ID_GET,
	CMD_ID_RET
} cmdID;

typedef struct _UsbCtrl_t
{
	char	sof;
	char	cmdID;
	WORD	addr;
	DWORD	data;
} UsbCtrl_t;


// Wave file parameters
#define FNAME_SEARCH "rec_???.wav"
#define FNAME_FMT "rec_%03d.wav"

#define BITS_PER_SAMPLE 8
#define NUMBER_OF_CHANNELS 1
#define SAMPLE_RATE 44100
#define MAX_SAMPLE_LEN 1048576*8 // 2^20 samples (1 Msamples)
#define MAX_RAW_BYTE_LEN (NUMBER_OF_CHANNELS * MAX_SAMPLE_LEN * (BITS_PER_SAMPLE/8))

typedef struct _WAVhdr {
	char	chunkID[4];
	DWORD	chunkSize;
	char	format[4];

	char	subchunkID1[4];
	DWORD	subChunkSize1;
	WORD	audioFormat;
	WORD	numChannels;
	DWORD	sampleRate;
	DWORD	byteRate;
	WORD	blockAlign;
	WORD	bitsPerSample;

	char	subchunkID2[4];
	DWORD	subChunkSize2;
} WAVhdr;



WAVhdr hdr = {{'R', 'I', 'F', 'F'}, 36, {'W', 'A', 'V', 'E'}, 
			  {'f', 'm', 't', ' '}, 16, 1, NUMBER_OF_CHANNELS, SAMPLE_RATE, MAX_RAW_BYTE_LEN, NUMBER_OF_CHANNELS*(BITS_PER_SAMPLE/8), BITS_PER_SAMPLE,
			  {'d', 'a', 't', 'a'}, 0};


void list_ft_devices(void);


int _tmain(int argc, _TCHAR* argv[])
{
	struct arg_lit  *help   = arg_lit0("h",  "help",            "print this help and exit");
	struct arg_int  *dev    = arg_int0("d",  "dev",    "idx",   "set the receiving device (default: last FTDI device)");
	struct arg_file *dir    = arg_file0("p", "path",   "path",  "set the output directory path (default: current)");
	struct arg_int  *start  = arg_int0("s",  "start",  "num",   "set the initail seq number (default: last+1)");
	struct arg_end  *end    = arg_end(20);
	void*  argtable[] = {help, dev, dir, start, end};
	const char* progname = argv[0];


	list_ft_devices();

	FT_HANDLE ftHandle;
	FT_STATUS ftStatus;
	DWORD bytesWritten;
	DWORD bytesRequested;
	DWORD bytesReceived;
	unsigned char txBuffer[128]; // Contains data to write to device
	unsigned char rxBuffer[4096];
	int device = 0;

	// Open FTDI device
	ftStatus = FT_Open(device, &ftHandle);
	if (ftStatus != FT_OK)
	{
		printf("Unable to open DEV %d\n", device);
		list_ft_devices();
		return 1;
	}

	printf("DEV %d opened\n", device);

	// Reset FT	
	ftStatus = FT_ResetDevice(ftHandle);
	if (ftStatus != FT_OK)
	{
		printf("Unable to RESET the device\n");
		return 1;
	}

	// Set timeout
	ftStatus = FT_SetTimeouts(ftHandle, INTERVAL_TIMEOUT, 1000);
	if (ftStatus != FT_OK)
	{
		printf("Unable to set DEV timeouts\n");
		return 1;
	}

	//Sleep(100);
	ftStatus = FT_SetBitMode(ftHandle, 0xFF, FT_BITMODE_RESET);
	if (ftStatus != FT_OK)
	{
		printf("Unable to RESET bitmode\n");
		return 1;
	}

	/*
	// Assert reset (ACBUS9)
	ftStatus = FT_SetBitMode(ftHandle, 0x88, FT_BITMODE_CBUS_BITBANG);
	if (ftStatus != FT_OK)
	{
		printf("Unable to assert RESET\n");
		return 1;
	}
		
	// Set FT 245 Synchronous FIFO mode to enable 60 MHz clock
	ftStatus = FT_SetBitMode(ftHandle, 0xFF, FT_BITMODE_SYNC_FIFO);
	if (ftStatus != FT_OK)
	{
		printf("Unable to set DEV to synchronous FIFO mode (60 MHz clock enable)\n");
		return 1;
	}

	// Deassert reset (ACBUS9)
	ftStatus = FT_SetBitMode(ftHandle, 0x80, FT_BITMODE_CBUS_BITBANG);
	if (ftStatus != FT_OK)
	{
		printf("Unable to deassert RESET\n");
		return 1;
	}
	*/
	
	// Set FT 245 Synchronous FIFO mode
	ftStatus = FT_SetBitMode(ftHandle, 0xFF, FT_BITMODE_SYNC_FIFO);
	if (ftStatus != FT_OK)
	{
		printf("Unable to set DEV to synchronous FIFO mode\n");
		return 1;
	}

	// Purge both Rx and Tx buffers
	ftStatus = FT_Purge(ftHandle, FT_PURGE_RX | FT_PURGE_TX);
	if (ftStatus != FT_OK) {
		printf("Unable to flush FIFOs\n");
		return 1;
	}

	// TODO: Deassert reset (ACBUS9)

	
	int j = 0;
	while (1)
	{
		getchar();
		
		txBuffer[0] = 10*j;
		txBuffer[1] = 10*j+1;
		txBuffer[2] = 10*j+2;
		txBuffer[3] = 10*j+3;
		
		//ftStatus = FT_Write(ftHandle, TxBuffer, sizeof(txBuffer), &bytesWritten);
		ftStatus = FT_Write(ftHandle, txBuffer, 4, &bytesWritten);
		if (ftStatus == FT_OK)
		{
			// FT_Write OK
			printf("Wrote %4d chars: %02X %02X %02X %02X\n", bytesWritten, txBuffer[0], txBuffer[1], txBuffer[2], txBuffer[3]);
		}
		else
		{
			// FT_Write Failed
			break;
		}
		j++;
		//Sleep(1000);
	
		bytesRequested = 4096;
		bytesReceived = 0;
		ftStatus = FT_Read(ftHandle, rxBuffer, bytesRequested, &bytesReceived);
		if (ftStatus != FT_OK)
		{
			printf("Unable to read device\n");
			ftStatus = FT_Close(ftHandle);
			if (ftStatus != FT_OK)
			{
				printf("FT_Close(): FAILED\n");
			}
			return 1;
		}
		printf("Read  %4d chars: ", bytesReceived);
		for (DWORD i = 0; i < bytesReceived; i++)
		{
			printf("%02X ", rxBuffer[i]);
		}
		printf("\n");
	}

	//char c;
	//while ((c = getch()) != EOF)
	//{
	//	for (int i = 0; i < 100; i++)
	//	{
	//		TxBuffer[i] = c;
	//	}

	//	ftStatus = FT_Write(ftHandle, TxBuffer, 100, &BytesWritten);
	//	if (ftStatus == FT_OK)
	//	{
	//		// FT_Write OK
	//		printf("Written %2d chars\n", BytesWritten);
	//		//putchar(c);
	//	}
	//	else
	//	{
	//		// FT_Write Failed
	//		break;
	//	}				
	//}

	printf("Terminated with ftStatus = %s\n", ftStatus == FT_OK ? "FT_OK" : "FT_ERROR");

	FT_Close(ftHandle);

	getchar();

    return 0;
}


void list_ft_devices(void)
{
	FT_STATUS ftStatus;
	FT_DEVICE_LIST_INFO_NODE *devInfo;
	DWORD numDevs;

	unsigned int i;

	// create the device information list
	ftStatus = FT_CreateDeviceInfoList(&numDevs);
	if (ftStatus != FT_OK)
	{
		// FT_CreateDeviceInfoList failed
		printf("FT_CreateDeviceInfoList(): FAILED\n");
	}

	if (numDevs > 0)
	{
		// allocate storage for list based on numDevs
		devInfo = (FT_DEVICE_LIST_INFO_NODE*) malloc(sizeof(FT_DEVICE_LIST_INFO_NODE) * numDevs);
		
		// get the device information list
		ftStatus = FT_GetDeviceInfoList(devInfo, &numDevs);
		if (ftStatus == FT_OK)
		{
			for (i = 0; i < numDevs; i++)
			{
				printf("DEV %d:\n", i);
				printf("\tFlags=0x%x\n", devInfo[i].Flags);
				printf("\tType=0x%x\n", devInfo[i].Type);
				printf("\tID=0x%x\n", devInfo[i].ID);
				printf("\tLocId=0x%x\n", devInfo[i].LocId);
				printf("\tSerialNumber=%s\n", devInfo[i].SerialNumber);
				printf("\tDescription=%s\n", devInfo[i].Description);
				printf("\tftHandle=0x%x\n", devInfo[i].ftHandle);
				printf("\n");
			}
		}
	}
}

