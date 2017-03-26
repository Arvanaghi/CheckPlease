using System;

namespace CsharpChecks
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Enter username:"); // Prompt
            string hostname_name = Console.ReadLine().ToLower(); // Get string from user
            if (System.Environment.MachineName.ToLower().Contains(hostname_name))
            {
                Console.Write("Put Code Here");
            }
        }
    }
}
