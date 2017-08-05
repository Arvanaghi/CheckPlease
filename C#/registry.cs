/*
    Windows Registry key and value checker, C#
    Module written by Brandon Arvanaghi 
    Website: arvanaghi.com 
    Twitter: @arvanaghi
*/

using System;
using System.IO;
using System.Collections.Generic;
using Microsoft.Win32;

namespace RegistryChecker {

    class Program {

        static void Main(string[] args) {

            List<string> EvidenceOfSandbox = new List<string>();

            List<string> sandboxStrings = new List<string> {"vmware", "virtualbox", "vbox", "qemu", "xen"};

            string[] HKLM_Keys_To_Check_Exist = {@"HARDWARE\DEVICEMAP\Scsi\Scsi Port 2\Scsi Bus 0\Target Id 0\Logical Unit Id 0\Identifier",
                @"SYSTEM\CurrentControlSet\Enum\SCSI\Disk&Ven_VMware_&Prod_VMware_Virtual_S",
                @"SYSTEM\CurrentControlSet\Control\CriticalDeviceDatabase\root#vmwvmcihostdev",
                @"SYSTEM\CurrentControlSet\Control\VirtualDeviceDrivers",
                @"SOFTWARE\VMWare, Inc.\VMWare Tools",
                @"SOFTWARE\Oracle\VirtualBox Guest Additions",
                @"HARDWARE\ACPI\DSDT\VBOX_"};

            string[] HKLM_Keys_With_Values_To_Parse = {@"SYSTEM\ControlSet001\Services\Disk\Enum\0",
                @"HARDWARE\Description\System\SystemBiosInformation",
                @"HARDWARE\Description\System\VideoBiosVersion",
                @"HARDWARE\Description\System\SystemManufacturer",
                @"HARDWARE\Description\System\SystemProductName",
                @"HARDWARE\Description\System\Logical Unit Id 0"};

            foreach (string HKLM_Key in HKLM_Keys_To_Check_Exist) {
                RegistryKey OpenedKey = Registry.LocalMachine.OpenSubKey(HKLM_Key, false);
                if (OpenedKey != null) {
                    EvidenceOfSandbox.Add(@"HKLM:\" + HKLM_Key);
                }
            }

            foreach (string HKLM_Key in HKLM_Keys_With_Values_To_Parse) {
                string valueName = new DirectoryInfo(HKLM_Key).Name;
                string value = (string) Registry.LocalMachine.OpenSubKey(Path.GetDirectoryName(HKLM_Key), false).GetValue(valueName);
                foreach (string sandboxString in sandboxStrings) {
                    if (!string.IsNullOrEmpty(value) && value.ToLower().Contains(sandboxString.ToLower())) {
                        EvidenceOfSandbox.Add(@"HKLM:\" + HKLM_Key + " => " + value);
                    }
                }  
            }

            if (EvidenceOfSandbox.Count == 0) {
                Console.WriteLine("Proceed!");
                Console.ReadKey();
            } else {
                Console.Write(string.Join("\n", EvidenceOfSandbox));
                Console.ReadKey();
            }

        }
    }
}