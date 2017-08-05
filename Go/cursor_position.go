/*
    Checks if cursor is in same position after sleeping N seconds (default: 20 min), Go
    Module written by Brandon Arvanaghi 
    Website: arvanaghi.com 
    Twitter: @arvanaghi
*/

package main

import (
	"fmt"
	"strconv"
	"unsafe"
	"time"
	"syscall"
	"os"
)

var (
	user32 = syscall.NewLazyDLL("user32.dll")
	getCursorPos = user32.NewProc("GetCursorPos")
)

type POINT struct {
	x, y int32
}

func main() {

	secs := 1200
	if (len(os.Args) == 2) {
		secs, _ = strconv.Atoi(os.Args[1])
	}

	point := POINT{}
	getCursorPos.Call(uintptr(unsafe.Pointer(&point)))
	fmt.Printf("x: %d, y: %d\n", int(point.x), int(point.y))

	time.Sleep(time.Duration(secs * 1000)  * time.Millisecond)

	point2 := POINT{}
	getCursorPos.Call(uintptr(unsafe.Pointer(&point2)))
	fmt.Printf("x: %d, y: %d\n", int(point2.x), int(point2.y))

	if point.x - point2.x == 0 && point.y - point2.y == 0 {
		fmt.Printf("The cursor has not moved in the last %d seconds. Do not proceed.\n", secs)
	} else {
		fmt.Printf("The cursor is not in the same position as it was %d seconds ago. Proceed!\n", secs)
	}

}