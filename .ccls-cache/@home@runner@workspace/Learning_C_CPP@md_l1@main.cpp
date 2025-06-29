#include <iostream>
#include <windows.h>

int main() {
  // Allocate memory in the current process
  LPVOID alloc = VirtualAlloc(NULL, 4096, MEM_COMMIT | MEM_RESERVE,
                              PAGE_EXECUTE_READWRITE);
  if (!alloc) {
    std::cout << "VirtualAlloc failed: " << GetLastError() << std::endl;
    return 1;
  }

  // Simple code to print a message (simulating a payload)
  unsigned char code[] = {
      0x90, 0x90, // NOP instructions (placeholder)
      0xC3        // RET (return)
  };
  memcpy(alloc, code, sizeof(code));

  // Create a thread to execute the code
  HANDLE thread =
      CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)alloc, NULL, 0, NULL);
  if (!thread) {
    std::cout << "CreateThread failed: " << GetLastError() << std::endl;
    VirtualFree(alloc, 0, MEM_RELEASE);
    return 1;
  }

  WaitForSingleObject(thread, INFINITE);
  VirtualFree(alloc, 0, MEM_RELEASE);
  CloseHandle(thread);
  std::cout << "Thread executed successfully." << std::endl;
  return 0;
}