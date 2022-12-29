; Link with advapi32.lib

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\advapi32.inc
include \masm32\include\user32.inc
include \masm32\include\masm32.inc

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\advapi32.lib
includelib \masm32\lib\user32.lib
includelib \masm32\lib\masm32.lib

.data

szProcessName DB "cmd.exe", 0
szDesktopName DB "winsta0\default", 0

.data?

hToken HANDLE ?

.code

start:

; Open the current process token
invoke OpenProcessToken, GetCurrentProcess(), TOKEN_ALL_ACCESS, ADDR hToken

; Set the token to be a primary token
invoke SetTokenInformation, hToken, TokenType, TOKEN_TYPE_PRIMARY, 4

; Create a new process with the system token
invoke CreateProcessWithTokenW, hToken, 0, ADDR szProcessName, 0, CREATE_NEW_CONSOLE, 0, 0, 0, ADDR STARTUPINFO, ADDR PROCESS_INFORMATION

; Close the handle to the token
invoke CloseHandle, hToken

; Wait for the new process to finish
invoke WaitForSingleObject, PROCESS_INFORMATION.hProcess, INFINITE

; Get the exit code of the new process
invoke GetExitCodeProcess, PROCESS_INFORMATION.hProcess, ADDR dwExitCode

; Close the handle to the new process
invoke CloseHandle, PROCESS_INFORMATION.hProcess

; Display the exit code
invoke MessageBoxA, 0, ADDR dwExitCode, ADDR dwExitCode, MB_OK

invoke ExitProcess, 0

end start
