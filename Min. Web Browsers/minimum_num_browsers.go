/*
    Minimum number of web browsers, Go
    Module written by Brandon Arvanaghi 
    Website: arvanaghi.com 
    Twitter: @arvanaghi
*/

package main

import (
	"fmt"
	"golang.org/x/sys/windows/registry"
)

func main() {

	browserCount := 0

	browserKeys := [...]string{`SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe`, `SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\iexplore.exe`,
		`SOFTWARE\Mozilla`}

  for _, browserKey := range browserKeys {
      Opened_Key, err := registry.OpenKey(registry.LOCAL_MACHINE, browserKey, registry.QUERY_VALUE)
      defer Opened_Key.Close()

      if (err == nil) {
          browserCount += 1
      } 

  }

	if browserCount >= 2 {
		fmt.Println("Proceed!")
	} else {
		fmt.Println("Number of Browsers: ", browserCount)
	}

}