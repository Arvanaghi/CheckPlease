/*
    MAC address checker, C#
    Module written by Brandon Arvanaghi 
    Website: arvanaghi.com 
    Twitter: @arvanaghi
*/

using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Net.NetworkInformation;

namespace macAddressChecker {
    class Program
    {
        static void Main(string[] args)
        {
            List<string> EvidenceOfSandbox = new List<string>();

            string[] badMacAddresses = {@"000C29", @"001C14", @"005056", @"000569", @"080027"};

            NetworkInterface[] NICs = NetworkInterface.GetAllNetworkInterfaces();
            foreach (NetworkInterface NIC in NICs) {
                foreach (string badMacAddress in badMacAddresses) {
                    if (NIC.GetPhysicalAddress().ToString().ToLower().Contains(badMacAddress.ToLower())) {
                        EvidenceOfSandbox.Add(Regex.Replace(NIC.GetPhysicalAddress().ToString(), ".{2}", "$0:").TrimEnd(':'));
                    }
                }
            }

            if (EvidenceOfSandbox.Count == 0) {
                Console.WriteLine("Proceed!");
                Console.ReadKey();
            }
            else {
                Console.Write(string.Join("\n", EvidenceOfSandbox));
                Console.ReadKey();
            }

        }

    }
}