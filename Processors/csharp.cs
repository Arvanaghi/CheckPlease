using System;

namespace CsharpChecks
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Minimum number of processors:"); // Prompt
            int proc_num = Convert.ToInt32(Console.ReadLine()); // Get int from user
            if (System.Environment.ProcessorCount > proc_num)
            {
                Console.Write("Put Code Here");
            }
        }
    }
}
