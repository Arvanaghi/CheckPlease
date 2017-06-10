/*
	Prevents a debugger from attaching to this process after it has been loaded, C
	Module written by Brandon Arvanaghi
	Website: arvanaghi.com
	Twitter: @arvanaghi
*/

#include "Windows.h"
#include "Winternl.h"
#include "stdio.h"

int main(int argc, char **argv[]) {

	PPEB pPEB = (PPEB)__readfsdword(0x30);

	// Pretend process is already being debugged by setting PEB's BeingDebugged byte to 1
	// Only one debugger can attach to a process at a time.
	pPEB->BeingDebugged = 1;

	printf("The Process Environment Block's \"BeingDebugged\" field is set. Proceed!")

	getchar();
	return 0;

}