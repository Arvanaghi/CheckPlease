/*
	Filepath existence checker, C
	Module written by Brandon Arvanaghi
	Website: arvanaghi.com
	Twitter: @arvanaghi
*/

#include <stdio.h>
#include <io.h>
#include <tchar.h>
#include "Shlwapi.h"
#pragma comment(lib, "Shlwapi.lib")

#define numFiles 32

int main(int argc, char **argv[]) {

	LPCWSTR filePaths[numFiles] = { L"C:\\windows\\Sysnative\\Drivers\\Vmmouse.sys",
		L"C:\\windows\\Sysnative\\Drivers\\vm3dgl.dll", L"C:\\windows\\Sysnative\\Drivers\\vmdum.dll",
		L"C:\\windows\\Sysnative\\Drivers\\vm3dver.dll", L"C:\\windows\\Sysnative\\Drivers\\vmtray.dll",
		L"C:\\windows\\Sysnative\\Drivers\\vmci.sys", L"C:\\windows\\Sysnative\\Drivers\\vmusbmouse.sys",
		L"C:\\windows\\Sysnative\\Drivers\\vmx_svga.sys", L"C:\\windows\\Sysnative\\Drivers\\vmxnet.sys",
		L"C:\\windows\\Sysnative\\Drivers\\VMToolsHook.dll", L"C:\\windows\\Sysnative\\Drivers\\vmhgfs.dll",
		L"C:\\windows\\Sysnative\\Drivers\\vmmousever.dll", L"C:\\windows\\Sysnative\\Drivers\\vmGuestLib.dll",
		L"C:\\windows\\Sysnative\\Drivers\\VmGuestLibJava.dll", L"C:\\windows\\Sysnative\\Drivers\\vmscsi.sys",
		L"C:\\windows\\Sysnative\\Drivers\\VBoxMouse.sys", L"C:\\windows\\Sysnative\\Drivers\\VBoxGuest.sys",
		L"C:\\windows\\Sysnative\\Drivers\\VBoxSF.sys", L"C:\\windows\\Sysnative\\Drivers\\VBoxVideo.sys",
		L"C:\\windows\\Sysnative\\vboxdisp.dll", L"C:\\windows\\Sysnative\\vboxhook.dll",
		L"C:\\windows\\Sysnative\\vboxmrxnp.dll", L"C:\\windows\\Sysnative\\vboxogl.dll",
		L"C:\\windows\\Sysnative\\vboxoglarrayspu.dll", L"C:\\windows\\Sysnative\\vboxoglcrutil.dll",
		L"C:\\windows\\Sysnative\\vboxoglerrorspu.dll", L"C:\\windows\\Sysnative\\vboxoglfeedbackspu.dll",
		L"C:\\windows\\Sysnative\\vboxoglpackspu.dll", L"C:\\windows\\Sysnative\\vboxoglpassthroughspu.dll",
		L"C:\\windows\\Sysnative\\vboxservice.exe", L"C:\\windows\\Sysnative\\vboxtray.exe",
		L"C:\\windows\\Sysnative\\VBoxControl.exe"};


	int evidenceCount = 0;
	for (int i=0; i < numFiles; ++i) {
		if (PathFileExists(filePaths[i])) {
			wprintf(filePaths[i]);
			wprintf("\n");
			++evidenceCount;
		}
	}

	if (evidenceCount == 0) {
		printf("No files exist on disk that suggest we are running in a sandbox. Proceed!\n");
	}

	getchar();
	return 0;
}
