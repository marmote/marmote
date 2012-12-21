#include "HumanReadableDataSize.h"
//#include "strnatcmp.h"
#include "strnatcmp.h"

#include "FileSource.h"

#include <stdlib.h>
#include <string.h>

#include <dirent.h>

//#include <io.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>




bool CompareStrings::operator()(char* str1, char* str2)
// Returns true if t1 is earlier than t2
{
	return strnatcmp(str1, str2) >= 0;
}



FileSource::FileSource(char* FileOrDir)
	: file_p(NULL),
	current_file_full_path(NULL),
	current_file_size(0),
	current_file_bytes_read(0),
	bytes_read(0),
	accum(NULL),
	accum_len(0),
	accum_total_len(0)

{
	struct stat		stbuf;

	if( stat( FileOrDir, &stbuf ) == -1 )
	{
		printf("Unable to get information on file or directory: %s\n", FileOrDir);
		goto l1;
	}

	if ( S_ISDIR(stbuf.st_mode) )
	{
		DIR				*dir_p;

		dir_p = opendir(FileOrDir); // Open the current directory		

		if ( dir_p )
		{
			struct dirent	*dir_entry_p;

			while ( dir_entry_p = readdir(dir_p) ) // read each entry until NULL.
			{
				if ( !strcmp( dir_entry_p->d_name, "." ) || !strcmp( dir_entry_p->d_name, ".." ) )
					continue;

//				printf("Allocating memory for \"temp\" in dir listing, size: %d\n", (int) (strlen(FileOrDir) + strlen(dir_entry_p->d_name) + 2) );

				char*	temp = (char*) malloc( strlen(FileOrDir) + strlen(dir_entry_p->d_name) + 2 );

				strcpy( temp, FileOrDir );
				if ( temp[strlen(temp)-1] != '/' )
					strcat( temp, "/" );
				strcat( temp, dir_entry_p->d_name );


				if( stat( temp, &stbuf ) == -1 )
					goto cont;

				if ( !S_ISREG(stbuf.st_mode) )
					goto cont;

				filelist.push( temp );
				continue;
cont:
//				printf("Freeing memory for \"temp\" in dir listing because of error.\n" );
				free(temp);
			}

			closedir(dir_p);
		}
	}
	else if ( S_ISREG(stbuf.st_mode) )
	{
//		printf("Allocating memory for \"temp\" in file listing, size: %d\n", (int) (strlen(FileOrDir) + 1) );
		char*	temp = (char*) malloc( strlen(FileOrDir) + 1 );

		strcpy( temp, FileOrDir );

		filelist.push( temp );
	}
	else
		printf("Specified path is neither a file nor a directory: %s\n", FileOrDir);

l1:
	IterateFileList();

	time( &previous_time );
}


FileSource::~FileSource()
{
	CloseCurrentFile();

//	printf("Freeing memory for \"accum\" in destructor.\n" );
	free(accum);
	accum = NULL;

	while ( !filelist.empty() )
	{
//		printf("Freeing memory for \"filelist\" in destructor.\n" );
		free(filelist.top());
		filelist.pop();
	}
}


char FileSource::SourceEmpty()
{
	return (file_p == NULL);
}


fs_ret_t FileSource::GetBuffer( size_t N = 1024 )
{
	while ( !SourceEmpty() && accum_len < N )
	{
		size_t N_new = N - accum_len;

		// Check to see if the buffer is large enough, if not increase size
		unsigned long worst_case_size = accum_len + N;
		if ( accum_total_len < worst_case_size )
			IncreaseBufferSize( worst_case_size - accum_total_len );


		size_t successfully_read_bytes = sizeof(unsigned char) * fread ( (void*) (accum + accum_len), sizeof(unsigned char), N_new, file_p );

		if ( successfully_read_bytes == 0 )
		{
			IterateFileList();
			continue;
		}

		accum_len += successfully_read_bytes;
            
		current_file_bytes_read += successfully_read_bytes;
		bytes_read += successfully_read_bytes;
	}
            
	time_t current_time = time( NULL );
	if ( difftime( current_time, previous_time ) > 3.0 )
	{
		char BPS_str[100];
		GetHumanReadableDataSize( BPS_str, double(bytes_read) / difftime( current_time, previous_time ) );
		printf("Throughput: %s/s; Progress: %.2f%%\n", BPS_str, ((double) current_file_bytes_read) / ((double) current_file_size) * 100.0 );

		bytes_read = 0;
		previous_time = current_time;
	}

	fs_ret_t ret_s;
	ret_s.accum = accum;
	ret_s.accum_len = accum_len;
	ret_s.accum_total_len = accum_total_len;
	return ret_s;
}


void FileSource::ClearFromBeginning( unsigned long buff_len )
{
	buff_len = buff_len < accum_len ? buff_len : accum_len;

	memmove( (void*) accum, (void*) (accum + buff_len), accum_len - buff_len );

	accum_len -= buff_len;
}


void FileSource::CloseCurrentFile()
{
	if ( !file_p )
		return;

	fclose( file_p );
    file_p = NULL;

	if ( !current_file_full_path )
		return;

	printf("Closed file: %s\n", current_file_full_path );
//	printf("Freeing memory for \"current_file_full_path\" in CloseCurrentFile.\n" );
	free( current_file_full_path );
	current_file_full_path = NULL;
}


void FileSource::IterateFileList()
{
	CloseCurrentFile();

	while (!file_p && !filelist.empty())
	{
		current_file_full_path = filelist.top();

		filelist.pop();


		printf("Opening file: %s\n", current_file_full_path );
		file_p = fopen( current_file_full_path, "rb" );

		if (!file_p)
		{
			printf("Error opening file: %s\n", current_file_full_path );
//			printf("Freeing memory for \"current_file_path\" in IterateFileList because file open error.\n" );
			free( current_file_full_path );
			current_file_full_path = NULL;
			continue;
		}


// The so called fseek/ftell dance
// http://www.aquaphoenix.com/ref/gnu_c_library/libc_68.html
// http://stackoverflow.com/questions/8621544/interaction-of-posix-file-descriptors-and-c-files
// http://stackoverflow.com/questions/9830788/how-to-get-file-size-in-ansi-c-without-fseek-and-ftell
//
//		fseek(file_p, 0, SEEK_END);			// seek to end of file
//		current_file_size = ftell(file_p);	// get current file pointer
//		fseek(file_p, 0, SEEK_SET);			// seek back to beginning of file

		struct stat stbuf;
		if ( fstat(fileno(file_p), &stbuf) == -1 ) {} 	// Handle Error 

		current_file_size = (size_t) stbuf.st_size;	// get current file pointer
		current_file_bytes_read = 0;
	}
}


void FileSource::IncreaseBufferSize( unsigned long inc_buff_len )
{
	accum_total_len += inc_buff_len;
//	printf("Reallocating memory for \"accum\" in increase buffer, size: %d\n", (int) accum_total_len );
	accum = (unsigned char*) realloc( (void*) accum, accum_total_len );
}