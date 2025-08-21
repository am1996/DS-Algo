using System;
using System.Runtime.InteropServices;

namespace e;

class Program
{
    [STAThread]
    static void Main(string[] args)
    {
        KeyboardHook hook = new KeyboardHook();
        File.WriteAllText("./hello.txt", "hello world");
    }
}

class KeyboardHook
{
    [System.Runtime.InteropServices.DllImport("user32.dll", CharSet = System.Runtime.InteropServices.CharSet.Auto, SetLastError = true)]
    private static extern IntPtr SetWindowsHookEx(int idHook, LowLevelKeyboardProc lpfn, IntPtr hMod, uint dwThreadId);
}