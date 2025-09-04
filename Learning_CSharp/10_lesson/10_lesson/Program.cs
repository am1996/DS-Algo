using System.Formats.Asn1;
using System.Runtime.InteropServices;
using static Program.Program;

namespace Program;

class Program
{
    [DllImport("kernel32.dll", SetLastError = true)]
    private static extern IntPtr CreateToolhelp32Snapshot(uint dwFlags, uint th32ProcessID);

    [DllImport("kernel32.dll",SetLastError = true)]
    private static extern bool Process32First(IntPtr hProcess, ref ProcessEntry32 lppe);

    [DllImport("kernel32.dll",SetLastError =true)]
    private static extern bool Process32Next(IntPtr hProcess, ref ProcessEntry32 lppe);

    [DllImport("kernel32.dll", SetLastError = true)]
    private static extern bool CloseHandle(IntPtr hObject);

    public struct ProcessEntry32
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
    const uint TH32CS_SNAPPROCESS = 0x00000002; 
    public static int Main(string[] args)
    {
        IntPtr hSnapshot = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
        if (hSnapshot == new IntPtr(-1))
        {
            Console.WriteLine($"Snapshot {Marshal.GetHRForLastWin32Error()}");
        }
        ProcessEntry32 pe = new ProcessEntry32 { dwSize = (uint)Marshal.SizeOf(typeof(ProcessEntry32)) }; 
        if (Process32First(hSnapshot, ref pe))
        {
            do
            {
                Console.WriteLine($"PID: {pe.th32ProcessID} {pe.szExeFile}");
            }while(Process32Next(hSnapshot, ref pe));
        }
        return 0;
    }
}