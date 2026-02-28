# 🛡️ Project-Fortress: Network Isolation & Security Auditing

## 🏗️ Architecture Overview
This project demonstrates a **Zero-Trust** network design using Docker containers. It simulates a corporate environment with three distinct zones to protect sensitive data.



### 🔒 Network Zones
* **Public Zone (`public-net`)**: Accessible to the "Internet" (Web-Browser container).
* **DMZ / Bridge**: The Frontend Proxy sits on both networks to safely pass authorized traffic.
* **Private Vault (`private-net`)**: An `internal` network that blocks all external pings and connections.

## 🧪 Security Test Results
I performed two major tests to validate the firewall rules:

1. **Unauthorized Access (Blocked)**: Attempted to ping the database from the web-browser. 
   - **Result**: `ping: bad address`. The database is invisible to the public.
2. **Authorized Access (Allowed)**: Pinged the database from the frontend-proxy.
   - **Result**: `0% packet loss`. The secure bridge is functional.

## 📊 Automated Auditing
A dedicated `security-monitor` service runs a bash script to record activity on the private network, saving a persistent audit trail to `firewall_audit.log`.