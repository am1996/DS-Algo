using System.Reflection.Metadata.Ecma335;
using System.Runtime.InteropServices;

namespace Program;

public class Program
{
    [DllImport("win32u.dll", EntryPoint = "NtUserGetAsyncKeyState", SetLastError = true)]
    private static extern short NtUserGetAsyncKeyState(int vKey);

    [STAThread]
    public static int Main(string[] args)
    {
        while (true)
        {
            for (int i = 0; i < 255; i++)
            {
                short keyState = NtUserGetAsyncKeyState(i);
                if ((keyState & 0x8000) != 0) // Check if the high-order bit is set
                {
                    Console.WriteLine($"Key {Convert.ToChar(i)} is currently pressed.");
                }
            }
            System.Threading.Thread.Sleep(100); // Sleep to reduce CPU usage
        }
    }
}

