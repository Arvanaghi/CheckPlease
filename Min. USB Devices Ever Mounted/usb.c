/*
	Minimum number of USB devices ever mounted, C
	Module written by Brandon Arvanaghi
	Website: arvanaghi.com
	Twitter: @arvanaghi
*/

#include <Windows.h>
#include <stdio.h>

int main(int argc, char **argv[]) {
	HKEY hKey;
	// Baseline number of USBs ever mounted
	int MinimumUsbHistory = 2;
	// To store actual number of USBs ever mounted
	DWORD numUsbDevices = 0;

	// If user supplies a different baseline
	if (argc > 1) {
		MinimumUsbHistory = atoi(argv[1]);
	}

	if (RegOpenKeyExA(HKEY_LOCAL_MACHINE, "SYSTEM\\ControlSet001\\Enum\\USBSTOR", 0, KEY_READ, &hKey) == ERROR_SUCCESS) {

		// Get number of subkeys, which corresponds to history of mounted USB devices
		if (RegQueryInfoKeyA(hKey, NULL, NULL, NULL, &numUsbDevices, NULL, NULL, NULL, NULL, NULL, NULL, NULL) == ERROR_SUCCESS) {
			// Do nothing
		} else {
			printf("[---] Unable to query subkey HKLM::SYSTEM\\ControlSet001\\Enum\\USBSTOR\n");
			getchar();
			exit(-1);
		}
	} else {
		printf("[---] Unable to open subkey HKLM::SYSTEM\\ControlSet001\\Enum\\USBSTOR\n");
		getchar();
		exit(-1);
	}


	if (numUsbDevices >= MinimumUsbHistory) {
		printf("Number of USB devices ever mounted: %d\n", numUsbDevices);
		printf("Proceed!\n");
	} else {
		printf("Number of USB devices ever mounted: %d\n", numUsbDevices);
	}

	getchar();
	return 0;
}

