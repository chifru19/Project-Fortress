# 🏰 Project-Fortress: Active Defense & Network Isolation Lab

A sophisticated 3-tier security environment built with Docker to demonstrate **Zero-Trust architecture**, **Automated Auditing**, and **Active Deception** techniques.

## 🏗️ Architecture Overview
This lab simulates a hardened corporate environment using three distinct network zones to protect a simulated "Private Vault".

### 🔒 Network Segmentation
* **Public Zone (`public-net`)**: The external-facing boundary containing the `web-browser`.
* **DMZ / Deception Zone**: Houses the `frontend-proxy` and the **Cowrie SSH Honeypot**.
* **Private Vault (`private-net`)**: A strictly `internal` network housing the `secure-database`. It is physically unreachable from the Public Zone.

## 🍯 Active Defense: SSH Honeypot
To detect reconnaissance and brute-force attacks, I deployed a **Cowrie Honeypot** on port `2222`.
* **Function**: Mimics a vulnerable Debian server to trap attackers.
* **Logging**: Every keystroke, username, and password attempt is captured and sent to the audit trail.

## 🧪 Security Validation Results
I performed three major tests to validate the "Fortress" security posture:

1.  **Unauthorized Access (Blocked)**: Attempted to ping the database from the `web-browser`.
    * **Result**: `ping: bad address`. The database is invisible to the public.
2.  **Authorized Access (Allowed)**: Verified the `frontend-proxy` can reach the database.
    * **Result**: `0% packet loss`. The secure bridge is functional.
3.  **Intrusion Detection (Captured)**: Performed a mock brute-force attack on port `2222`.
    * **Result**: Access was successfully trapped and logged.

## 📊 Automated Auditing & Proof of Concept
The `security-monitor` service runs a custom Bash script (`monitor.sh`) to maintain a persistent audit trail in `firewall_audit.log`.

### 🛡️ Verified Intrusion Log
`Sat Feb 28 10:52:14 CET 2026: [HONEYPOT] Monitoring trap on port 2222...`