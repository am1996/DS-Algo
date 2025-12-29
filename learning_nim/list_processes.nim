import winim/lean
import winim/inc/tlhelp32  # Required for Process32 and Snapshot functions
import strutils            # Required for string alignment/formatting

proc listProcesses() =
    # 1. Initialize the PROCESSENTRY32 structure
    var entry: PROCESSENTRY32
    entry.dwSize = cast[DWORD](sizeof(PROCESSENTRY32))
    
    # 2. Take a snapshot of all processes currently running
    let snapshot = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0)
    
    # Check if the handle is valid
    if snapshot == INVALID_HANDLE_VALUE:
        echo "[-] Error: Could not create system snapshot. Error code: ", GetLastError()
        return

    # 3. Start the enumeration
    # Note: We check Process32First to see if there is at least one process
    if Process32First(snapshot, addr entry):
        echo "PID".alignLeft(10), "Process Name"
        echo "---".alignLeft(10), "------------"
        
        # Loop through the snapshot
        while Process32Next(snapshot, addr entry):
            # FIX: Use the $$ operator to handle Windows Wide/Unicode strings.
            # This prevents the "only first letter" bug.
            let name = $$entry.szExeFile
            
            # Print the PID and the converted name
            if name.len > 0:
                echo ($entry.th32ProcessID).alignLeft(10), name

    # 4. Clean up: Always close your handles
    CloseHandle(snapshot)

when isMainModule:
    listProcesses()
