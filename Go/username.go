package main

import (
	"fmt"
	"strings"
	"os/user"
	"os"
)

func main() {
	username, errorout := user.Current()
	if errorout != nil {
		os.Exit(1)
	}
	if strings.Contains(strings.ToLower(username.Username), strings.ToLower(strings.Join(os.Args[1:]," "))) {
	    fmt.Println("Proceed!")
	}
}