/*
    MAC address checker, Go
    Module written by Brandon Arvanaghi 
    Website: arvanaghi.com 
    Twitter: @arvanaghi
*/

package main

import (
  "fmt"
  "net"
  "strings"
)

func main() {

  EvidenceOfSandbox := make([]net.HardwareAddr, 0)

  badMacAddresses := [...]string{`00:0C:29`, `00:1C:14`, `00:50:56`, `00:05:69`, `08:00:27`}

  NICs, _ := net.Interfaces()
  for _, NIC := range NICs {
    for _, badMacAddress := range badMacAddresses {
      if strings.Contains(strings.ToLower(NIC.HardwareAddr.String()), strings.ToLower(badMacAddress)) {
        EvidenceOfSandbox = append(EvidenceOfSandbox, NIC.HardwareAddr)
      }
    }   
  }

  if len(EvidenceOfSandbox) == 0 {
    fmt.Println("Proceed!")
  } else {
    fmt.Println(EvidenceOfSandbox)
  }

}
