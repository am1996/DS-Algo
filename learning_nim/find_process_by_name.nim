import winim/lean
import winim/inc/tlhelp32
import strutils

proc getHandleToProcess(targetName: string) =
    var entry: PROCESSENTRY32
    entry.dwSize = cast[DWORD](sizeof(PROCESSENTRY32))
    
    let snapshot = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0)
    var targetPid: DWORD = 0

    # 1. Find the PID
    if Process32First(snapshot, addr entry):
        while Process32Next(snapshot, addr entry):
            if ($$entry.szExeFile).toLowerAscii == targetName.toLowerAscii:
                targetPid = entry.th32ProcessID
                break
    
    CloseHandle(snapshot)

    if targetPid == 0:
        echo "[-] Could not find process: ", targetName
        return

    echo "[+] Found PID: ", targetPid

    # 2. Try to Open the Process
    # PROCESS_QUERY_INFORMATION is a "stealthy" way to check access
    let hProcess = OpenProcess(PROCESS_QUERY_INFORMATION, FALSE, targetPid)

    if hProcess == 0:
        echo "[-] Access Denied! Error: ", GetLastError()
    else:
        echo "[+] Successfully opened a handle to ", targetName
        # 3. Always close the handle when done
        CloseHandle(hProcess)

when isMainModule:
    # Make sure Notepad is open before running!
    getHandleToProcess("notepad")
