/*
    Checks all loaded process names, C
    Module written by Brandon Arvanaghi
    Website: arvanaghi.com 
    Twitter: @arvanaghi
*/

#include "stdio.h"
#include "Windows.h"
#include "tlhelp32.h"

#define numSandboxProcesses 21

WCHAR* sandboxProcesses[numSandboxProcesses] = { L"vmsrvc", L"tcpview", L"wireshark", L"visual basic", L"fiddler", L"vmware", L"vbox", L"process explorer", L"autoit", L"vboxtray", L"vmtools", L"vmrawdsk", L"vmusbmouse", L"vmvss", L"vmscsi", L"vmxnet", L"vmx_svga", L"vmmemctl", L"df5serv", L"vboxservice", L"vmhgfs" };

// Main
int wmain(int argc, wchar_t *argv[]) {
	HANDLE hProcessSnap;
	HANDLE hProcess;
	PROCESSENTRY32 pe32;
	DWORD dwPriorityClass;

	// Take a snapshot of all processes in the system.
	hProcessSnap = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
	if (hProcessSnap == INVALID_HANDLE_VALUE) {
		printf("Could not create snapshot, exiting.\n");
		getchar();
		exit(-1);
	}

	// Set the size of the structure before using it.
	pe32.dwSize = sizeof(PROCESSENTRY32);

	// Retrieve information about the first process, exit if unsuccessful
	if (!Process32FirstW(hProcessSnap, &pe32)) {
		printf("Could not retrieve information about processes, exiting.");
		CloseHandle(hProcessSnap);
		getchar();
		exit(-1);
	}

	// Walk the snapshot of processes, find bad ones
	int evidenceCount = 0;
	do {

		for (int i = 0; i < numSandboxProcesses; ++i) {
			if (wcsstr(pe32.szExeFile, sandboxProcesses[i])) {
				wprintf(L"%s\n", pe32.szExeFile);
				++evidenceCount;
			}
		}

	} while (Process32NextW(hProcessSnap, &pe32));

	if (evidenceCount == 0) {
		printf("Proceed!\n");
	}

	getchar();

	return 0;
}
