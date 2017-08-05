package main

import (
	"fmt"
	"strconv"
	"os"
	"runtime"
)

func main() {
	num_procs := runtime.NumCPU()
	minimum_processors_required, _ := strconv.Atoi(os.Args[1])
	if num_procs >= minimum_processors_required {
	    fmt.Println("Proceed!")
	}
}