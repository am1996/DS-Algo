#include <stdio.h>
#include <Windows.h>

int main()
{
    const char* input_file = "E:/Ahmed/projects/DS-Algo/Learning_C_CPP/md_l7/md_l7/a.txt";
    HANDLE hInput;
    LARGE_INTEGER file_size;
    hInput = CreateFileA(input_file, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
    if (hInput == INVALID_HANDLE_VALUE) {
        CloseHandle(hInput);
        return -300;
    }
    if (!GetFileSizeEx(hInput, &file_size)) {
        CloseHandle(hInput);
        return -200;
    }

    DWORD bufferSize = (DWORD)file_size.QuadPart + 1;
    char* buffer = (const char*)VirtualAlloc(NULL, bufferSize, MEM_COMMIT, PAGE_READWRITE);
    if (!buffer) {
        CloseHandle(hInput);
        return -400;
    }
    memset(buffer,0,bufferSize);
    DWORD bytesRead;
    if (!ReadFile(hInput, buffer, bufferSize - 1, &bytesRead, NULL)) {
        return -500;
    }
    buffer[bytesRead] = '\0';
    printf("%s", buffer);
    VirtualFree(buffer, 0, MEM_RELEASE);
    return 0;
}
