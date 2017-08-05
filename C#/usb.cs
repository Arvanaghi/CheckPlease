/*
    Minimum number of USB devices ever mounted, C#
    Module written by Brandon Arvanaghi 
    Website: arvanaghi.com 
    Twitter: @arvanaghi
*/

using System;
using Microsoft.Win32;

namespace MinUSBDevicesEverMounted {
    class Program {
        static void Main(string[] args) {
            int MinimumUSBHistory = 2;
            if (args.Length > 0) {
                MinimumUSBHistory = Convert.ToInt32(args[0]);
            }

            RegistryKey OpenedKey = Registry.LocalMachine.OpenSubKey(@"SYSTEM\ControlSet001\Enum\USBSTOR", false);

            if (OpenedKey.GetSubKeyNames().Length >= MinimumUSBHistory) {
                Console.WriteLine("Proceed!");
                Console.ReadKey();
            } else {
                Console.WriteLine("Number of USB devices ever mounted: {0}", OpenedKey.GetSubKeyNames().Length);
                Console.ReadKey();
            }
        }
    }
}