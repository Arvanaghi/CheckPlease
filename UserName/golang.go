package main

import (
"bufio"
"fmt"
"strings"
"os/user"
"os"
)

func main() {
username, errorout := user.Current()
if errorout != nil {
os.Exit(1)}
fmt.Print("Enter the username you want to check for: ")
reader := bufio.NewReader(os.Stdin)
text, _ := reader.ReadString('\n')
text = strings.Replace(text, "\n", "", -1)
if strings.Contains(strings.ToLower(username.Username), strings.ToLower(text)) {
    fmt.Println("Put Code Here")
}
}