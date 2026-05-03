using System.Runtime.InteropServices;
class ShellCodeRunner
{
    //PROCESSENTRY32 structure
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
    [DllImport("kernel32.dll")]
    public static extern bool VirtualProtect(IntPtr lpAddress, uint dwSize, uint flNewProtect, out uint lpflOldProtect);
    [DllImport("kernel32.dll")]
    public static extern IntPtr GetCurrentProcess();
    [DllImport("kernel32.dll")]
    public static extern bool ReadProcessMemory(IntPtr hProcess, IntPtr lpBaseAddress, byte[] lpBuffer, uint nSize, out uint lpNumberOfBytesRead);

    [DllImport("kernel32.dll")]
    public static extern IntPtr CreateToolhelp32Snapshot(uint dwFlags, uint th32ProcessID);

    delegate bool Process32NextDelegate(IntPtr hSnapshot, ref PROCESSENTRY32 lppe);

    //GetProcAddress and GetModuleHandle for dynamic function resolution
    [DllImport("kernel32.dll")]
    public static extern IntPtr GetProcAddress(IntPtr hModule, string procName);

    [DllImport("kernel32.dll")]
    public static extern IntPtr GetModuleHandle(string lpModuleName);

    // Entry point
    static void Main(string[] args)
    {
        Process32NextDelegate process32Next = (Process32NextDelegate)Marshal.GetDelegateForFunctionPointer(GetProcAddress(GetModuleHandle("kernel32.dll"), "Process32NextW"), typeof(Process32NextDelegate));
        // List Processes
        Console.WriteLine("Listing processes...");
        var snapshot = CreateToolhelp32Snapshot(0x00000002, 0); // TH32CS_SNAPPROCESS
        if (snapshot == IntPtr.Zero)
        {
            Console.WriteLine("Failed to create snapshot.");
            return;
        }
        for (uint i = 0; ; i++)
        {
            PROCESSENTRY32 pe = new PROCESSENTRY32();
            pe.dwSize = (uint)Marshal.SizeOf(typeof(PROCESSENTRY32));
            if (!process32Next(snapshot, ref pe))
                break;
            Console.WriteLine($"Process ID: {pe.th32ProcessID}, Name: {pe.szExeFile}");
        }
    }
}