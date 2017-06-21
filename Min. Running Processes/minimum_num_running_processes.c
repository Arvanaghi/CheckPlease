/*
	Ensures there are more than N processes currently running on the system (default: 50), C
	Ensures at least N processes running on the system (defaults to 50)
	Module written by Brandon Arvanaghi
	Website: arvanaghi.com
	Twitter: @arvanaghi
*/

#include <windows.h>
#include <stdio.h>
#include <psapi.h>

int main(int argc, char **argv[]) {
	int minimumNumberOfProcesses = 50;

	if (argc > 1) {
		minimumNumberOfProcesses = atoi(argv[1]);
	}

	DWORD loadedProcesses[1024];
	DWORD cbNeeded;
	DWORD numProcessesFound;

	// Get all PIDs
	if (!EnumProcesses(loadedProcesses, sizeof(loadedProcesses), &cbNeeded)) {
		printf("[---] Could not get all PIDs, exiting.\n");
		getchar();
		exit(-1);
	}

	// Calculate how many PIDs returned
	numProcessesFound = cbNeeded / sizeof(DWORD);

	if (numProcessesFound >= minimumNumberOfProcesses) {
		printf("Proceed!\n");
	} else {
		printf("%d processes running on this host.\n", numProcessesFound);
	}

	getchar();
	return 0;
}
