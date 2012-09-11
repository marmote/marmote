// MarmoteRecorder.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"

#include <direct.h>
#include "argtable2.h"

#include <conio.h>



// FTDI device parameters
static int default_dev;
#define INTERVAL_TIMEOUT 5000

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
	DWORD BytesWritten;
	char TxBuffer[128]; // Contains data to write to device
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

	// Set timeout
	ftStatus = FT_SetTimeouts(ftHandle, INTERVAL_TIMEOUT, 0);
	if (ftStatus != FT_OK)
	{
		printf("Unable to set DEV timeouts\n");
		return 1;
	}

	// Reset FT	
	ftStatus = FT_SetBitMode(ftHandle, 0xFF, FT_BITMODE_RESET);
	if (ftStatus != FT_OK)
	{
		printf("Unable to set DEV to RESET mode\n");
		return 1;
	}

	Sleep(100);
	
	// Set FT 245 Synchronous FIFO mode
	ftStatus = FT_SetBitMode(ftHandle, 0xFF, FT_BITMODE_SYNC_FIFO);
	if (ftStatus != FT_OK)
	{
		printf("Unable to set DEV to synchronous FIFO mode\n");
		return 1;
	}

	
	int j = 0;
	while (1)
	{
		getchar();
		TxBuffer[0] = '0' + j;
		//TxBuffer[0] = 0x3;
		
		//ftStatus = FT_Write(ftHandle, TxBuffer, sizeof(TxBuffer), &BytesWritten);
		ftStatus = FT_Write(ftHandle, TxBuffer, 1, &BytesWritten);
		if (ftStatus == FT_OK)
		{
			// FT_Write OK
			printf("Wrote %2d chars\n", BytesWritten);
			//putchar(TxBuffer[0]);
		}
		else
		{
			// FT_Write Failed
			break;
		}
		j++;
		//Sleep(1000);
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

