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
            if (args[0] == System.Net.NetworkInformation.IPGlobalProperties.GetIPGlobalProperties().DomainName) {
                Console.WriteLine("Proceed!");
            }
            Console.ReadKey();
        }
    }
}
