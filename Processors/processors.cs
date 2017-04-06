using System;

namespace Processors
{
    class Program
    {
        static void Main(string[] args)
        {
            if (System.Environment.ProcessorCount >= uint.Parse(args[0])) {
                Console.Write("Proceed!");
                Console.ReadKey();
            }
        }
    }
}