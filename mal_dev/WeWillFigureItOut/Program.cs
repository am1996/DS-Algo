using System;
using System.Runtime.InteropServices;
using System.Text;

class ShellCodeRunner
{
    // --- Win32 Constants ---
    const uint TH32CS_SNAPPROCESS = 0x00000002;
    const int INVALID_HANDLE_VALUE = -1;

    // --- Structures ---
    [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
    struct PROCESSENTRY32
    {
        public uint dwSize;
        public uint cntUsage;
        public uint th32ProcessID;
        public IntPtr th32DefaultHeapID;
        public uint th32ModuleID;
        public uint cntThreads;
        public uint th32ParentProcessID;
        public int pcPriClassBase;
        public uint dwFlags;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 260)]
        public string szExeFile;
    }

    // --- Delegates for Dynamic Invocation ---
    delegate bool Process32FirstDelegate(IntPtr hSnapshot, ref PROCESSENTRY32 lppe);
    delegate bool Process32NextDelegate(IntPtr hSnapshot, ref PROCESSENTRY32 lppe);

    // --- Essential DllImports for Bootstrapping ---
    [DllImport("kernel32.dll", CharSet = CharSet.Auto)]
    public static extern IntPtr GetModuleHandle(string lpModuleName);

    [DllImport("kernel32.dll", CharSet = CharSet.Ansi, ExactSpelling = true)]
    public static extern IntPtr GetProcAddress(IntPtr hModule, string procName);

    [DllImport("kernel32.dll", SetLastError = true)]
    public static extern IntPtr CreateToolhelp32Snapshot(uint dwFlags, uint th32ProcessID);

    [DllImport("kernel32.dll", SetLastError = true)]
    public static extern bool CloseHandle(IntPtr hObject);

    static void Main(string[] args)
    {
        Console.WriteLine("[*] Starting Research Loader...");

        // 1. Get handle to Kernel32
        IntPtr hKernel = GetModuleHandle("kernel32.dll");
        if (hKernel == IntPtr.Zero) return;

        // 2. Resolve function pointers dynamically
        // Research Note: In a real scenario, these strings would be encrypted/encoded.
        IntPtr p32FirstAddr = GetProcAddress(hKernel, "Process32FirstW");
        IntPtr p32NextAddr = GetProcAddress(hKernel, "Process32NextW");

        if (p32FirstAddr == IntPtr.Zero || p32NextAddr == IntPtr.Zero)
        {
            Console.WriteLine("[-] Could not resolve API addresses.");
            return;
        }

        // 3. Map pointers to delegates
        var process32First = (Process32FirstDelegate)Marshal.GetDelegateForFunctionPointer(p32FirstAddr, typeof(Process32FirstDelegate));
        var process32Next = (Process32NextDelegate)Marshal.GetDelegateForFunctionPointer(p32NextAddr, typeof(Process32NextDelegate));

        // 4. Create System Snapshot
        IntPtr hSnapshot = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
        if (hSnapshot.ToInt64() == INVALID_HANDLE_VALUE)
        {
            Console.WriteLine("[-] Failed to create snapshot.");
            return;
        }

        // 5. Initialize structure and start enumeration
        PROCESSENTRY32 pe = new PROCESSENTRY32();
        pe.dwSize = (uint)Marshal.SizeOf(typeof(PROCESSENTRY32));

        Console.WriteLine("{0,-10} {1}", "PID", "Process Name");
        Console.WriteLine("-----------------------------------");

        // MANDATORY: Process32First must be called to start the iteration
        if (process32First(hSnapshot, ref pe))
        {
            do
            {
                Console.WriteLine("{0,-10} {1}", pe.th32ProcessID, pe.szExeFile);
            } 
            while (process32Next(hSnapshot, ref pe));
        }
        else
        {
            Console.WriteLine("[-] Process32First failed. Error Code: " + Marshal.GetLastWin32Error());
        }

        // 6. Cleanup
        CloseHandle(hSnapshot);
        Console.WriteLine("\n[*] Enumeration complete. Press any key to exit.");
        Console.ReadKey();
    }
}