/*
    Checks if process is currently being debugged, C
    Module written by Brandon Arvanaghi 
    Website: arvanaghi.com 
    Twitter: @arvanaghi
*/

#include "Windows.h"
#include "Winternl.h"
#include "stdio.h"

typedef NTSTATUS (WINAPI *pNtQueryInformationProcess) (
	HANDLE ProcessHandle,
	PROCESSINFOCLASS ProcessInformationClass,
	PVOID ProcessInformation,
	ULONG ProcessInformationLength,
	PULONG ReturnLength
);

int main(int argc, char *argv[]) {

	PROCESS_BASIC_INFORMATION ProcessInfo;
	// Pointed to Process Environment Block structure
	PPEB pPEB;
	
	// Load in ntdll, get offset of function NtQueryInformationProcess function
	pNtQueryInformationProcess NtQueryInformationProcess = (pNtQueryInformationProcess)GetProcAddress(LoadLibrary(L"ntdll.dll"), "NtQueryInformationProcess");
	// Use function pointer to call NtQueryInformationProcess
	NtQueryInformationProcess(GetCurrentProcess(), ProcessBasicInformation, &ProcessInfo, sizeof(PROCESS_BASIC_INFORMATION), NULL);
	// Store the base address of the PEB from the ProcessInformation struct
	pPEB = (PPEB)ProcessInfo.PebBaseAddress;

	//Check the BeingDebugged member (byte, 0 if not being debugged, 1 if being debugged). 
	if (pPEB->BeingDebugged) {
		printf("A debugger is present, do not proceed.");
	} else {
		printf("No debugger is present. Proceed!");
	}

	getchar();
	return 0;
}