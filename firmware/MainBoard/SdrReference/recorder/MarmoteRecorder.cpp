// MarmoteRecorder.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"

#include <direct.h>
#include "argtable2.h"

#include <conio.h>

#include "MarmoteControl.h"



// FTDI device parameters
static int default_dev;
#define USB_TRANSFER_SIZE (65536uL / 4)
#define USB_REQUEST_SIZE (USB_TRANSFER_SIZE/64*62) // See AN232B-03
#define INTERVAL_TIMEOUT 100

// Wave file parameters
#define FNAME_SEARCH "rec_???.wav"
#define FNAME_FMT "rec_%03d.wav"

#define BITS_PER_SAMPLE 16
#define NUMBER_OF_CHANNELS 2
#define SAMPLE_RATE 44100
#define MAX_SAMPLE_LEN 1048576 // 2^20 samples (1 Msamples)
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
int recorder(int dev, const char* dir, int seq);
//void Marmote_writeReg(FT_HANDLE ftHandle, WORD addr, DWORD data);


int _tmain(int argc, _TCHAR* argv[])
{
	struct arg_lit  *help   = arg_lit0("h",  "help",            "print this help and exit");
	struct arg_int  *dev    = arg_int0("d",  "dev",    "idx",   "set the receiving device (default: last FTDI device)");
	struct arg_file *dir    = arg_file0("p", "path",   "path",  "set the output directory path (default: current)");
	struct arg_int  *start  = arg_int0("s",  "start",  "num",   "set the initail seq number (default: last+1)");
	struct arg_end  *end    = arg_end(20);
	void*  argtable[] = {help, dev, dir, start, end};
	const char* progname = argv[0];

	int nerrors;
    int exitcode=0;
	char dir_buffer[_MAX_PATH];

	// Verify the argtable[] entries were allocated sucessfully
    if (arg_nullcheck(argtable) != 0)
	{
        // NULL entries were detected, some allocations must have failed
        printf("%s: insufficient memory\n", progname);
        exitcode=1;
        goto exit;
	}

	// Set any command line default values prior to parsing
	dev->ival[0] = default_dev;
	dir->filename[0] = NULL;

	// Parse the command line as defined by argtable[]
    nerrors = arg_parse(argc, argv, argtable);

	// Special case: '--help' takes precedence over error reporting
    if (help->count > 0)
	{
		printf("Usage: %s", progname);
		arg_print_syntax(stdout, argtable, "\n");
		printf("Fast recorder program to download shot data from BHDetector sensors.\n");
		arg_print_glossary(stdout, argtable,"  %-25s %s\n");
		printf("\nAvailable FTDI devices:\n\n");
		list_ft_devices();
		exitcode = 0;
		goto exit;
	}

	// If the parser returned any errors then display them and exit
	if (nerrors > 0)
	{
		// Display the error details contained in the arg_end struct
		arg_print_errors(stdout, end, progname);
		printf("Try '%s --help' for more information\n", progname);
		exitcode = 1;
		goto exit;
	}

	if (dir->count == 0)
	{
		// Get the current working directory
		if( _getcwd( dir_buffer, _MAX_PATH ) == NULL )
		{
			perror( "ERROR: get current directory" );
			exitcode = 1;
			goto exit;
		}
		dir->filename[0] = dir_buffer;
	}

	if (GetFileAttributes(dir->filename[0]) != FILE_ATTRIBUTE_DIRECTORY)
	{
		printf("%s is not a valid directory\n", dir->filename[0]);
		exitcode = 1;
		goto exit;
	}

	if (start->count == 0) {
		WIN32_FIND_DATA FindFileData;
		HANDLE hFind;
		BOOL found;

		char search_buffer[_MAX_PATH];
		sprintf_s(search_buffer, _MAX_PATH, "%s\\%s", dir->filename[0], FNAME_SEARCH);
		start->ival[0] = 0;
		hFind = FindFirstFile(search_buffer, &FindFileData);

		found = (hFind != INVALID_HANDLE_VALUE);
		while (found) {
			int seq, res;
			res = _stscanf_s(FindFileData.cFileName, FNAME_FMT, &seq);
			if (res == 1) {
				start->ival[0] = max(start->ival[0], seq);
			}
			else {
				printf("WARNING: Invalid recording filename scheme detected: ");
				_tprintf(FindFileData.cFileName);
				printf("\n");
			}

			found = FindNextFile(hFind, &FindFileData);
		}

		FindClose(hFind);
		start->ival[0]++;

	}

	list_ft_devices();

	// normal case: take the command line options at face value
	exitcode = recorder(dev->ival[0], dir->filename[0], start->ival[0]);

	exit:
    // deallocate each non-null entry in argtable[]
    arg_freetable(argtable,sizeof(argtable)/sizeof(argtable[0]));

	getchar();

    return exitcode;
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


int recorder(int dev, const char* dir, int seq)
{
	FT_HANDLE ftHandle;
	FT_STATUS ftStatus;

	printf("Initalizing recorder:\n\n  DEV=%d\n  CHANNELS=1\n  DIR=%s\n  START=%d\n\n",
		dev, dir, seq);

	// Open FTDI device
	ftStatus = FT_Open(dev, &ftHandle);
	if (ftStatus != FT_OK)
	{
		printf("Unable to open DEV %d\n", dev);
		list_ft_devices();
		return 1;
	}

	printf("DEV %d opened\n", dev);

	// Reset FT	
	ftStatus = FT_ResetDevice(ftHandle);
	if (ftStatus != FT_OK)
	{
		printf("Unable to RESET the device\n");
		return 1;
	}

	FT_SetUSBParameters(ftHandle, USB_TRANSFER_SIZE, USB_TRANSFER_SIZE);

	// Set timeout
	ftStatus = FT_SetTimeouts(ftHandle, INTERVAL_TIMEOUT, 1000);
	if (ftStatus != FT_OK)
	{
		printf("Unable to set DEV timeouts\n");
		return 1;
	}

	ftStatus = FT_SetBitMode(ftHandle, 0xFF, FT_BITMODE_RESET);
	if (ftStatus != FT_OK)
	{
		printf("Unable to RESET bitmode\n");
		return 1;
	}

	
	// Assert reset (ACBUS9)
	ftStatus = FT_SetBitMode(ftHandle, 0x88, FT_BITMODE_CBUS_BITBANG);
	if (ftStatus != FT_OK)
	{
		printf("Unable to assert RESET\n");
		return 1;
	}
	
	/*
	// Set FT 245 Synchronous FIFO mode to enable 60 MHz clock
	ftStatus = FT_SetBitMode(ftHandle, 0xFF, FT_BITMODE_SYNC_FIFO);
	if (ftStatus != FT_OK)
	{
		printf("Unable to set DEV to synchronous FIFO mode (60 MHz clock enable)\n");
		return 1;
	}
	*/
	Sleep(500);

	// Deassert reset (ACBUS9)
	ftStatus = FT_SetBitMode(ftHandle, 0x80, FT_BITMODE_CBUS_BITBANG);
	if (ftStatus != FT_OK)
	{
		printf("Unable to deassert RESET\n");
		return 1;
	}
	
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

	char *sampleBuffer = (char*)malloc(MAX_RAW_BYTE_LEN);
	if (sampleBuffer == NULL) {
		printf("ERROR: Insufficient memory available\n");
		return (1);
	}

	char fname_buffer[_MAX_PATH];
	DWORD write_len;
		
	DWORD bytesWritten;	
	DWORD bytesRequested;
	DWORD bytesReceived;
	int rxBufCount;
	DWORD sampleBytesReceived;
	DWORD sampleBytesToWrite;
	int i, j;
	unsigned char rxBuffer[USB_REQUEST_SIZE*2];

	// Performance measure related
	unsigned int byteCounter = 0;
	LARGE_INTEGER timePrev, timeNow;
	LARGE_INTEGER frequency;
	double elapsedTime;

	QueryPerformanceFrequency(&frequency);
	QueryPerformanceCounter(&timePrev);
	
	printf("Starting streaming\n");	
	Marmote_StartStreaming(ftHandle);

	PktHdr_t* pkt;
	uint16_t prevSeq;
	prevSeq = 0;

	rxBufCount = 0;
	bool isFirstSeq;
		
	while (1)
	{
		BOOL bResult;		

		prevSeq = 0;
		rxBufCount = 0;
		sampleBytesReceived = 0;
		isFirstSeq = true;
		
		while (sampleBytesReceived < MAX_RAW_BYTE_LEN)
		{
			bytesRequested = USB_REQUEST_SIZE;

			ftStatus = FT_Read(ftHandle, rxBuffer + rxBufCount, bytesRequested, &bytesReceived);
			if (ftStatus != FT_OK)
			{
				printf("Unable to read device\n");
				Marmote_StopStreaming(ftHandle);				
				ftStatus = FT_Close(ftHandle);
				return 1;
			}
		
			if (bytesReceived < bytesRequested)
			{	
				printf("Timeout\n");
				printf("bytesReceived: %d / %d\n", bytesReceived, (unsigned int)bytesRequested);
				//Marmote_StopStreaming(ftHandle);
				//ftStatus = FT_Close(ftHandle);
				//printf("DEV %d closed\n", dev);
				//printf("Exiting\n");
				//return 0;
				continue;
			}

			rxBufCount += bytesReceived;
						
			// Process RX buffer
			i = 0;
			while (i < rxBufCount - sizeof(PktHdr_t))
			{				
				// Check SYNC characters
				if (!(rxBuffer[i] == SYNC_CHAR_1 && rxBuffer[i+1] == SYNC_CHAR_2))
				{
					i++;
					continue;
				}

				pkt = (PktHdr_t*)(rxBuffer+i);
				
				// Check length
				if (rxBufCount < i + (sizeof(PktHdr_t) + pkt->len + PKT_CHK_LEN))
				{
					break;
				}

				// Validate checksum
				if (!isChecksumValid(pkt))
				{
					printf("CHECKSUM ERROR\n");
					//printPkt(pkt);
					i++;
					continue;
				}

				// Process rxBuffer here
				if ( !isFirstSeq && (uint16_t)(*(uint16_t*)pkt->payload - prevSeq) != PKT_SAMPLE_PER_MSG)
				{
					printf("SEQUENCE ERROR\n");
					printf("Seq: %u -> %u (%04X -> %04X) Diff: %d\n", prevSeq, *(uint16_t*)pkt->payload, prevSeq, *(uint16_t*)pkt->payload, (uint16_t)(*(uint16_t*)pkt->payload - prevSeq));
				}
				prevSeq = *(uint16_t*)pkt->payload;
				isFirstSeq = false;
				
				// Make sure sampleBuffer does not overflow
				sampleBytesToWrite = pkt->len - MSG_SEQ_LEN < MAX_RAW_BYTE_LEN - sampleBytesReceived ? pkt->len - MSG_SEQ_LEN : MAX_RAW_BYTE_LEN - sampleBytesReceived;

				memcpy(sampleBuffer + sampleBytesReceived, pkt->payload + MSG_SEQ_LEN, sampleBytesToWrite);
				sampleBytesReceived += sampleBytesToWrite;

				i = i + sizeof(PktHdr_t) + pkt->len + PKT_CHK_LEN;
			}
			
			rxBufCount = rxBufCount - i;
			memcpy(rxBuffer, rxBuffer+i, rxBufCount);			
		}

		sprintf_s(fname_buffer, _MAX_PATH, "%s\\" FNAME_FMT, dir, seq); 
		printf("%s (%d bytes).\n", fname_buffer, sampleBytesReceived);

		HANDLE hFile = CreateFile(fname_buffer,
									GENERIC_WRITE,
									0,
									NULL,
									CREATE_NEW,
									0,
									NULL);
		if (hFile == INVALID_HANDLE_VALUE) {
			printf("Unable to create file (hFile == INVALID_HANDLE_VALUE)\n");
			// Do not return (try again next)
		}
	
		hdr.chunkSize = sampleBytesReceived + sizeof(hdr) - 8;
		hdr.subChunkSize2 = sampleBytesReceived;
		bResult =  WriteFile(hFile, &hdr, sizeof(hdr), &write_len, NULL);
		if (!bResult || (sizeof(hdr) != write_len)) {
			printf("Unable to write file (!bResult || (sizeof(hdr) != write_len))\n");
			// Do not return (try again next)
		}

		bResult =  WriteFile(hFile, sampleBuffer, sampleBytesReceived, &write_len, NULL);
		if (!bResult || (sampleBytesReceived != write_len)) {
			printf("Unable to write file (!bResult || (sampleBytesReceived != write_len))\n");
			// Do not return (try again next)
		}

		CloseHandle(hFile);

		// Calculate throughput
		{
			QueryPerformanceCounter(&timeNow);
			elapsedTime = (timeNow.QuadPart - timePrev.QuadPart) * 1.0 / frequency.QuadPart;
			printf("Throughput: %6.2f MB/s\n", (double)sampleBytesReceived / (double)(1 << 20) / elapsedTime);

			timePrev = timeNow;
			byteCounter = 0;
		}

		seq++;
	}
}


	
	
	


/*
DWORD Marmote_readReg(FT_HANDLE ftHandle, WORD addr)
{
	FT_STATUS ftStatus;
	UsbCtrl_t packet;
	DWORD bytesWritten;
	DWORD bytesRequested;
	DWORD bytesReceived;
	char rxBuffer[128];

	packet.sof = CTRL_SOF;
	packet.cmdId = CMD_ID_GET;
	packet.addr = addr;

	ftStatus = FT_Write(ftHandle, &packet, 6, &bytesWritten);
	if (ftStatus != FT_OK)
	{		
		// FT_Write Failed
		printf("readReg() (FT_Write) failed\n");
		return -1; // FIXME: solve error handling
	}

	printf("Sent packet (%d bytes):\n", bytesWritten);
	printf("SOF:  %4X\n CMD: %4X\nADDR: %4X\n", packet.sof, packet.cmdId, packet.addr);
	
	// Read the answer
	bytesRequested = sizeof(rxBuffer);
	ftStatus = FT_Read(ftHandle, rxBuffer, bytesRequested, &bytesReceived);
	if (ftStatus != FT_OK)
	{
		printf("readReg() (FT_Read) failed\n");
		return -1;
	}

	printf("Read  %4d chars: ", bytesReceived);
	for (DWORD i = 0; i < bytesReceived; i++)
	{
		printf("%02X ", rxBuffer[i]);
	}
	printf("\n");
}
*/

