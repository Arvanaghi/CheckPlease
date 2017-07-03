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

  minDiskSizeGB := 50

  if (len(os.Args) > 1) {
    minDiskSizeGB, _ = strconv.Atoi(os.Args[1])
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

  if (diskSizeGB > float32(minDiskSizeGB)) {
    fmt.Printf("The disk size of this host is %f GB, which is greater than the minimum you set of %d GB. Proceed!\n", diskSizeGB, minDiskSizeGB)
  } else {
    fmt.Printf("The disk size of this host is %f GB, which is less than the minimum you set of %d GB. Do not proceed.\n", diskSizeGB, minDiskSizeGB)
  }

}