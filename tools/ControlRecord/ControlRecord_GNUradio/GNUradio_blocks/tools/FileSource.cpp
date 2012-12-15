#include "HumanReadableDataSize.h"
#include "FileSource.h"

#include <string.h>

//#include <io.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>


FileSource::FileSource(char* FileOrDir)
	: file_p(NULL),
	dir_p(NULL),
	path(NULL),
	current_file_full_path(NULL),
	current_file_size(0),
	current_file_bytes_read(0),
	bytes_read(0),
	accum(NULL),
	accum_len(0),
	accum_total_len(0)

{
	path = (char*) malloc( strlen(FileOrDir) + 1 );
	strcpy( path, FileOrDir );
    dir_p = opendir(FileOrDir); // Open the current directory		
				

/*	if os.path.isdir(FileOrDir) :
		self.filelist_in = os.listdir(FileOrDir)
		self.filelist_in.sort( key=keynat )

		self.filelist = []
		for ii in range(len(self.filelist_in)) :
			fname = os.path.join( FileOrDir, self.filelist_in[ii] )

			if os.path.isfile(fname) :
				self.filelist.append(fname)
	else :
		self.filelist = [FileOrDir]

	self.file_cnt = -1
*/  
	time( &previous_time );

	IterateFileList();
}


FileSource::~FileSource()
{
	CloseCurrentFile();

	closedir(dir_p);
	free(path);
	free(accum);
}


char FileSource::SourceEmpty()
{
	return (file_p == NULL);
}


void FileSource::GetBuffer( size_t N = 1024 )
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
	if ( difftime( previous_time, current_time ) > 3.0 )
	{
		char BPS_str[100];
		GetHumanReadableDataSize( BPS_str, double(bytes_read) / difftime( previous_time, current_time ) );
		printf("Throughput: %s/s; Progress: %.2f%%", BPS_str, ((double) current_file_bytes_read) / ((double) current_file_size) * 100.0 );

		bytes_read = 0;
		previous_time = current_time;
	}

	return self.accum, self.accum_length
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

	printf("Closed file: %s", current_file_full_path );
	free( current_file_full_path );
	current_file_full_path = NULL;
}


void FileSource::IterateFileList()
{
	CloseCurrentFile();

	if ( !dir_p )
		return;

	while (!file_p)
	{

		if ( !( dir_entry_p = readdir(dir_p) ) ) // read each entry until NULL.
			return;

		current_file_full_path = (char*) malloc( strlen(path) + strlen(dir_entry_p->d_name) + 2 );
		strcpy( current_file_full_path, path );
		if ( path[strlen(current_file_full_path)-1] != '/' )
			strcat( current_file_full_path, "/" );
		strcat( current_file_full_path, dir_entry_p->d_name );


		printf("Opening file: %s", current_file_full_path );
		file_p = fopen( current_file_full_path, "rb" );

		if (!file_p)
		{
			printf("Error opening file: %s", current_file_full_path );
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
		if ( fstat(fileno(file_p), &stbuf) == -1 ) {} 	/* Handle Error */

		current_file_size = (size_t) stbuf.st_size;	// get current file pointer
		current_file_bytes_read = 0;
	}
}


void FileSource::IncreaseBufferSize( unsigned long inc_buff_len )
{
	accum_total_len += inc_buff_len;
	accum = (unsigned char*) realloc( (void*) accum, accum_total_len );
}