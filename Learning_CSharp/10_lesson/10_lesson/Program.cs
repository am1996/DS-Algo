using System.Runtime.InteropServices;

namespace Program;

class Program
{
    [DllImport("user32.dll", CharSet = CharSet.Ansi)]
    private static extern int MessageBoxA(IntPtr hWnd, string lpText, string lpCaption, uint uType);
    public static int Main(string[] args)
    {
        MessageBoxA(IntPtr.Zero, "hello world", "This is me", 0x00000000 | 0x00000040);
        Console.WriteLine("hello world");
        return 0;
    }
}