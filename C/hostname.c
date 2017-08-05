/*
    Hostname checker, C
    Module written by Brandon Arvanaghi 
    Website: arvanaghi.com 
    Twitter: @arvanaghi
*/

#include <stdio.h>
#include <Windows.h>

int wmain(int agrc, wchar_t **argv[]) {

	WCHAR* computerName[3267];
	DWORD charCount[3267];

	if (!GetComputerNameW(&computerName, &charCount)) {
		printf("Could not read computer name, exiting.\n");
		getchar();
		exit(-1);
	}

	if (!wcsicmp(computerName, argv[1])) {
		printf("Proceed!\n");
	} else {
		wprintf(L"Hostname: %s", computerName);
	}

	getchar();
	return 0;
}