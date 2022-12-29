# asm-elevate-process
elevate a process to the system level in assembly for Windows

This code first opens the current process token using the OpenProcessToken function and sets it to be a primary token using the SetTokenInformation function. It then creates a new process with the system token using the CreateProcessWithTokenW function, passing the handle to the primary token as an argument. The new process is specified in the lpCommandLine parameter and is launched with the CREATE_NEW_CONSOLE flag to create a new console window.

The main process then waits for the new process to finish using the WaitForSingleObject function, gets the exit code using the GetExitCodeProcess function, and displays it using the MessageBoxA function. Finally, the handle to the new process and the primary token are closed and the main process exits.

This is just a simple example, and you may need to modify it to suit your specific needs. For example, you might want to pass arguments to the new process, or you might want to specify a different executable to run with the system token.
