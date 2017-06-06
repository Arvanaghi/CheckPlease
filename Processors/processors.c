/*
	Minimum number of Processors, C
	Module written by Brandon Arvanaghi
	Website: arvanaghi.com
	Twitter: @arvanaghi
*/

#include <Windows.h>
#include <stdio.h>

int main(int argc, char **argv[]) {
	int minProcessors = 2;
	if (argc > 1) {
		minProcessors = atoi(argv[1]);
	}

	SYSTEM_INFO systemInfo;
	GetSystemInfo(&systemInfo);
	int numProcessors = systemInfo.dwNumberOfProcessors;

	if (numProcessors >= minProcessors) {
		printf("Number of processors: %d\n", numProcessors);
		printf("Proceed!\n");
	} else {
		printf("Number of processors: %d\n", numProcessors);
	}
	
	getchar();
	return 0;
}