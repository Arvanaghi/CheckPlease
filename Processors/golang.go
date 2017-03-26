package main

import (
"fmt"
"os"
"runtime"
)

func main() {
num_procs := runtime.NumCPU()
var proc_in int
fmt.Println("Enter the minimum number of processors: ")
_, err := fmt.Scanf("%d", &proc_in)
if err != nil {
os.Exit(1)}
if num_procs >=  proc_in {
    fmt.Println("Put Code Here")
}
}
