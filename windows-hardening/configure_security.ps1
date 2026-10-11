<#
.SYNOPSIS
    Windows Identity, Access Management, and Host Hardening Script
.DESCRIPTION
    Automates local security group mapping, least-privilege NTFS ACL enforcement,
    and account lockout policy configuration for enterprise hardening labs.
#>

# 1. Host-Level Account Lockout Policy Hardening (Brute-Force Defense)
Write-Host "[*] Configuring Account Lockout Policies..." -ForegroundColor Cyan
net accounts /lockoutthreshold:5
net accounts /lockoutduration:30
net accounts /lockoutwindow:30

# 2. Local IAM Group Mapping
Write-Host "[*] Mapping Local IAM Security Groups..." -ForegroundColor Cyan
# Ensure group exists (example: HR_Staff)
if (-not (Get-LocalGroup -Name "HR_Staff" -ErrorAction SilentlyContinue)) {
    New-LocalGroup -Name "HR_Staff" -Description "Human Resources Department Staff"
}
# Add user to group (modify username as needed, e.g., HR_User1)
# Add-LocalGroupMember -Group "HR_Staff" -Member "HR_User1" -ErrorAction SilentlyContinue

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

Write-Host "[+] Windows Hardening Policies Applied Successfully!" -ForegroundColor Green
