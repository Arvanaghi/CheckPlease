/*
    Username checker, C
    Module written by Brandon Arvanaghi 
    Website: arvanaghi.com 
    Twitter: @arvanaghi
*/

#include <stdio.h>
#include <Windows.h>

int wmain(int agrc, wchar_t **argv[]) {

	WCHAR* username[3267];
	DWORD charCount[3267];

	if (!GetUserName(username, charCount)) {
		printf("Could not read username, exiting.\n");
		getchar();
		exit(-1);
	}

	if (!wcsicmp(username, argv[1])) {
		printf("Proceed!\n");
	} else {
		wprintf(L"Username: %s", username);
	}

	getchar();
	return 0;
}