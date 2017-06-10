/*
	Checks if process is currently being debugged, C
	Module written by Brandon Arvanaghi
	Website: arvanaghi.com
	Twitter: @arvanaghi
*/

#include "Windows.h"
#include "Winternl.h"
#include "stdio.h"

int main(int argc, char **argv[]) {

	PPEB pPEB = (PPEB)__readfsdword(0x30);

	if (pPEB->BeingDebugged) {
		printf("A debugger is present, do not proceed.");
	} else {
		printf("No debugger is present. Proceed!");
	}		

	getchar();
	return 0;

}