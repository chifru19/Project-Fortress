# Windows Virtualization & Host Hardening Lab

This module implements robust host-level identity and access management (IAM) controls, least-privilege file permissions, and brute-force protections for Windows environments.

## Implemented Controls
1. **Account Lockout Policy:** Configured via PowerShell to lock accounts after 5 invalid attempts for 30 minutes (`/lockoutthreshold:5`, `/lockoutduration:30`, `/lockoutwindow:30`).
2. **IAM Group Mapping:** Automated security group provisioning and role assignment.
3. **Granular NTFS ACLs:** Enforced least-privilege access on sensitive directories (`C:\HR_Docs`) utilizing inheritance flags (`ContainerInherit, ObjectInherit`) for group-level modification rights.
