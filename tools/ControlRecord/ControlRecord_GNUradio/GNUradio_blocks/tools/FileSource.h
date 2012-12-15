#include <stdio.h>
#include <time.h>
#include <dirent.h>


class FileSource
{
	public:
		FileSource (char* FileOrDir);
		~FileSource ();

		char SourceEmpty();
		void GetBuffer( size_t N );
		void ClearFromBeginning( unsigned long buff_len );
		void CloseCurrentFile();
		void IterateFileList();


	private:
		void IncreaseBufferSize( unsigned long inc_buff_len );

		DIR					*dir_p;
		struct dirent		*dir_entry_p;
		FILE				*file_p;
		char*				path;
		char*				current_file_full_path;
		size_t				current_file_size;
		size_t				current_file_bytes_read;
		size_t				bytes_read;

		unsigned char*		accum;
		unsigned long		accum_len;
		unsigned long		accum_total_len;

		time_t				previous_time;
};