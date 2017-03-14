using System;

namespace CsharpChecks
{
    class Program
    {
        static void Main(string[] args)
        {
            string JzubIh = System.Security.Principal.WindowsIdentity.GetCurrent().Name;
            string[] DmkyQqzsq = JzubIh.Split('\\');
            Console.WriteLine("Enter username:"); // Prompt
            string provided_name = Console.ReadLine().ToLower(); // Get string from user
            if (DmkyQqzsq[1].ToLower().Contains(provided_name))
            {
                Console.Write("Put Code Here");
            }
        }
    }
}
