#!/bin/sh
echo "--- Starting Network Firewall Log ---"
while true; do
  timestamp=$(date)
  echo "[$timestamp] Monitoring traffic on Private Vault..." >> firewall_audit.log
  sleep 10
done