/*
    C# sleep acceleration checker via NTP cluster queries
    Module written by Brandon Arvanaghi 
    Website: arvanaghi.com 
    Twitter: @arvanaghi
*/

using System;
using System.Net;
using System.Net.Sockets;
using System.Threading;

namespace SleepAccelerationCheck
{
    class Program
    {

        public static UInt32 GetNTPTime()
        {

            var NTPTransmit = new byte[48];
            NTPTransmit[0] = 0x1B;

            var addr = Dns.GetHostEntry("us.pool.ntp.org").AddressList;
            var sock = new Socket(AddressFamily.InterNetwork, SocketType.Dgram, ProtocolType.Udp);
            sock.Connect(new IPEndPoint(addr[0], 123));
            sock.ReceiveTimeout = 2000;
            sock.Send(NTPTransmit);
            sock.Receive(NTPTransmit);
            sock.Close();

            uint runTotal = 0; for (int i = 40; i <= 43; ++i) { runTotal = runTotal * 256 + (uint)NTPTransmit[i]; }
            return runTotal - 2208988800;
        }


        static void Main(string[] args)
        {

            var firstTime = GetNTPTime();
            Console.WriteLine("NTP time (in seconds) before sleeping: " + firstTime);

            Console.WriteLine("Attempting to sleep for " + args[0] + " seconds...");
            Thread.Sleep(int.Parse(args[0]) * 1000);

            var secondTime = GetNTPTime();
            Console.WriteLine("NTP time (in seconds) after sleeping: " + secondTime);

            var difference = secondTime - firstTime;
            Console.WriteLine("Difference in NTP times (should be at least " + args[0] + " seconds): " + difference);

            if (difference >= uint.Parse(args[0])) {
                Console.WriteLine("Proceed!");
            }

            Console.ReadKey();

        }
    }
}
