/*
    Checks if time zone is Coordinated Universal Time (UTC), C#
    Module written by Brandon Arvanaghi 
    Website: arvanaghi.com 
    Twitter: @arvanaghi
*/

using System;

namespace CheckTimezone {
    class Program {
        static void Main(string[] args) {
            if (TimeZone.CurrentTimeZone.StandardName == "Coordinated Universal Time") {
                Console.WriteLine("The time zone is Coordinated Universal Time (UTC), do not proceed.");
            } else {
                Console.WriteLine("The time zone is " + TimeZone.CurrentTimeZone.StandardName + ". Proceed!");
            }
            Console.ReadKey();
        }
    }
}