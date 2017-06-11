/*
    Checks if process is currently being debugged, C#
    Module written by Brandon Arvanaghi 
    Website: arvanaghi.com 
    Twitter: @arvanaghi
*/

using System;

namespace DetectDebugging {
    class Program {
        static void Main(string[] args) {
            if (System.Diagnostics.Debugger.IsAttached) {
                Console.WriteLine("A debugger is present, do not proceed.");
            } else {
                Console.WriteLine("No debugger is present. Proceed!");
            }
            Console.ReadKey();
        }
    }
}
