package main

import (
	"fmt"
	"strings"
	"os"
)

func main() {
	hostname, errorout := os.Hostname()
	if errorout != nil {
		os.Exit(1)
	}
	if strings.Contains(strings.ToLower(hostname), strings.ToLower(os.Args[1])) {
	    fmt.Println("Proceed!")
	}
}