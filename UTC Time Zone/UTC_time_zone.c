/*
    Checks if time zone is Coordinated Universal Time (UTC), C
    Module written by Brandon Arvanaghi 
    Website: arvanaghi.com 
    Twitter: @arvanaghi
*/

#include "Windows.h"
#include "stdio.h"

int main(int argc, char** argv[]) {
	TIME_ZONE_INFORMATION timeZone;
	DWORD ret = GetTimeZoneInformation(&timeZone);

	if (ret == TIME_ZONE_ID_INVALID) {
		printf("Unable to retrieve time zone informaiton, exiting.\n");
		getchar();
		exit(-1);
	} else {
		if (!wcscmp(L"Coordinated Universal Time", timeZone.DaylightName) || !wcscmp(L"Coordinated Universal Time", timeZone.StandardName)) {
			wprintf(L"The time zone is Coordinated Universal Time (UTC), do not proceed.\n");
		} else {
			wprintf(L"The time zone is %s. Proceed!\n", timeZone.DaylightName);
		}
	}

	getchar();
	return 0;

}
