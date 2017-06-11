/*
    Checks if process is currently being debugged, Go
    Module written by Brandon Arvanaghi
    Website: arvanaghi.com 
    Twitter: @arvanaghi
*/

package main

import (
	"fmt"
	"syscall"
)

func main() {
	var kernel32, _ = syscall.LoadLibrary("kernel32.dll")
	var IsDebuggerPresent, _ = syscall.GetProcAddress(kernel32, "IsDebuggerPresent")
	var nargs uintptr = 0

	if debuggerPresent, _, err := syscall.Syscall(uintptr(IsDebuggerPresent), nargs, 0, 0, 0); err != 0 {
		fmt.Printf("Error determining whether debugger present.\n")
	} else {
		if (debuggerPresent != 0) {
			fmt.Print("A debugger is present, do not proceed.\n")
		} else {
			fmt.Printf("No debugger is present. Proceed!\n")
		}
	}
	
}
