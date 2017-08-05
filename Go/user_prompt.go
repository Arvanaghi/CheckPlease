/*
    Prompts user with dialog box and waits for response before executing, Go
    Module written by Brandon Arvanaghi 
    Website: arvanaghi.com 
    Twitter: @arvanaghi
*/

package main

import (
	"fmt"
	"syscall"
	"unsafe"
	"os"
)

func main() {

	var dialogBoxTitle = "CheckPlease by @arvanaghi and @ChrisTruncer";
	var dialogBoxMessage = "This is a sample dialog box to ensure user activity!"

	if (len(os.Args) == 3) {
		dialogBoxTitle = os.Args[1]
		dialogBoxMessage = os.Args[2]
	}

	var user32dll = syscall.NewLazyDLL("user32.dll")
	var messageBoxW = user32dll.NewProc("MessageBoxW")

	messageBoxW.Call(0,
		uintptr(unsafe.Pointer(syscall.StringToUTF16Ptr(dialogBoxMessage))),
		uintptr(unsafe.Pointer(syscall.StringToUTF16Ptr(dialogBoxTitle))),
		0)

	fmt.Println("Now that the user has clicked \"OK\" or closed the dialog box, we will proceed with malware execution!")

}