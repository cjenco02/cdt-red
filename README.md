# Windows Reverse Shell Spawner

PowerShell Persistence Script

The PowerShell script (persist.ps1) adds a registry entry under the current user’s run key to ensure that a specified payload is executed at every user logon.

# Key features:

-Modifiable payload path

-Uses the HKCU:\Software\Microsoft\Windows\CurrentVersion\Run registry key

-Easy integration with any payload executable

-C# Reverse Shell Payload

-The C# payload (ReverseShellPayload.cs) establishes a reverse TCP connection to an attacker‑controlled server and launches a hidden instance of cmd.exe whose input and output are piped over the network

-Reverse shell functionality for remote command execution

-Asynchronous handling of command output

-Customizable IP address and port to suit your testing environment

# Usage
-Open persist.ps1 in your favorite text editor

-Update the variable $payloadPath with the full path to your payload executable (e.g., C:\path\to\payload.exe)

-Optionally, change the $entryName to a custom name

Run the Script:

-Open PowerShell on the target machine with appropriate privileges.

-Execute the script:

        .\persist.ps1

The script will create a registry entry that ensures the payload runs at every user logon.

# Building and Deploying the C# Payload

Change the target IP in payload.cs to that of the target machine

Compile the code using:

    csc.exe /target:winexe payload.cs

This will produce an executable (e.g., payload.exe).

Deploy the Payload:

-Place the compiled payload in the desired directory (e.g., C:\path\to\desired\directory\).

-Ensure the path in your PowerShell persistence script points to this executable.

# Test the Reverse Shell:

-Set up a listener on your controlled server. For example, using Netcat:

    nc -lvnp 4444

-Log off and log back on (or restart) the target machine to trigger the persistence mechanism.

-Once the payload executes, it will connect back to your listener and you should receive a reverse shell.
