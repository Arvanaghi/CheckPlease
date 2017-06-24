/*
	Minimum number of browsers, C
	Module written by Brandon Arvanaghi
	Website: arvanaghi.com
	Twitter: @arvanaghi
*/

#include <Windows.h>
#include <stdio.h>

int main() {
	MEMORYSTATUSEX memStat;

	memStat.dwLength = sizeof(memStat);
	GlobalMemoryStatusEx(&memStat);

	if ((float)memStat.ullTotalPhys / 1073741824 > 1) {
		printf("The RAM of this host is at least 1 GB in size. Proceed!\n");
	} else {
		printf("Less than 1 GB of RAM exists on this system. Do not proceed.\n");
	}

	getchar();
	return 0;
}

