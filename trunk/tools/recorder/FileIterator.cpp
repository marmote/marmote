#define _CRT_SECURE_NO_WARNINGS

#include "FileIterator.h"
#include <stdio.h>


CFile_Iterator::CFile_Iterator(char* Working_Directory, unsigned long Starting_Sequence_Number) :
	hFile(INVALID_HANDLE_VALUE),
	current_size(0),
	dir_counter(0),
	seq(Starting_Sequence_Number)
{
	strcpy(current_file_name, "");
	strcpy(work_dir, ".");
	strcpy(work_dir, Working_Directory);
}


void CFile_Iterator::Close_Current()
{
	if (hFile != INVALID_HANDLE_VALUE)
	{
		CloseHandle(hFile);
		hFile = INVALID_HANDLE_VALUE;
		printf("%s (%d bytes).\n", current_file_name, current_size);
	}
}


#define FNAME_FMT "rec_%03d.bin"

void CFile_Iterator::Iterate()
{
	static unsigned short	seq = 0;


	Close_Current();

	char	dir[_MAX_PATH];


	while (1)
	{
		if (dir_counter)
			sprintf( dir, "%s\\%d", work_dir, dir_counter );
		else
			strcpy( dir, work_dir );


		if ( CreateDirectory( dir, 0 ) )
		{
			printf("Created directory: %s\n", dir);
			break;
		}

		if ( GetLastError() == ERROR_ALREADY_EXISTS )
			break;

		printf("Couldn't create directory: %s\n", dir);
		dir_counter++;
	}


	while (hFile == INVALID_HANDLE_VALUE)
	{
		sprintf(current_file_name, "%s\\" FNAME_FMT, dir, seq); 
		seq++;

		printf("Trying to open %s... ", current_file_name);

		hFile = CreateFile(current_file_name,
								GENERIC_WRITE,
								0,
								NULL,
								CREATE_NEW,
								0,
								NULL);

		if (hFile == INVALID_HANDLE_VALUE)
			printf("Failure.\n");
	}

	printf("Succes.\n");

	current_size = 0;
}


void CFile_Iterator::Inc_size(unsigned long add_bytes)
{
	current_size += add_bytes;
}


void CFile_Iterator::Inc_dir_counter()
{
	dir_counter++;
}
