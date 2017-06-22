/*
    Checks all DLL names loaded by each process, C
    Module written by Brandon Arvanaghi 
    Website: arvanaghi.com 
    Twitter: @arvanaghi
*/

#include <windows.h>
#include <stdio.h>
#include <psapi.h>

#define numSandboxDLLs 7

WCHAR* sandboxDLLs[numSandboxDLLs] = { L"sbiedll.dll", L"dbghelp.dll", L"api_log.dll", L"dir_watch.dll", L"pstorec.dll", L"vmcheck.dll", L"wpespy.dll" };

int main(void) {
	DWORD loadedProcesses[1024];
	DWORD cbNeeded;
	DWORD cProcesses;
	unsigned int i;

	// Get all PIDs
	if (!EnumProcesses(loadedProcesses, sizeof(loadedProcesses), &cbNeeded)) {
		printf("[---] Could not get all PIDs, exiting.\n");
		getchar();
		exit(-1);
	}

	// Calculate how many PIDs returned
	cProcesses = cbNeeded / sizeof(DWORD);

	// Check all loaded DLLs
	HANDLE hProcess;
	int evidenceCount = 0;
	for (i = 0; i < cProcesses; i++) {
		HMODULE hMods[1024];

		// Get a handle to the process.
		hProcess = OpenProcess(PROCESS_QUERY_INFORMATION | PROCESS_VM_READ, FALSE, loadedProcesses[i]);
		if (hProcess != NULL) {

			// Get a list of all the modules in this process.
			if (EnumProcessModules(hProcess, hMods, sizeof(hMods), &cbNeeded)) {
				for (int i = 0; i < (cbNeeded / sizeof(HMODULE)); i++) {
					TCHAR szModName[MAX_PATH];
					// Get the full path to the module's file.
					if (GetModuleFileNameEx(hProcess, hMods[i], szModName, sizeof(szModName) / sizeof(TCHAR))) {
						for (int j = 0; j<numSandboxDLLs; ++j) {
							if (wcsstr(szModName, sandboxDLLs[j])) {
								CHAR processName[MAX_PATH];
								GetProcessImageFileNameA(hProcess, &processName, MAX_PATH);
								printf("Process name: %s\n", processName);
								wprintf(L"\t DLL loaded: %s\n", szModName);
								
								++evidenceCount;
							}
						}
					}
				}
			}
			CloseHandle(hProcess);
		} // if hProcess != NULL 	
	} // for each process

	if (evidenceCount == 0) {
		printf("No sandbox-indicative DLLs were discovered loaded in any accessible running process. Proceed!\n");
	}

	getchar();
	return 0;
}

