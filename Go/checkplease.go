/*
   CheckPlease converted to a library originally by Brandon Arvanaghi
   NOTE this is a windows only library
   Website: arvanaghi.com
   Twitter: @arvanaghi
   Turned to a package by Ahhh
*/

package checkplease

import (
	"encoding/binary"
	"fmt"
	"net"
	"os"
	"path/filepath"
	"runtime"
	"strconv"
	"strings"
	"syscall"
	"time"
	"unsafe"

	"golang.org/x/sys/windows/registry"
)

var (
	kernel32                 = syscall.NewLazyDLL("kernel32.dll")
	CreateToolhelp32Snapshot = kernel32.NewProc("CreateToolhelp32Snapshot")
	Process32First           = kernel32.NewProc("Process32FirstW")
	Process32Next            = kernel32.NewProc("Process32NextW")
	CloseHandle              = kernel32.NewProc("CloseHandle")
	user32                   = syscall.NewLazyDLL("user32.dll")
	getAsyncKeyState         = user32.NewProc("GetAsyncKeyState")
	getCursorPos             = user32.NewProc("GetCursorPos")
)

// MEMORYSTATUSEX is uesed to keep track of memory
type MEMORYSTATUSEX struct {
	dwLength                uint32
	dwMemoryLoad            uint32
	ullTotalPhys            uint64
	ullAvailPhys            uint64
	ullTotalPageFile        uint64
	ullAvailPageFile        uint64
	ullTotalVirtual         uint64
	ullAvailVirtual         uint64
	ullAvailExtendedVirtual uint64
}

// POINT is a struct used for screen position
type POINT struct {
	x, y int32
}

// PROCESSENTRY32 is a struct used for process def
type PROCESSENTRY32 struct {
	dwSize              uint32
	cntUsage            uint32
	th32ProcessID       uint32
	th32DefaultHeapID   uintptr
	th32ModuleID        uint32
	cntThreads          uint32
	th32ParentProcessID uint32
	pcPriClassBase      int32
	dwFlags             uint32
	szExeFile           [260]uint16
}

//ProcessNames Checks all loaded process names, returns false if in a vm
func ProcessNames() bool {
	EvidenceOfSandbox := make([]string, 0)
	sandboxProcesses := [...]string{`vmsrvc`, `tcpview`, `wireshark`, `visual basic`, `fiddler`, `vmware`, `vbox`, `process explorer`, `autoit`, `vboxtray`, `vmtools`, `vmrawdsk`, `vmusbmouse`, `vmvss`, `vmscsi`, `vmxnet`, `vmx_svga`, `vmmemctl`, `df5serv`, `vboxservice`, `vmhgfs`}
	// TH32CS_SNAPPROCESS == 0x00000002, meaning snapshot all processes
	hProcessSnap, _, _ := CreateToolhelp32Snapshot.Call(2, 0)
	if hProcessSnap < 0 {
		fmt.Println("[---] Unable to create Snapshot, exiting.")
		os.Exit(-1)
	}
	defer CloseHandle.Call(hProcessSnap)
	exeNames := make([]string, 0, 100)
	var pe32 PROCESSENTRY32
	pe32.dwSize = uint32(unsafe.Sizeof(pe32))
	Process32First.Call(hProcessSnap, uintptr(unsafe.Pointer(&pe32)))
	for {
		exeNames = append(exeNames, syscall.UTF16ToString(pe32.szExeFile[:260]))
		retVal, _, _ := Process32Next.Call(hProcessSnap, uintptr(unsafe.Pointer(&pe32)))
		if retVal == 0 {
			break
		}
	}
	for _, exe := range exeNames {
		for _, sandboxProc := range sandboxProcesses {
			if strings.Contains(strings.ToLower(exe), strings.ToLower(sandboxProc)) {
				EvidenceOfSandbox = append(EvidenceOfSandbox, exe)
			}
		}
	}
	if len(EvidenceOfSandbox) == 0 {
		return false
	}
	return true
}

//TimezoneUTC checks if time zone is Coordinated Universal Time (UTC), returns true if in a vm
func TimezoneUTC() bool {
	_, offsetFromUTC := time.Now().Zone()
	if offsetFromUTC == 0 {
		return true
	}
	return false
}

//ClickTracker Waits until N mouse clicks occur before executing (default: 10), Go
func ClickTracker(clicks int64) {
	count := 0
	minClicks := int(clicks)
	for count < minClicks {
		leftClick, _, _ := getAsyncKeyState.Call(uintptr(0x1))
		rightClick, _, _ := getAsyncKeyState.Call(uintptr(0x2))
		if leftClick%2 == 1 {
			count++
		}
		if rightClick%2 == 1 {
			count++
		}
	}
	fmt.Printf("Now that the user has clicked %d times, we may proceed with malware execution!\n", minClicks)
}

//CurrentFileName Ensures the current file name is as expected, returns true if in a vm
func CurrentFileName(expectedName string) bool {
	actualName := filepath.Base(os.Args[0])
	if actualName == expectedName {
		return true
	}
	return false
}

//CursorPos Checks if cursor is in same position after sleeping N seconds (default: 20 min), returns true if in a vm
func CursorPos() bool {
	secs := 1200
	if len(os.Args) == 2 {
		secs, _ = strconv.Atoi(os.Args[1])
	}
	point := POINT{}
	getCursorPos.Call(uintptr(unsafe.Pointer(&point)))
	fmt.Printf("x: %d, y: %d\n", int(point.x), int(point.y))
	time.Sleep(time.Duration(secs*1000) * time.Millisecond)
	point2 := POINT{}
	getCursorPos.Call(uintptr(unsafe.Pointer(&point2)))
	fmt.Printf("x: %d, y: %d\n", int(point2.x), int(point2.y))
	if point.x-point2.x == 0 && point.y-point2.y == 0 {
		return true
	}
	return false
}

// DateTrigger Waits until a user-defined date to execute
func DateTrigger(dater string) bool {
	triggerDateRaw, _ := time.Parse("01/02/2006", dater)
	trigYear, trigMonth, trigDay := triggerDateRaw.Date()
	triggerDate := time.Date(trigYear, trigMonth, trigDay, 0, 0, 0, 0, time.Now().Location())
	year, month, day := time.Now().Date()
	today := time.Date(year, month, day, 0, 0, 0, 0, time.Now().Location())
	for today.Before(triggerDate) {
		time.Sleep(time.Duration(86340 * time.Second))
		year, month, day := time.Now().Date()
		today = time.Date(year, month, day, 0, 0, 0, 0, time.Now().Location())
	}
	return false
}

//DetectDebugging checks if process is currently being debugged, returns a bool if detected
func DetectDebugging() bool {
	var kernel32, _ = syscall.LoadLibrary("kernel32.dll")
	var IsDebuggerPresent, _ = syscall.GetProcAddress(kernel32, "IsDebuggerPresent")
	var nargs uintptr = 0
	if debuggerPresent, _, err := syscall.Syscall(uintptr(IsDebuggerPresent), nargs, 0, 0, 0); err != 0 {
		return true
	} else {
		if debuggerPresent != 0 {
			return true
		}
	}
	return false
}

//DiskSize Minimum disk size checker, takes a varriable disk size and returns a bool if the disk is at least that big
func DiskSize(sizer float32) bool {
	minDiskSizeGB := float32(sizer)
	var kernel32 = syscall.NewLazyDLL("kernel32.dll")
	var getDiskFreeSpaceEx = kernel32.NewProc("GetDiskFreeSpaceExW")
	lpFreeBytesAvailable := int64(0)
	lpTotalNumberOfBytes := int64(0)
	lpTotalNumberOfFreeBytes := int64(0)
	getDiskFreeSpaceEx.Call(
		uintptr(unsafe.Pointer(syscall.StringToUTF16Ptr("C:"))),
		uintptr(unsafe.Pointer(&lpFreeBytesAvailable)),
		uintptr(unsafe.Pointer(&lpTotalNumberOfBytes)),
		uintptr(unsafe.Pointer(&lpTotalNumberOfFreeBytes)))
	diskSizeGB := float32(lpTotalNumberOfBytes) / 1073741824
	if diskSizeGB > minDiskSizeGB {
		return true
	}
	return false
}

//FilePathChecker Filepath existence checker returns a bool if it detects any of these drivers or dlls (related to common virtualization platforms)
func FilePathChecker() bool {
	EvidenceOfSandbox := make([]string, 0)
	FilePathsToCheck := [...]string{`C:\windows\System32\Drivers\Vmmouse.sys`,
		`C:\windows\System32\Drivers\vm3dgl.dll`, `C:\windows\System32\Drivers\vmdum.dll`,
		`C:\windows\System32\Drivers\vm3dver.dll`, `C:\windows\System32\Drivers\vmtray.dll`,
		`C:\windows\System32\Drivers\vmci.sys`, `C:\windows\System32\Drivers\vmusbmouse.sys`,
		`C:\windows\System32\Drivers\vmx_svga.sys`, `C:\windows\System32\Drivers\vmxnet.sys`,
		`C:\windows\System32\Drivers\VMToolsHook.dll`, `C:\windows\System32\Drivers\vmhgfs.dll`,
		`C:\windows\System32\Drivers\vmmousever.dll`, `C:\windows\System32\Drivers\vmGuestLib.dll`,
		`C:\windows\System32\Drivers\VmGuestLibJava.dll`, `C:\windows\System32\Drivers\vmscsi.sys`,
		`C:\windows\System32\Drivers\VBoxMouse.sys`, `C:\windows\System32\Drivers\VBoxGuest.sys`,
		`C:\windows\System32\Drivers\VBoxSF.sys`, `C:\windows\System32\Drivers\VBoxVideo.sys`,
		`C:\windows\System32\vboxdisp.dll`, `C:\windows\System32\vboxhook.dll`,
		`C:\windows\System32\vboxmrxnp.dll`, `C:\windows\System32\vboxogl.dll`,
		`C:\windows\System32\vboxoglarrayspu.dll`, `C:\windows\System32\vboxoglcrutil.dll`,
		`C:\windows\System32\vboxoglerrorspu.dll`, `C:\windows\System32\vboxoglfeedbackspu.dll`,
		`C:\windows\System32\vboxoglpackspu.dll`, `C:\windows\System32\vboxoglpassthroughspu.dll`,
		`C:\windows\System32\vboxservice.exe`, `C:\windows\System32\vboxtray.exe`,
		`C:\windows\System32\VBoxControl.exe`}

	for _, FilePath := range FilePathsToCheck {
		if _, err := os.Stat(FilePath); err == nil {
			EvidenceOfSandbox = append(EvidenceOfSandbox, FilePath)
		}
	}
	if len(EvidenceOfSandbox) == 0 {
		return false
	}
	return true

}

//MACAddress checker, returns a bool if it detects a common mac address
func MACAddress() bool {
	EvidenceOfSandbox := make([]net.HardwareAddr, 0)
	badMacAddresses := [...]string{`00:0C:29`, `00:1C:14`, `00:50:56`, `00:05:69`, `08:00:27`}
	NICs, _ := net.Interfaces()
	for _, NIC := range NICs {
		for _, badMacAddress := range badMacAddresses {
			if strings.Contains(strings.ToLower(NIC.HardwareAddr.String()), strings.ToLower(badMacAddress)) {
				EvidenceOfSandbox = append(EvidenceOfSandbox, NIC.HardwareAddr)
			}
		}
	}
	if len(EvidenceOfSandbox) == 0 {
		return false
	}
	return true

}

//RAMCheck checks to see if the host hast at least 1GB of RAM allocated then returns this bool
func RAMCheck() bool {
	var kernel32 = syscall.NewLazyDLL("kernel32.dll")
	var globalMemoryStatusEx = kernel32.NewProc("GlobalMemoryStatusEx")
	var memInfo MEMORYSTATUSEX
	memInfo.dwLength = uint32(unsafe.Sizeof(memInfo))
	globalMemoryStatusEx.Call(uintptr(unsafe.Pointer(&memInfo)))
	if memInfo.ullTotalPhys/1073741824 > 1 { // Greater than 1GB
		return true
	}
	return false
}

//MinRunningProcs Ensures there are more than N processes currently running on the system, returns a bool based on if this many are running
func MinRunningProcs(numProcs int64) bool {
	minRunningProcesses := int(numProcs)
	// TH32CS_SNAPPROCESS == 0x00000002, meaning snapshot all processes
	hProcessSnap, _, _ := CreateToolhelp32Snapshot.Call(2, 0)
	if hProcessSnap < 0 {
		return false
	}
	defer CloseHandle.Call(hProcessSnap)
	exeNames := make([]string, 0, 100)
	var pe32 PROCESSENTRY32
	pe32.dwSize = uint32(unsafe.Sizeof(pe32))
	Process32First.Call(hProcessSnap, uintptr(unsafe.Pointer(&pe32)))
	for {
		exeNames = append(exeNames, syscall.UTF16ToString(pe32.szExeFile[:260]))
		retVal, _, _ := Process32Next.Call(hProcessSnap, uintptr(unsafe.Pointer(&pe32)))
		if retVal == 0 {
			break
		}
	}
	runningProcesses := 0
	for range exeNames {
		runningProcesses++
	}
	if runningProcesses >= minRunningProcesses {
		return true
	}
	return false
}

func getNTPTime() time.Time {
	type ntp_struct struct {
		FirstByte, A, B, C uint8
		D, E, F            uint32
		G, H               uint64
		ReceiveTime        uint64
		J                  uint64
	}
	sock, _ := net.Dial("udp", "us.pool.ntp.org:123")
	sock.SetDeadline(time.Now().Add((2 * time.Second)))
	defer sock.Close()
	ntp_transmit := new(ntp_struct)
	ntp_transmit.FirstByte = 0x1b
	binary.Write(sock, binary.BigEndian, ntp_transmit)
	binary.Read(sock, binary.BigEndian, ntp_transmit)
	return time.Date(1900, 1, 1, 0, 0, 0, 0, time.UTC).Add(time.Duration(((ntp_transmit.ReceiveTime >> 32) * 1000000000)))
}

//GetSleepTime Go sleep acceleration checker via NTP cluster queries
func GetSleepTime() bool {
	firstTime := getNTPTime()
	//fmt.Printf("NTP time (UTC) before sleeping: %+v\n", firstTime)
	sleepSeconds, _ := strconv.Atoi(os.Args[1])
	//fmt.Printf("Attempting to sleep for %+v seconds...\n", sleepSeconds)
	time.Sleep(time.Duration(sleepSeconds*1000) * time.Millisecond)
	secondTime := getNTPTime()
	//fmt.Printf("NTP time (UTC) after sleeping: %+v\n", secondTime)
	difference := secondTime.Sub(firstTime).Seconds()
	//fmt.Printf("Difference in NTP times (should be at least %+v seconds): %+v\n", sleepSeconds, difference)
	if difference >= float64(sleepSeconds) {
		return true
	}
	return false

}

//USBCheck Minimum number of USB devices ever mounted, takes a user supplied int64 and returns a bool if at least that many usbs have been entered
func USBCheck(minCheck int64) bool {
	MinimumUSBHistory := int(minCheck)
	Opened_Key, err := registry.OpenKey(registry.LOCAL_MACHINE, `SYSTEM\ControlSet001\Enum\USBSTOR`, registry.QUERY_VALUE)
	defer Opened_Key.Close()
	keyInfo, err := Opened_Key.Stat()
	if err == nil {
		if int(keyInfo.SubKeyCount) >= MinimumUSBHistory {
			return true
		}
		return false
	}
	return false
}

//ProcessorCheck takes a number of processors and returns a bool if that number exists
func ProcessorCheck(minCheck int64) bool {
	num_procs := runtime.NumCPU()
	minimum_processors_required := int(minCheck)
	if num_procs >= minimum_processors_required {
		return true
	}
	return false
}
