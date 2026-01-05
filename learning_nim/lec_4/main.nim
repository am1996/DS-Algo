import winim/lean
import winim/inc/tlhelp32
import strutils

proc checkProcessPid(targetName: string) =
    var entry: PROCESSENTRY32
    entry.dwSize = cast[DWORD](sizeof(PROCESSENTRY32))
    
    let snapshot = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0)
    if snapshot == INVALID_HANDLE_VALUE:
        echo "[-] Snapshot Failed! Error: ", GetLastError()
        return

    echo "[*] Dumping all visible processes..."
    
    var count = 0
    if Process32First(snapshot, addr entry):
        while Process32Next(snapshot, addr entry):
            # Using $$ is critical here
            let name = $$entry.szExeFile
            let pid = entry.th32ProcessID

            if name.contains(targetName):
                echo "[+] Found target process: ", name, " (PID: ", pid, ")"
                return

    CloseHandle(snapshot)
    echo "[*] Total processes found: ", count

when isMainModule:
    checkProcessPid("pad")