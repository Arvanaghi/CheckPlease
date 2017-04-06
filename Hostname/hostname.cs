using System;

namespace Hostname
{
    class Program
    {
        static void Main(string[] args)
        {
            if (System.Environment.MachineName.ToLower().Equals(string.Join(" ",args).ToLower())) {
                Console.Write("Proceed!");
                Console.ReadKey();
            }
        }
    }
}
