// MarmoteRecorder.cpp : Defines the entry point for the console application.
//

#define _CRT_SECURE_NO_WARNINGS

#include "stdafx.h"


#include <direct.h>
#include "argtable2.h"

#include "FTDIstuff.h"
#include "ThroughputCalculator.h"
#include "FileIterator.h"



#define BITS_PER_SAMPLE 16
#define NUMBER_OF_CHANNELS 2
#define SAMPLE_RATE 44100
#define MAX_SAMPLE_LEN 1048576*8 // 2^20 samples (1 Msamples)
#define MAX_RAW_BYTE_LEN (NUMBER_OF_CHANNELS * MAX_SAMPLE_LEN * (BITS_PER_SAMPLE/8))




/*******************************************************************************
*******************************************************************************/
int Print_working_dir()
{
	char path[_MAX_PATH];

	if (!_getcwd(path, _MAX_PATH))
		return errno;

	printf ("The current working directory is %s\n", path);

	return 0;
}


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

	FT_SetTimeouts(ftHandle, 1, 0);

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

	fp = fopen("config", "rb");

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
int Read_from_FTDI_dev(DWORD &BytesRequested, DWORD &BytesReceived, char *rx_buff, FT_HANDLE &ftHandle)
{
	DWORD chunkSize = 4092; // Driver seems to handle at most 131072
	
	BytesRequested = min(chunkSize, BytesRequested);

	if ( FT_Read(ftHandle, rx_buff, BytesRequested, &BytesReceived) != FT_OK )
	{
		printf("Unable to read device\n");
		return 1;
	}
		
	return 0;
}


/*******************************************************************************
*******************************************************************************/
int Recorder(char*			work_dir, 
			int				&dev_num, 
			unsigned long	&rec_size,
			unsigned long	&start_seq)
{
	FT_HANDLE	ftHandle;
	int			error_code;
	

	/*****************************************/
	char *rx_buff = (char*) malloc(rec_size);
	if (!rx_buff) 
	{
		printf("ERROR: Insufficient memory available\n");
		return 1;
	}
	unsigned long rx_buff_size = 0;


	/*****************************************/
	if ( error_code = Print_working_dir() )
		return error_code;


	/*****************************************/
	HANDLE	gh[2];
	DWORD	dwEvent;


	HANDLE  stdIn = GetStdHandle(STD_INPUT_HANDLE);
	gh[0] = stdIn;


	/*****************************************/
	printf("Initalizing recorder:\n\n	DIR=%s\n	DEV=%d\n\n", work_dir, dev_num);
	if ( error_code = Open_FTDI_dev(dev_num, ftHandle) )
		return error_code;


	/*****************************************/
	HANDLE hEvent = CreateEvent(NULL,
						false, // auto-reset event
						false, // non-signalled state
						"");

	FT_SetEventNotification(ftHandle, FT_EVENT_RXCHAR, hEvent);

	gh[1] = hEvent;


	/*****************************************/
	//printf("Sending configuration:\n");
	//Send_config(ftHandle);


	/*****************************************/
	printf("Starting recording:\n");


	char store = 1;


	DWORD	saveMode;
	GetConsoleMode(stdIn, &saveMode);
	SetConsoleMode(stdIn, ENABLE_PROCESSED_INPUT);

	
	CThroughput_Calculator	TPC;
	CFile_Iterator			FI(work_dir, start_seq);
	DWORD					total_RxBytes = 0;

	while (1)
	{
		TPC.Calculate_Throughput();

		//There is stuff in buffer to write to file
		//OR
		//there is stuff to read from FTDI
		while (rx_buff_size || total_RxBytes)
		{
			//There is stuff in buffer to write to file
			while (rx_buff_size)
			{
				if (FI.hFile == INVALID_HANDLE_VALUE)
					FI.Iterate();

				unsigned long BytesToWrite = min(rec_size - FI.current_size, rx_buff_size);

				unsigned long write_len;

				if (!WriteFile(FI.hFile, rx_buff, BytesToWrite, &write_len, NULL))
					printf("Unable to write file\n");

				memmove(rx_buff, rx_buff + BytesToWrite, rx_buff_size - BytesToWrite);
				rx_buff_size -= BytesToWrite;

				TPC.Inc_Byte_Counter(BytesToWrite);
				FI.Inc_size(BytesToWrite);

				if ( FI.current_size >= rec_size )
					FI.Close_Current();
			}

			//there is stuff to read from FTDI
			if (total_RxBytes)
			{
				unsigned long	BytesReceived;
				if ( error_code = Read_from_FTDI_dev(total_RxBytes, BytesReceived, rx_buff + rx_buff_size, ftHandle) )
				{	
					Close_FTDI_dev(dev_num, ftHandle);
					return error_code;
				}
				
				if (store)
					rx_buff_size += BytesReceived;

				total_RxBytes -= BytesReceived;
			}
		}

		dwEvent = WaitForMultipleObjects( 
				2,				// number of objects in array
				gh,				// array of objects
				FALSE,			// wait for all objects?
				250);		

	    switch (dwEvent) 
		{ 
			case WAIT_OBJECT_0 + 0: 
			    DWORD num;
				INPUT_RECORD irInBuf; 
				ReadConsoleInput(stdIn, &irInBuf, 1, &num);
				SetConsoleMode(stdIn, saveMode);

				if (num)
					if (irInBuf.EventType == KEY_EVENT && irInBuf.Event.KeyEvent.bKeyDown )
					{
						if (irInBuf.Event.KeyEvent.uChar.AsciiChar == 'n')
						{
							FI.Inc_dir_counter();
							FI.Iterate();
						}
						else if (irInBuf.Event.KeyEvent.uChar.AsciiChar == 's')
						{	
							store = !store;

							if (store)
								printf("Recorder started.\n");
							else
								printf("Recorder halted.\n");
						}
					}

				GetConsoleMode(stdIn, &saveMode);
				SetConsoleMode(stdIn, ENABLE_PROCESSED_INPUT);

				break; 

			case WAIT_OBJECT_0 + 1: 
				DWORD EventDWord;
				DWORD RxBytes;
				DWORD TxBytes;

				FT_GetStatus(ftHandle,
							&RxBytes, 
							&TxBytes, 
							&EventDWord);

				total_RxBytes += RxBytes;

				break; 

			case WAIT_TIMEOUT:
				break;

			case WAIT_FAILED:
				break;

			// Return value is invalid.
			default:
				break;
		}

	}


	/*****************************************/
	Close_FTDI_dev(dev_num, ftHandle);


	/*****************************************/

//	DWORD	i;
//	for (i = 0; i < 2; i++) 
//        CloseHandle(gh[i]); 

	return 0;
}


/*******************************************************************************
*******************************************************************************/
int Handle_parameters(int argc, _TCHAR* argv[], 
					char*			work_dir, 
					int				&dev_num, 
					unsigned long	&rec_size, 
					unsigned long	&start_seq)
{

	/********************************************/
	/*											*/
	/*				Parsing						*/
	/*											*/
	/********************************************/

	char	info_string[500];
	sprintf(info_string, "set the number of recorded bytes	(default: %d)", MAX_RAW_BYTE_LEN);

	struct arg_lit  *help   = arg_lit0(	"h",	"help",					"print this help and exit");
	struct arg_int  *dev    = arg_int0(	"d",	"dev",		"idx",		"set the receiving device			(default: last FTDI device)");
	struct arg_file *dir    = arg_file0("p",	"path",		"path",		"set the output directory path		(default: .)");
	struct arg_int  *start  = arg_int0(	"s",	"start",	"num",		"set the initial seq number			(default: first available)");
	struct arg_int  *recsize= arg_int0(	"r",	"recsize",	"num",		info_string);
	struct arg_end  *end    = arg_end(20);

	void*  argtable[]		= {help, dev, dir, start, recsize, end};

	const char* progname	= argv[0];

	// Verify the argtable[] entries were allocated sucessfully
    if (arg_nullcheck(argtable))
	{
        // NULL entries were detected, some allocations must have failed
        printf("%s: insufficient memory\n", progname);
        return 1;
	}

	// Set any command line default values prior to parsing
	dev->ival[0]		= default_dev;
	dir->filename[0]	= NULL;
	recsize->ival[0]	= MAX_RAW_BYTE_LEN;
	start->ival[0]	= 0;

	// Parse the command line as defined by argtable[]
    int nerrors;
    nerrors = arg_parse(argc, argv, argtable);


	/********************************************/
	/*											*/
	/*				Handling					*/
	/*											*/
	/********************************************/

	// Special case: '--help' takes precedence over error reporting
    if (help->count > 0)
	{
		printf("Usage: %s", progname);
		arg_print_syntax(stdout, argtable, "\n");
		printf("Fast recorder program to save raw samples to disk.\n");
		arg_print_glossary(stdout, argtable,"  %-25s %s\n");
		printf("\nAvailable FTDI devices:\n\n");
		list_ft_devices();
		return 2;
	}

	// If the parser returned any errors then display them and exit
	if (nerrors > 0)
	{
		// Display the error details contained in the arg_end struct
		arg_print_errors(stdout, end, progname);
		printf("Try '%s --help' for more information\n", progname);
		return 1;
	}


	// WORKING DIRECTORY
	if (dir->count > 0)
	{
		
		if (GetFileAttributes(dir->filename[0]) != FILE_ATTRIBUTE_DIRECTORY)
		{
			printf("%s is not a valid directory\n", dir->filename[0]);
			return 1;
		}

		strcpy(work_dir, dir->filename[0]);
	}
	else
		// Get the current working directory
		if( _getcwd( work_dir, _MAX_PATH ) == NULL )
		{
			perror( "ERROR: get current directory" );
			return 1;
		}


	//START SEQUENCE NUMBER
	start_seq = start->ival[0];


	//DEVICE NUMBER
	dev_num = dev->ival[0];


	//RECORDING SIZE
	rec_size = recsize->ival[0]; 



	 // deallocate each non-null entry in argtable[]
    arg_freetable(argtable,sizeof(argtable)/sizeof(argtable[0]));

	return 0;
}


/*******************************************************************************
*
*							      MAIN
*
*******************************************************************************/
int _tmain(int argc, _TCHAR* argv[])
{
	char			work_dir[_MAX_PATH];
	int				error_code;
	int				dev_num;
	unsigned long	rec_size;
	unsigned long	start_seq;
	

	if ( error_code = Handle_parameters(argc, argv, work_dir, dev_num, rec_size, start_seq) )
		return error_code;

//	list_ft_devices();

	Recorder(work_dir, dev_num, rec_size, start_seq);

	return 0;
}
