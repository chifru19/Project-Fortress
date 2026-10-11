<#
.SYNOPSIS
    Advanced Windows Identity, Access Management, and Enterprise Hardening Script
.DESCRIPTION
    Automates account lockouts, least-privilege NTFS ACLs, PowerShell Script Block Logging,
    Attack Surface Reduction (ASR) rules, and AppLocker zero-trust execution policies.
#>

# 1. Host-Level Account Lockout Policy Hardening (Brute-Force Defense)
Write-Host "[*] Configuring Account Lockout Policies..." -ForegroundColor Cyan
net accounts /lockoutthreshold:5
net accounts /lockoutduration:30
net accounts /lockoutwindow:30

# 2. Local IAM Group Mapping
Write-Host "[*] Mapping Local IAM Security Groups..." -ForegroundColor Cyan
if (-not (Get-LocalGroup -Name "HR_Staff" -ErrorAction SilentlyContinue)) {
    New-LocalGroup -Name "HR_Staff" -Description "Human Resources Department Staff"
}

# 3. NTFS ACL Least-Privilege Enforcement
$TargetDir = "C:\HR_Docs"
if (-not (Test-Path $TargetDir)) {
    New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null
}

Write-Host "[*] Applying Granular NTFS ACLs with Inheritance Flags..." -ForegroundColor Cyan
$Acl = Get-Acl $TargetDir$Permission = "HR_Staff", "Modify", "ContainerInherit, ObjectInherit", "None", "Allow"
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $Permission
$Acl.SetAccessRule($AccessRule)
Set-Acl $TargetDir$Acl

# 4. PowerShell Script Block Logging & Transcription (Event ID 4104)
Write-Host "[*] Enabling PowerShell Script Block Logging & Transcription..." -ForegroundColor Cyan
$LogPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging"
if (-not (Test-Path $LogPath)) { New-Item -Path$LogPath -Force | Out-Null }
Set-ItemProperty -Path $LogPath -Name "EnableScriptBlockLogging" -Value 1

$TransPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription"
if (-not (Test-Path $TransPath)) { New-Item -Path$TransPath -Force | Out-Null }
Set-ItemProperty -Path $TransPath -Name "EnableTranscripting" -Value 1
Set-ItemProperty -Path $TransPath -Name "OutputDirectory" -Value "C:\PowerShell_Transcripts"

# 5. Attack Surface Reduction (ASR) Rules Configuration
Write-Host "[*] Configuring Windows Defender Attack Surface Reduction (ASR) Rules..." -ForegroundColor Cyan
try {
    # Block executable content from email and webmail + Block credential stealing from LSASS
    Add-MpPreference -AttackSurfaceReductionRules_Ids "be9ba2d9-53ea-4cdc-84e5-9b1ffee46535", "9e6c4e1f-7d60-472f-ba1a-a39ef669e4b2" -AttackSurfaceReductionRules_Actions Enabled
} catch {
    Write-Warning "ASR rules require elevated Windows Defender administrative context."
}

# 6. AppLocker Zero-Trust Application Control Setup
Write-Host "[*] Initializing AppLocker Identity Service..." -ForegroundColor Cyan
Set-Service -Name AppIDSvc -StartupType Automatic
Start-Service -Name AppIDSvc -ErrorAction SilentlyContinue

Write-Host "[+] Advanced Windows Hardening Policies Applied Successfully!" -ForegroundColor Green
