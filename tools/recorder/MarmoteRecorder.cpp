// MarmoteRecorder.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"

#include <direct.h>
#include "argtable2.h"

#include "FTDIstuff.h"



#define FNAME_SEARCH "rec_???.bin"
#define FNAME_FMT "rec_%03d.bin"

#define BITS_PER_SAMPLE 16
#define NUMBER_OF_CHANNELS 2
#define SAMPLE_RATE 44100
#define MAX_SAMPLE_LEN 1048576*8 // 2^20 samples (1 Msamples)
#define MAX_RAW_BYTE_LEN (NUMBER_OF_CHANNELS * MAX_SAMPLE_LEN * (BITS_PER_SAMPLE/8))



int recsize_b;


/*******************************************************************************
*******************************************************************************/
void list_ft_devices()
{
	FT_DEVICE_LIST_INFO_NODE	*devInfo;
	DWORD						numDevs;

	unsigned int i;

	// create the device information list
	if ( FT_CreateDeviceInfoList(&numDevs) != FT_OK )
		// FT_CreateDeviceInfoList failed
		printf("FT_CreateDeviceInfoList(): FAILED\n");


	if (!numDevs)
		return;


	// allocate storage for list based on numDevs
	devInfo = (FT_DEVICE_LIST_INFO_NODE*) malloc(sizeof(FT_DEVICE_LIST_INFO_NODE) * numDevs);
		
	// get the device information list
	if ( FT_GetDeviceInfoList(devInfo, &numDevs) != FT_OK )
		return;


	for (i = 0; i < numDevs; i++)
	{
		printf("DEV %d:\n", i);
		printf("\tFlags=0x%x\n",		devInfo[i].Flags);
		printf("\tType=0x%x\n",			devInfo[i].Type);
		printf("\tID=0x%x\n",			devInfo[i].ID);
		printf("\tLocId=0x%x\n",		devInfo[i].LocId);
		printf("\tSerialNumber=%s\n",	devInfo[i].SerialNumber);
		printf("\tDescription=%s\n",	devInfo[i].Description);
		printf("\tftHandle=0x%x\n",		devInfo[i].ftHandle);
		printf("\n");
	}
}
 

/*******************************************************************************
*******************************************************************************/
int Open_FTDI_dev(int dev, FT_HANDLE &ftHandle)
{
	// Open FTDI device
	if ( FT_Open(dev, &ftHandle) != FT_OK )
	{
		printf("Unable to open DEV %d\n", dev);
//		list_ft_devices();
		return 1;
	}

	printf("DEV %d opened\n", dev);

	// Set timeout
	if ( FT_SetTimeouts(ftHandle, INTERVAL_TIMEOUT, 0) != FT_OK )
	{
		printf("Unable to set DEV timeouts\n");
		return 1;
	}

	// Reset FT	
	if ( FT_SetBitMode(ftHandle, 0xFF, FT_BITMODE_RESET) != FT_OK )
	{
		printf("Unable to set DEV to RESET mode\n");
		return 1;
	}

	Sleep(100);

	// Set FT 245 Synchronous FIFO mode
	if ( FT_SetBitMode(ftHandle, 0xFF, FT_BITMODE_SYNC_FIFO) != FT_OK )
	{
		printf("Unable to set DEV to synchronous FIFO mode\n");
		return 1;
	}

	return 0;
} 
 

/*******************************************************************************
*******************************************************************************/
int Close_FTDI_dev(int dev, FT_HANDLE &ftHandle)
{
	// Close FTDI device
	if ( FT_Close(ftHandle) != FT_OK )
	{
		printf("FT_Close(): FAILED\n");
		return 1;
	}

	printf("DEV %d closed\n", dev);
	return 0;
}


/*******************************************************************************
*******************************************************************************/
int Send_config(FT_HANDLE &ftHandle)
{
	char	f_buff[28];
	FILE*	fp;

	fp = fopen("config", "r");

	if (!fp)
	{
		printf("Configuration file \"config\" was not found\n");
		return 1;
	}
	
	printf("Configuration file \"config\" was opened\n");

	if ( fread((void*) f_buff, sizeof(char), 28, fp) != 28 )
	{
		printf("Couldn't read 28 bytes from configuration file\n");
		fclose(fp);
		return 1;
	}

	printf("Read 28 bytes from configuration file\n");

	fclose(fp);
	printf("Configuration file closed\n");

	DWORD		BytesWritten;

	if ( FT_Write(ftHandle, (void*) f_buff, 28*sizeof(char), &BytesWritten) != FT_OK )
	{
		printf("Unable to send configuration\n");
		return 1;
	}

	printf("Configuration sent\n");

	return 0;
}


/*******************************************************************************
*******************************************************************************/
void Calculate_throughput(DWORD totalBytesReceived = 0, char init = 0 )
{
	static LARGE_INTEGER	timePrev;
	static LARGE_INTEGER	timeNow;
	static LARGE_INTEGER	frequency;
	
	if ( init )
	{
		QueryPerformanceFrequency(&frequency);
		QueryPerformanceCounter(&timePrev);
	}
	else
	{
		QueryPerformanceCounter(&timeNow);

		double elapsedTime;

		elapsedTime = (timeNow.QuadPart - timePrev.QuadPart) * 1.0 / frequency.QuadPart;
		printf("Throughput: %6.2f MB/s\n", (double)totalBytesReceived / (double)(1 << 20) / elapsedTime);

		timePrev = timeNow;
	}

}


/*******************************************************************************
*******************************************************************************/
int Print_working_dir()
{
	char cCurrentPath[FILENAME_MAX];

	if (!_getcwd(cCurrentPath, sizeof(cCurrentPath) / sizeof(TCHAR)))
		return errno;

	cCurrentPath[sizeof(cCurrentPath) - 1] = '\0'; /* not really required */

	printf ("The current working directory is %s\n", cCurrentPath);

	return 0;
}


/*******************************************************************************
*******************************************************************************/
int Read_from_FTDI_dev(int dev, DWORD &totalBytesReceived, char *rxBuffer, FT_HANDLE &ftHandle)
{
	DWORD bytesRequested;
	DWORD chunkSize = 4092; // Driver seems to handle at most 131072
	DWORD bytesReceived;

	while (totalBytesReceived < recsize_b)
	{
		// Get the data from FT driver in smaller chunks
		bytesRequested = chunkSize < (recsize_b - totalBytesReceived) ? chunkSize : recsize_b - totalBytesReceived;

		if ( FT_Read(ftHandle, rxBuffer + totalBytesReceived, bytesRequested, &bytesReceived) != FT_OK )
		{
			printf("Unable to read device\n");

			Close_FTDI_dev(dev, ftHandle);

			return 1;
		}
		
		if (bytesReceived < bytesRequested)
		{	
			printf("Timeout\n");

			Close_FTDI_dev(dev, ftHandle);

			return 1;
		}

		totalBytesReceived += bytesReceived;

	}

	return 0;
}


/*******************************************************************************
*******************************************************************************/
void Write_binary_file(const char* dir, int &seq, DWORD &totalBytesReceived, char *rxBuffer)
{
	char fname_buffer[_MAX_PATH];

	while (1)
	{
		sprintf_s(fname_buffer, _MAX_PATH, "%s\\" FNAME_FMT, dir, seq); 
		seq++;

		printf("%s (%d bytes).\n", fname_buffer, totalBytesReceived);

		HANDLE hFile = CreateFile(fname_buffer,
									GENERIC_WRITE,
									0,
									NULL,
									CREATE_NEW,
									0,
									NULL);

		if (hFile == INVALID_HANDLE_VALUE) 
		{
			printf("Unable to create file (hFile == INVALID_HANDLE_VALUE)\n");
			continue;
		}

		BOOL bResult;
		DWORD write_len;

		bResult =  WriteFile(hFile, rxBuffer, totalBytesReceived, &write_len, NULL);

		CloseHandle(hFile);

		if (bResult && (totalBytesReceived == write_len)) 
			break;

		printf("Unable to write file (!bResult || (bytesReceived != write_len))\n");
	}
}


/*******************************************************************************
*******************************************************************************/
int recorder(int dev, const char* dir, int seq)
{
	FT_HANDLE	ftHandle;
	int			error_code;
	

	printf("Initalizing recorder:\n\n  DEV=%d\n  CHANNELS=1\n  DIR=%s\n  START=%d\n\n", dev, dir, seq);

	if ( error_code = Open_FTDI_dev(dev, ftHandle) )
		return error_code;

	if ( error_code = Print_working_dir() )
		return error_code;

	Send_config(ftHandle);

	char *rxBuffer = (char*) malloc(recsize_b);
	if (!rxBuffer) 
	{
		printf("ERROR: Insufficient memory available\n");
		return 1;
	}

	Calculate_throughput( 0, 1 ); //Initialization

	printf("Starting recorder:\n");


	DWORD totalBytesReceived;	
	while (1)
	{
		totalBytesReceived = 0;

		if ( error_code = Read_from_FTDI_dev(dev, totalBytesReceived, rxBuffer, ftHandle) )
			return error_code;

		Write_binary_file(dir, seq, totalBytesReceived, rxBuffer);

		Calculate_throughput(totalBytesReceived);
	}

	Close_FTDI_dev(dev, ftHandle);

	return 0;
}


/*******************************************************************************
*
*							      MAIN
*
*******************************************************************************/
int _tmain(int argc, _TCHAR* argv[])
{
	struct arg_lit  *help   = arg_lit0("h",		"help",					"print this help and exit");
	struct arg_int  *dev    = arg_int0("d",		"dev",		"idx",		"set the receiving device (default: last FTDI device)");
	struct arg_file *dir    = arg_file0("p",	"path",		"path",		"set the output directory path (default: current)");
	struct arg_int  *start  = arg_int0("s",		"start",	"num",		"set the initail seq number (default: last+1)");
	struct arg_int  *recsize= arg_int0("r",		"recsize",	"num",		"set the number of recorded bytes");

	struct arg_end  *end    = arg_end(20);
	void*  argtable[]		= {help, dev, dir, start, recsize, end};
	const char* progname	= argv[0];

    int nerrors;
    int exitcode=0;
	char dir_buffer[_MAX_PATH];

	// Verify the argtable[] entries were allocated sucessfully
    if (arg_nullcheck(argtable))
	{
        // NULL entries were detected, some allocations must have failed
        printf("%s: insufficient memory\n", progname);
        exitcode=1;
        goto exit;
	}

	// Set any command line default values prior to parsing
	dev->ival[0]		= default_dev;
	dir->filename[0]	= NULL;
	recsize->ival[0]	= MAX_RAW_BYTE_LEN;

	// Parse the command line as defined by argtable[]
    nerrors = arg_parse(argc, argv, argtable);

	recsize_b = recsize->ival[0];

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

	if (start->count == 0) 
	{
		WIN32_FIND_DATA FindFileData;
		HANDLE hFind;
		BOOL found;

		char search_buffer[_MAX_PATH];
		sprintf_s(search_buffer, _MAX_PATH, "%s\\%s", dir->filename[0], FNAME_SEARCH);
		start->ival[0] = 0;
		hFind = FindFirstFile(search_buffer, &FindFileData);

		found = (hFind != INVALID_HANDLE_VALUE);

		while (found) 
		{
			int seq, res;
			res = _stscanf_s(FindFileData.cFileName, FNAME_FMT, &seq);

			if (res == 1) 
				start->ival[0] = max(start->ival[0], seq);
			else 
			{
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

//	getchar();

    return exitcode;
}
