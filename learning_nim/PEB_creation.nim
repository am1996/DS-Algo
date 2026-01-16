import winim/lean
import std/strutils

# --- STEP 1: Get PEB using Assembly ---
proc getPEB(): PVOID =
    var pebPtr: PVOID
    # GS:[0x60] points to the PEB on x64 systems
    asm """
        mov rax, qword ptr gs:[0x60]
        mov %0, rax
        : "=r"(`pebPtr`)
    """
    return pebPtr

# --- STEP 2: Find DLL Base via PEB Walking ---
proc getModuleBase(moduleName: string): uint64 =
    let peb = cast[ptr BYTE](getPEB())
    # 0x18 is the offset to the Ldr structure
    let ldr = cast[ptr ptr BYTE](peb + 0x18)
    # 0x20 is the offset to the InMemoryOrderModuleList
    var currEntry = cast[ptr BYTE](cast[ptr ptr BYTE](ldr + 0x20)[0])
    
    while currEntry != nil:
        # Offset 0x48 is the pointer to the FullDllName (UNICODE_STRING)
        let namePtr = cast[PUNICODE_STRING](currEntry + 0x48)
        if namePtr.Buffer != nil:
            let currentName = $namePtr.Buffer
            if moduleName.toLowerAscii() in currentName.toLowerAscii():
                # Offset 0x20 is the DllBase address
                return cast[uint64](cast[ptr ptr BYTE](currEntry + 0x20)[0])
        # Move to next Flink
        currEntry = cast[ptr BYTE](cast[ptr ptr BYTE](currEntry)[0])
    return 0

# --- STEP 3: Manually Parse Export Table ---
proc getExportAddress(dllBase: uint64, funcName: string): PVOID =
    let base = cast[ptr BYTE](dllBase)
    # DOS Header -> e_lfanew (Offset to NT Headers)
    let ntHeaders = cast[ptr IMAGE_NT_HEADERS64](base + cast[ptr IMAGE_DOS_HEADER](base).e_lfanew)
    # Data Directory [0] is the Export Directory
    let exportDirRVA = ntHeaders.OptionalHeader.DataDirectory[0].VirtualAddress
    let exportDir = cast[ptr IMAGE_EXPORT_DIRECTORY](base + exportDirRVA)

    # Tables for Names, Ordinals, and Addresses
    let names = cast[ptr UncheckedArray[uint32]](base + exportDir.AddressOfNames)
    let ordinals = cast[ptr UncheckedArray[uint16]](base + exportDir.AddressOfNameOrdinals)
    let functions = cast[ptr UncheckedArray[uint32]](base + exportDir.AddressOfFunctions)

    for i in 0 ..< exportDir.NumberOfNames:
        let name = $(cast[cstring](base + names[i]))
        if name == funcName:
            let ord = ordinals[i]
            return cast[PVOID](base + functions[ord])
    return nil

# --- STEP 4: Execution ---
when isMainModule:
    # 1. Manually load user32 (standard apps don't always have it)
    # In a real research scenario, you'd target kernel32.dll functions first
    LoadLibraryA("user32.dll") 
    
    let u32Base = getModuleBase("user32.dll")
    if u32Base != 0:
        let pMessageBoxA = getExportAddress(u32Base, "MessageBoxA")
        
        if pMessageBoxA != nil:
            # Define the function signature
            type MessageBoxAType = proc(hWnd: HWND, lpText: LPCSTR, lpCaption: LPCSTR, uType: UINT): int32 {.stdcall.}
            
            # Cast the raw address to our function type and call it
            let msgBox = cast[MessageBoxAType](pMessageBoxA)
            msgBox(0, "PEB Walking Successful!", "Research", 0)
