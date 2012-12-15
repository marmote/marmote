#include <stdio.h>


void GetHumanReadableDataSize(char* str, double size, unsigned char precision)
{
	char suffixes[9][3] = {"B","KB","MB","GB","TB","PB","EB","ZB","YB"};
    unsigned char suffixIndex = 0;

    while ( size > 1024.0 && suffixIndex < 8 )
	{
        suffixIndex += 1;	//increment the index of the suffix
        size /= 1024.0;		//apply the division
	}

    sprintf( str, "%.*f %s", precision, size, suffixes[suffixIndex] );
}