/*
		Minimum disk size checker (default: 50 GB), Go
		Module written by Brandon Arvanaghi
		Website: arvanaghi.com 
		Twitter: @arvanaghi
*/

package main

import (
	"fmt"
	"syscall"
	"strconv"
	"os"
	"unsafe"
)

func main() {

	minDiskSizeGB := float32(50.0)

	if (len(os.Args) > 1) {
		val, _ := strconv.ParseFloat(os.Args[1], 32)
		minDiskSizeGB = float32(val)
	}

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


	diskSizeGB := float32(lpTotalNumberOfBytes)/1073741824

	if (diskSizeGB > minDiskSizeGB) {
		fmt.Printf("The disk size of this host is %f GB, which is greater than the minimum you set of %f GB. Proceed!\n", diskSizeGB, minDiskSizeGB)
	} else {
		fmt.Printf("The disk size of this host is %f GB, which is less than the minimum you set of %f GB. Do not proceed.\n", diskSizeGB, minDiskSizeGB)
	}

}