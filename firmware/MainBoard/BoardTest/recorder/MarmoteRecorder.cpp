// MarmoteRecorder.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"

#include <direct.h>
#include "argtable2.h"


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
int recorder(int dev, const char* dir, int seq);


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
	FT_STATUS ftStatus;
	FT_HANDLE ftHandle;
	
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

	char *rxBuffer = (char*)malloc(MAX_RAW_BYTE_LEN);
	if (rxBuffer == NULL) {
		printf("ERROR: Insufficient memory available\n");
		return (1);
	}

	char fname_buffer[_MAX_PATH];

	DWORD bytesReceived;
	DWORD totalBytesReceived;		
	DWORD bytesRequested;
	DWORD chunkSize = 4092; // Driver seem to handle 131072 at maximum
	DWORD write_len;
	
	// Performance measure related
	unsigned int byteCounter = 0;
	LARGE_INTEGER timePrev, timeNow;
	LARGE_INTEGER frequency;
	double elapsedTime;

	QueryPerformanceFrequency(&frequency);
	QueryPerformanceCounter(&timePrev);

	printf("Starting recorder:\n");

	// v1
	
	while (1)
	{
		BOOL bResult;

		totalBytesReceived = 0;

		// Get the data from FT driver in smaller chunks
		while (totalBytesReceived < MAX_RAW_BYTE_LEN)
		{
			bytesRequested = chunkSize < (MAX_RAW_BYTE_LEN - totalBytesReceived) ? chunkSize : MAX_RAW_BYTE_LEN - totalBytesReceived;

			ftStatus = FT_Read(ftHandle, rxBuffer + totalBytesReceived,
				bytesRequested, &bytesReceived);

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
		
			if (bytesReceived < bytesRequested)
			{			
				ftStatus = FT_Close(ftHandle);
				if (ftStatus != FT_OK)
				{
					printf("FT_Close(): FAILED\n");
				}
				printf("Timeout\n");
				printf("DEV %d closed\n", dev);
				printf("Exiting\n");
				return 0;
			}

			totalBytesReceived += bytesReceived;

			//printf("Total %d bytes received\n", totalBytesReceived);
		}


		sprintf_s(fname_buffer, _MAX_PATH, "%s\\" FNAME_FMT, dir, seq); 
		printf("%s (%d bytes).\n", fname_buffer, totalBytesReceived);

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
	
		hdr.chunkSize = totalBytesReceived + sizeof(hdr) - 8;
		hdr.subChunkSize2 = totalBytesReceived;
		bResult =  WriteFile(hFile, &hdr, sizeof(hdr), &write_len, NULL);
		if (!bResult || (sizeof(hdr) != write_len)) {
			printf("Unable to write file (!bResult || (sizeof(hdr) != write_len))\n");
			// Do not return (try again next)
		}

		bResult =  WriteFile(hFile, rxBuffer, totalBytesReceived, &write_len, NULL);
		if (!bResult || (totalBytesReceived != write_len)) {
			printf("Unable to write file (!bResult || (bytesReceived != write_len))\n");
			// Do not return (try again next)
		}

		CloseHandle(hFile);

		// Calculate throughput
		{
			QueryPerformanceCounter(&timeNow);
			elapsedTime = (timeNow.QuadPart - timePrev.QuadPart) * 1.0 / frequency.QuadPart;
			printf("Throughput: %6.2f MB/s\n", (double)totalBytesReceived / (double)(1 << 20) / elapsedTime);

			timePrev = timeNow;
			byteCounter = 0;
		}

		seq++;
	}
			
	// v2

	/*
	unsigned char oldValue = 0;	
	bool isFirst = true;

	while (1)
	{
		
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
			
	// Check 'signal integrity'
	for (DWORD i = 0; i < bytesReceived; i++)
	{
		unsigned char newValue = (unsigned char)(rxBuffer[i]);
		if (isFirst)
		{
			oldValue = newValue;
			isFirst = false;
			continue;
		}

		if (newValue != ((oldValue + 1) & 0xFF))
		{
			printf("oldvalue: %03X newValue: %03X\n", oldValue, newValue);		
		}

		oldValue = newValue;
	}

	// Calculate throughput
	byteCounter += bytesReceived;
	if (byteCounter > (unsigned int)1e8)
	{
		QueryPerformanceCounter(&timeNow);
		elapsedTime = (timeNow.QuadPart - timePrev.QuadPart) * 1.0 / frequency.QuadPart;
		printf("Throughput: %6.2f MB/s\n", (double)byteCounter / (double)(1 << 20) / elapsedTime);

		timePrev = timeNow;
		byteCounter = 0;
	}


	if (bytesReceived < bytesRequested)
	{
		printf("Timeout occured (%d ms)\n", INTERVAL_TIMEOUT);
		printf("Bytes received: %d\n", bytesReceived);	
	}

	}
	*/

	// Close FTDI device
	ftStatus = FT_Close(ftHandle);
	if (ftStatus == FT_OK)
	{
		printf("DEV %d closed\n", dev);
	}
	else
	{
		printf("FT_Close(): FAILED\n");
	}

	return 0;
}