# Advanced Windows Virtualization & Host Hardening Lab

This module implements robust host-level identity management, file permissions, behavioral logging, and zero-trust execution controls.

## Implemented Controls
1. **Account Lockout Policy:** Locks accounts after 5 invalid attempts for 30 minutes (`/lockoutthreshold:5`).
2. **IAM Group Mapping:** Automated security group provisioning (`HR_Staff`).
3. **Granular NTFS ACLs:** Enforced least-privilege access on `C:\HR_Docs` with inheritance flags (`ContainerInherit, ObjectInherit`).
4. **PowerShell Script Block Logging & Transcription:** Enforces Event ID 4104 tracking and records all interactive sessions/scripts to `C:\PowerShell_Transcripts`.
5. **Attack Surface Reduction (ASR) Rules:** Deploys active Defender rules to block weaponized attachments and LSASS credential theft.
6. **AppLocker Execution Control:** Prepares zero-trust binary execution by configuring the Application Identity (`AppIDSvc`) service.
