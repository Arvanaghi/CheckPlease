/*
    Minimum number of USB devices ever mounted, Go
    Module written by Brandon Arvanaghi 
    Website: arvanaghi.com 
    Twitter: @arvanaghi
*/

package main

import (
  "fmt"
  "strconv"
  "os"
  "golang.org/x/sys/windows/registry"
)

func main() {
  MinimumUSBHistory := 2

  if (len(os.Args) >= 2) {
      MinimumUSBHistory, _ = strconv.Atoi(os.Args[1])
  }

  Opened_Key, err := registry.OpenKey(registry.LOCAL_MACHINE, `SYSTEM\ControlSet001\Enum\USBSTOR`, registry.QUERY_VALUE)
  defer Opened_Key.Close()

  keyInfo, err := Opened_Key.Stat()

  if (err == nil) {
      if (int(keyInfo.SubKeyCount) >= MinimumUSBHistory) {
          fmt.Println("Proceed!")
      } else {
          fmt.Println("Number of USB devices ever mounted: ", keyInfo.SubKeyCount)
      }
  } 
}