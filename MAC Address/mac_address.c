/*
    MAC address checker, C
    Most code taken from https://msdn.microsoft.com/en-us/library/windows/desktop/aa366062(v=vs.85).aspx
    Module written by Brandon Arvanaghi 
    Website: arvanaghi.com 
    Twitter: @arvanaghi
*/

#include <winsock2.h>
#include <iphlpapi.h>
#include <stdio.h>
#pragma comment(lib, "IPHLPAPI.lib")

int main(int argc, char** argv[]) {
	boolean evidenceOfSandbox;
	PIP_ADAPTER_INFO pAdapterInfo;
	PIP_ADAPTER_INFO pAdapter = NULL;

	// First three bytes of known Virtual Machine MAC addresses (e.g. 00-0C-29...)
	unsigned char badMacAddresses[5][3] = {
		{ 0x00, 0x0C, 0x29 },
		{ 0x00, 0x1C, 0x14 },
		{ 0x00, 0x50, 0x56 },
		{ 0x00, 0x05, 0x69 },
		{ 0x08, 0x00, 0x27 }
	};

	ULONG ulOutBufLen = sizeof(IP_ADAPTER_INFO);
	pAdapterInfo = (IP_ADAPTER_INFO *)malloc(sizeof(IP_ADAPTER_INFO));

	// Make an initial call to GetAdaptersInfo to get the necessary size into the ulOutBufLen variable
	if (GetAdaptersInfo(pAdapterInfo, &ulOutBufLen) == ERROR_BUFFER_OVERFLOW) {
		free(pAdapterInfo);
		pAdapterInfo = (IP_ADAPTER_INFO *)malloc(ulOutBufLen);
	}

	if (GetAdaptersInfo(pAdapterInfo, &ulOutBufLen) == NO_ERROR) {
		pAdapter = pAdapterInfo;
		while (pAdapter) { // for each adapter
			for (int i = 0; i < 5; ++i) { // check each row of bad MAC address table
				if (!memcmp(badMacAddresses[i], pAdapter->Address, 3)) {
					for (int j = 0; j < pAdapter->AddressLength; ++j) {
						if (j == (pAdapter->AddressLength - 1)) {
							printf("%.2X\n", (int)pAdapter->Address[j]);
						} else {
							printf("%.2X-", (int)pAdapter->Address[j]);
						}
					}
					evidenceOfSandbox = TRUE;
				}
			}

			pAdapter = pAdapter->Next;
		}
	} else { // GetAdaptersInfo failed
		printf("[---] GetAdaptersInfo failed, exiting.\n");
		exit(-1);
		getchar();
	}

	if (pAdapterInfo) {
		free(pAdapterInfo);
	}
		
	if (!evidenceOfSandbox) {
		printf("No MAC addresses match known virtual machine MAC addresses. Proceed!\n");
	}

	getchar();
	return 0;
}
