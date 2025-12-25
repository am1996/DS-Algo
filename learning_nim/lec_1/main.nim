#[
    Author: Marcello Salvati, Twitter: @byt3bl33d3r
    License: BSD 3-Clause
]#

type
  HWND* = int
  UINT* = uint32

proc MessageBoxA(hWnd: HWND, lpText: cstring, lCaption: cstring, uType: UINT): int {.discardable, stdcall, importc: "MessageBoxA", dynlib:"user32.dll".}

MessageBoxA(0, "Hello from Nim!", "Nim MessageBox", 0)