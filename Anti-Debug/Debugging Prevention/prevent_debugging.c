/*
    Prevents process from being debugged, C
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

	// Pretend process is already being debugged by setting PEB's BeingDebugged byte to 1
	// Only one debugger can attach to a process at a time.
	pPEB->BeingDebugged = 0x11;

	printf("The Process Environment Block's \"BeingDebugged\" field is set. Proceed!")

	getchar();
	return 0;
}