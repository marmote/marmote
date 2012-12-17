#include <stdio.h>
#include <time.h>
#include <queue>


class CompareStrings 
{
    public:
		bool operator()(char* str1, char* str2);
};


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

		FILE					*file_p;
		char*					current_file_full_path;
		size_t					current_file_size;
		size_t					current_file_bytes_read;
		size_t					bytes_read;

		unsigned char*			accum;
		unsigned long			accum_len;
		unsigned long			accum_total_len;

		time_t					previous_time;

//		std::queue<char*>		filelist;
		std::priority_queue<char*, std::vector<char*>, CompareStrings> filelist;
};