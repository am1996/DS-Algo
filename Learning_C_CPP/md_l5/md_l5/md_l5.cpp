// md_l5.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <windows.h>

__declspec(dllexport) int add(int a, int b) {
    return a + b;
}

int main()
{
    // Get file attribute
    DWORD attributes1 = GetFileAttributes((LPWSTR) "E:\\Ahmed\\Books\\Basma_Magdy_CV_Updated.pdf");
    bool result = (attributes1 != INVALID_FILE_ATTRIBUTES && !(attributes1 & FILE_ATTRIBUTE_DIRECTORY));
    std::cout << result;
    // check if debugger present
    std::cout << IsDebuggerPresent() << std::endl;

    typedef int (*Add)(int, int);
    HMODULE hExe = GetModuleHandle(NULL);
    Add f = (Add)GetProcAddress(hExe, "add");
    if (f) {
        std::cout << f(1, 4);
    }
    else {
        std::cout << "F is not defined";
    }


    return 0;
}