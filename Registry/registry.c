/*
	Windows Registry key and value checker, C
	Module written by Brandon Arvanaghi
	Website: arvanaghi.com
	Twitter: @arvanaghi
*/

#include <Windows.h>
#include <stdio.h>
#include <Shlwapi.h>
#pragma comment(lib, "Shlwapi.lib")

int main() {
	HKEY hKey;
	int evidenceOfSandbox = 0;

	const char *sandboxStrings[5] = { "VMWare", "virtualbox", "vbox", "qemu", "xen" };

	const char *HKLM_Keys_To_Check_Exist[7] = { "HARDWARE\\DEVICEMAP\\Scsi\\Scsi Port 2\\Scsi Bus 0\\Target Id 0\\Logical Unit Id 0\\Identifier",
		"SYSTEM\\CurrentControlSet\\Enum\\SCSI\\Disk&Ven_VMware_&Prod_VMware_Virtual_S",
		"SYSTEM\\CurrentControlSet\\Control\\CriticalDeviceDatabase\\root#vmwvmcihostdev",
		"SYSTEM\\CurrentControlSet\\Control\\VirtualDeviceDrivers",
		"SOFTWARE\\VMWare, Inc.\\VMWare Tools",
		"SOFTWARE\\Oracle\\VirtualBox Guest Additions",
		"HARDWARE\\ACPI\\DSDT\\VBOX_" };

	const char *HKLM_Keys_With_Values_To_Parse[6][2] = {
	{ "SYSTEM\\ControlSet001\\Services\\Disk\\Enum", "0" },
	{ "HARDWARE\\Description\\System", "SystemBiosInformation" },
	{ "HARDWARE\\Description\\System", "VideoBiosVersion" },
	{ "HARDWARE\\Description\\System\\BIOS", "SystemManufacturer" },
	{ "HARDWARE\\Description\\System\\BIOS", "SystemProductName" },
	{ "HARDWARE\\DEVICEMAP\\Scsi\\Scsi Port 0\\Scsi Bus 0\\Target Id 0", "Logical Unit Id 0" }
	};

	for (int i = 0; i < 7; ++i) {
		if (RegOpenKeyExA(HKEY_LOCAL_MACHINE, HKLM_Keys_To_Check_Exist[i], 0, KEY_READ, &hKey) == ERROR_SUCCESS) {
			printf("%s\n", HKLM_Keys_To_Check_Exist[i]);
			RegCloseKey(hKey);
			++evidenceOfSandbox;
		}
	}

	for (int i = 0; i < 6; ++i) {
		HKEY hKey;
		TCHAR buff[1024] = { 0 };
		DWORD buffSize = 1024;
		if (RegOpenKeyExA(HKEY_LOCAL_MACHINE, HKLM_Keys_With_Values_To_Parse[i][0], 0, KEY_READ, &hKey) == ERROR_SUCCESS) {
			if (RegQueryValueExA(hKey, HKLM_Keys_With_Values_To_Parse[i][1], NULL, NULL, (LPBYTE)buff, &buffSize) == ERROR_SUCCESS) {
				for (int j = 0; j < 5; ++j) {
					if (StrStrIA(buff, sandboxStrings[j]) != NULL) {
						printf("%s\\%s --> %s \n", HKLM_Keys_With_Values_To_Parse[i][0], HKLM_Keys_With_Values_To_Parse[i][1], buff);
						++evidenceOfSandbox;
					}
				}
			}
			RegCloseKey(hKey);
		}
	}
	
	if (evidenceOfSandbox == 0) {
		printf("Proceed!\n");
	}

	getchar();

	return 0;
}

