#include <windows.h>
#include <winreg.h>
#include <stdio.h>

void EnumerateSubKeys(HKEY hKey) {
    DWORD dwIndex = 0;
    TCHAR szSubKeyName[256];  // Buffer for subkey name
    DWORD cchName = 256;      // Size of name buffer
    TCHAR szClassName[256];   // Buffer for class name
    DWORD cchClassName = 256; // Size of class buffer
    FILETIME ftLastWriteTime; // Last write time
    LONG result;

    while ((result = RegEnumKeyEx(
        hKey,
        dwIndex,
        szSubKeyName,
        &cchName,
        NULL,  // Reserved
        szClassName,
        &cchClassName,
        &ftLastWriteTime)) == ERROR_SUCCESS) {
        // Convert FILETIME to readable format (simplified)
        SYSTEMTIME st;
        FileTimeToSystemTime(&ftLastWriteTime, &st);
        printf("Subkey %d: %s (Class: %s, Last Write: %04d-%02d-%02d %02d:%02d)\n",
            dwIndex, szSubKeyName, szClassName,
            st.wYear, st.wMonth, st.wDay, st.wHour, st.wMinute);

        // Reset buffer sizes for next iteration
        cchName = 256;
        cchClassName = 256;
        dwIndex++;
    }

    if (result == ERROR_NO_MORE_ITEMS) {
        printf("No more subkeys.\n");
    }
    else {
        printf("Error: %ld\n", result);
    }
}

int main() {
    HKEY hKey;
    LONG result = RegOpenKeyEx(HKEY_LOCAL_MACHINE, TEXT("SOFTWARE"), 0, KEY_READ | KEY_ENUMERATE_SUB_KEYS, &hKey);
    if (result == ERROR_SUCCESS) {
        EnumerateSubKeys(hKey);
        RegCloseKey(hKey);
    }
    else {
        printf("Failed to open key: %ld\n", result);
    }
    return 0;
}