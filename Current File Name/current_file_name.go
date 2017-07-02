/*
    Ensures the current file name is as expected, Go
    Module written by Brandon Arvanaghi 
    Website: arvanaghi.com 
    Twitter: @arvanaghi
*/

package main

import (
  "fmt"
  "os"
  "path/filepath"
)

func main() {

	expectedName := ""

	if (len(os.Args) != 2) {
		fmt.Println("You must provide a file name to check for.")
		os.Exit(1)
	} else {
		expectedName = os.Args[1]
	}

	actualName := filepath.Base(os.Args[0])

	if actualName == expectedName {
		fmt.Printf("The file name is %s as expected. Proceed!\n", actualName)
	} else {
		fmt.Printf("The file name %s, not %s as expected. Do not proceed.\n", actualName, expectedName)
	}

}