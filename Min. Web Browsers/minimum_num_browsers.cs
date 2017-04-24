/*
    Minimum number of browsers, C#
    Module written by Brandon Arvanaghi 
    Website: arvanaghi.com 
    Twitter: @arvanaghi
*/

using System;
using Microsoft.Win32;

namespace MinimumNumBrowsersChecker {
    class Program {
        static void Main(string[] args) {
            int browserCount = 0;
            string[] browserKeys = {@"SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe", @"SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\iexplore.exe", @"SOFTWARE\Mozilla"};

            foreach (string browserKey in browserKeys) {
                RegistryKey OpenedKey = Registry.LocalMachine.OpenSubKey(browserKey, false);
                if (OpenedKey != null) {
                    browserCount += 1;
                }
            }

            if (browserCount >= 2){
                Console.WriteLine("Proceed!");
                Console.ReadKey();
            } else {
                Console.WriteLine("Number of Browsers: {0}", browserCount);
                Console.ReadKey();
            }
        }
    }
}