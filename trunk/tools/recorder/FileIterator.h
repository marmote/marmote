#pragma once

#include <Windows.h>


class CFile_Iterator
{
	public :
		HANDLE			hFile;
		unsigned long	current_size;


	private :

		char			current_file_name[_MAX_PATH];
		char			work_dir[_MAX_PATH];
		unsigned long	dir_counter;
		unsigned long	seq;


	public :
		CFile_Iterator(char* Working_Directory, unsigned long Starting_Sequence_Number);
		void Close_Current();
		void Iterate();
		void Inc_size(unsigned long add_bytes);
		void Inc_dir_counter();
};