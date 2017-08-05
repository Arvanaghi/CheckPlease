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
	int minNumProcesses = 50;

	if (argc > 1) {
		minNumProcesses = atoi(argv[1]);
	}

	DWORD loadedProcesses[1024];
	DWORD cbNeeded;
	DWORD runningProcesses;

	// Get all PIDs
	if (!EnumProcesses(loadedProcesses, sizeof(loadedProcesses), &cbNeeded)) {
		printf("[---] Could not get all PIDs, exiting.\n");
		getchar();
		exit(-1);
	}

	// Calculate how many PIDs returned
	runningProcesses = cbNeeded / sizeof(DWORD);

	if (runningProcesses >= minNumProcesses) {
		printf("There are %d processes running on the system, which satisfies the minimum you set of %d. Proceed!\n", runningProcesses, minNumProcesses);
	} else {
		printf("Only %d processes are running on the system, which is less than the minimum you set of %d. Do not proceed.\n", runningProcesses, minNumProcesses);
	}

	getchar();
	return 0;
}
