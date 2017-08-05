/*
    C# domain checker
    Module written by Brandon Arvanaghi 
    Website: arvanaghi.com 
    Twitter: @arvanaghi
*/

using System;

namespace DomainName
{
    class Program
    {
        static void Main(string[] args)
        {
            if (string.Equals(args[0], System.Net.NetworkInformation.IPGlobalProperties.GetIPGlobalProperties().DomainName, StringComparison.CurrentCultureIgnoreCase)) {
                Console.WriteLine("Proceed!");
            }
            Console.ReadKey();
        }
    }
}
