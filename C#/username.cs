using System;

namespace Username
{
    class Program
    {
        static void Main(string[] args)
        {
            if (System.Security.Principal.WindowsIdentity.GetCurrent().Name.Split('\\')[1].ToLower().Equals(string.Join(" ",args).ToLower())) {
                Console.Write("Proceed!");
                Console.ReadKey();
            }
        }
    }
}