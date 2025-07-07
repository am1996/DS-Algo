#include <iostream>
#include <windows.h>

// Function to be exported
BOOL APIENTRY DllMain(HMODULE hModule,
                      DWORD  ul_reason_for_call,
                      LPVOID lpReserved
                     )
{
    switch (ul_reason_for_call)
    {
    case DLL_PROCESS_ATTACH:
		MessageBox(NULL, "DLL loaded", "Info", MB_OK);
        std::cout << "DLL loaded" << std::endl;
        break;
    case DLL_THREAD_ATTACH:
		MessageBox(NULL, "Thread created", "Info", MB_OK);
        std::cout << "Thread created" << std::endl;
        break;
    case DLL_THREAD_DETACH:
		MessageBox(NULL, "Thread destroyed", "Info", MB_OK);
        std::cout << "Thread destroyed" << std::endl;
        break;
    case DLL_PROCESS_DETACH:
		MessageBox(NULL, "DLL unloaded", "Info", MB_OK);
        std::cout << "DLL unloaded" << std::endl;
        break;
    }
    return TRUE;
}
