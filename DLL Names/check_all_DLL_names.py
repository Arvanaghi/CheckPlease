#
#   Checks all DLL names loaded by each process, Python
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

import win32api
import win32process

EvidenceOfSandbox = []
sandboxDLLs = ["sbiedll.dll","dbghelp.dll","api_log.dll","dir_watch.dll","pstorec.dll","vmcheck.dll","wpespy.dll"]

allPids = win32process.EnumProcesses()
for pid in allPids:
    try:
        hProcess = win32api.OpenProcess(0x0410, 0, pid)
        try:
            curProcessDLLs = win32process.EnumProcessModules(hProcess)
            for dll in curProcessDLLs:
                dllName = str(win32process.GetModuleFileNameEx(hProcess, dll)).lower()
                for sandboxDLL in sandboxDLLs:
                    if sandboxDLL in dllName:
                        if dllName not in EvidenceOfSandbox:
                            EvidenceOfSandbox.append(dllName)
        finally:
                win32api.CloseHandle(hProcess)
    except:
            pass

if EvidenceOfSandbox:
    print("The following sandbox-indicative DLLs were discovered loaded in processes running on the system. Do not proceed.\n{0}".format(EvidenceOfSandbox))
else:
    print("No sandbox-indicative DLLs were discovered loaded in any accessible running process. Proceed!")