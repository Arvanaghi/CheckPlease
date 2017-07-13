/*
    Windows Registry Key and Value Checker, Go
    Module written by Brandon Arvanaghi 
    Website: arvanaghi.com 
    Twitter: @arvanaghi
*/

package main

import (
    "fmt"
    "path/filepath"
    "strings"
    "golang.org/x/sys/windows/registry"
)

func main() {

    EvidenceOfSandbox := make([]string, 0)

    sandboxStrings := [...]string{`vmware`, `virtualbox`, `vbox`, `qemu`, `xen`}

    HKLM_Keys_To_Check_Exist := [...]string{`HARDWARE\DEVICEMAP\Scsi\Scsi Port 2\Scsi Bus 0\Target Id 0\Logical Unit Id 0\Identifier`,
    `SYSTEM\CurrentControlSet\Enum\SCSI\Disk&Ven_VMware_&Prod_VMware_Virtual_S`,
    `SYSTEM\CurrentControlSet\Control\CriticalDeviceDatabase\root#vmwvmcihostdev`,
    `SYSTEM\CurrentControlSet\Control\VirtualDeviceDrivers`,
    `SOFTWARE\VMWare, Inc.\VMWare Tools`,
    `SOFTWARE\Oracle\VirtualBox Guest Additions`,
    `HARDWARE\ACPI\DSDT\VBOX_`}

    HKLM_Keys_With_Values_To_Parse := [...]string{`SYSTEM\ControlSet001\Services\Disk\Enum\0`,
    `HARDWARE\Description\System\SystemBiosInformation`,
    `HARDWARE\Description\System\VideoBiosVersion`,
    `HARDWARE\Description\System\BIOS\SystemManufacturer`,
    `HARDWARE\Description\System\BIOS\SystemProductName`,
    `HARDWARE\DEVICEMAP\Scsi\Scsi Port 0\Scsi Bus 0\Target Id 0\Logical Unit Id 0`}

    for _, HKLM_Key := range HKLM_Keys_To_Check_Exist {
        Opened_Key, err := registry.OpenKey(registry.LOCAL_MACHINE, HKLM_Key, registry.QUERY_VALUE)
        defer Opened_Key.Close()

        if (err == nil) {
            EvidenceOfSandbox = append(EvidenceOfSandbox, `HKLM:\` + HKLM_Key)
        } 

    }

    for _, HKLM_Key := range HKLM_Keys_With_Values_To_Parse {
        Opened_Key, err := registry.OpenKey(registry.LOCAL_MACHINE, filepath.Dir(HKLM_Key), registry.QUERY_VALUE)
        defer Opened_Key.Close()

        if (err == nil) {
            regValue, _, err := Opened_Key.GetStringValue(filepath.Base(HKLM_Key))
            if (err == nil) {
                for _, sandboxString := range sandboxStrings {
                    if strings.Contains(strings.ToLower(regValue), strings.ToLower(sandboxString)) {
                        EvidenceOfSandbox = append(EvidenceOfSandbox, HKLM_Key + " => " + regValue)
                    }
                }   
            }
        }
    }

    if len(EvidenceOfSandbox) == 0 {
        fmt.Println("Proceed!")
    } else {
        fmt.Println(EvidenceOfSandbox)
    }

}