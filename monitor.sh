#!/bin/sh
while true; do
  if nc -zvw1 fortress-honeypot 2222 2>/dev/null; then
    echo "$(date): [HONEYPOT] Connection detected on port 2222" >> firewall_audit.log
  fi
  sleep 5
done
