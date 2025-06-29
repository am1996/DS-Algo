.386
.model flat, stdcall
option casemap:none

include windows.inc
include kernel32.inc
includelib kernel32.lib

.code
main proc
    ; Allocate memory
    push PAGE_EXECUTE_READWRITE
    push MEM_COMMIT or MEM_RESERVE
    push 4096
    push 0
    call VirtualAlloc
    test eax, eax
    jz error

    ; Copy simple code (NOP, RET)
    mov edi, eax
    mov byte ptr [edi], 90h    ; NOP
    mov byte ptr [edi+1], 90h  ; NOP
    mov byte ptr [edi+2], 0C3h ; RET

    ; Create thread to execute code
    push 0
    push 0
    push 0
    push eax
    push 0
    push 0
    call CreateThread
    test eax, eax
    jz error

    ; Wait for thread
    push eax
    push INFINITE
    call WaitForSingleObject

    ; Clean up
    push MEM_RELEASE
    push 0
    push edi
    call VirtualFree
    ret

error:
    ret
main endp
end main