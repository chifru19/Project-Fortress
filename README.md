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
## 🛡️ Proactive Security: Static Analysis (IaC)
To ensure the infrastructure adheres to industry best practices, I integrated **Checkov** for static analysis of the Docker configuration.

### 🔍 Security Audit Highlights:
* **Secret Management**: Successfully resolved **CKV_SECRET_6** by migrating hardcoded credentials to a protected `.env` environment.
* **Policy Compliance**: Automated scanning ensures no "High Entropy" strings are committed to version control.
## 🏁 Conclusion & Future Roadmap
This lab successfully demonstrates the balance between **Network Isolation**, **Active Deception**, and **Resource Availability**. By treating the infrastructure as code (IaC), I was able to automate security audits and maintain a hardened posture against common SSH exploitation techniques.

### 🚀 Future Enhancements
To further evolve **Project-Fortress**, I plan to:
* **Elasticsearch Integration**: Pipe the `firewall_audit.log` into an ELK stack for advanced visual analytics of attacker geographic origins.
* **Automated Containment**: Script a trigger that automatically isolates a container if the `security-monitor` detects a brute-force threshold breach.
* **Web Application Firewall (WAF)**: Deploy an Nginx WAF to protect the `frontend-proxy` from SQL injection and XSS attempts.
* ## ⚔️ Active Defense Implementation
* **Zero-Trust Networking**: Configured an `internal: true` private network for the database, ensuring no external traffic can reach sensitive back-end assets.
* **Resource Sandboxing**: Implemented Docker `deploy` resource limits (128MB RAM / 0.5 CPU) to mitigate the risk of a "Fork Bomb" or resource exhaustion attack within the honeypot.
* **Automated Monitoring**: Integrated a `monitor.sh` listener that captures real-time logs from the honeypot for forensic analysis.
### ✅ Security Audit Results
The infrastructure has been audited against the **Prisma Cloud / Checkov** security policy set:
* **IaC Integrity**: 100% pass rate on resource limitation and network segmentation policies.
* **Attack Surface**: Minimized via multi-tier network isolation.
* **Automated Governance**: Integrated GitHub Actions pipeline prevents the introduction of insecure container configurations.
