#
#   Checks all loaded process names, Python
#   Module written by Brandon Arvanaghi
#   Website: arvanaghi.com 
#   Twitter: @arvanaghi
#

import win32pdh

EvidenceOfSandbox = []
sandboxProcesses = "vmsrvc", "tcpview", "wireshark", "visual basic", "fiddler", "vmware", "vbox", "process explorer", "autoit", "vboxtray", "vmtools", "vmrawdsk", "vmusbmouse", "vmvss", "vmscsi", "vmxnet", "vmx_svga", "vmmemctl", "df5serv", "vboxservice", "vmhgfs"

_, runningProcesses = win32pdh.EnumObjectItems(None,None,'process', win32pdh.PERF_DETAIL_WIZARD)

for process in runningProcesses:
    for sandboxProcess in sandboxProcesses:
        if sandboxProcess in str(process):
            EvidenceOfSandbox.append(process)
            break

if not EvidenceOfSandbox:
    print("Proceed!")
else:
    print(EvidenceOfSandbox)