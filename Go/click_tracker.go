/*
    Waits until N mouse clicks occur before executing (default: 10), Go
    Module written by Brandon Arvanaghi 
    Website: arvanaghi.com 
    Twitter: @arvanaghi
*/

package main

import (
	"fmt"
	"strconv"
	"os"
	"syscall"
)

var (
	user32 = syscall.NewLazyDLL("user32.dll")
	getAsyncKeyState = user32.NewProc("GetAsyncKeyState")
)

func main() {

	count := 0;
	minClicks := 10;

	if (len(os.Args) == 2) {
		minClicks, _ = strconv.Atoi(os.Args[1])
	}

	for count < minClicks  {

		leftClick, _, _ := getAsyncKeyState.Call(uintptr(0x1))
		rightClick, _, _ := getAsyncKeyState.Call(uintptr(0x2))

		if leftClick % 2 == 1 {
			count += 1
		}
		if rightClick % 2 == 1 {
			count += 1
		}

	}

	fmt.Printf("Now that the user has clicked %d times, we may proceed with malware execution!\n", minClicks)

}