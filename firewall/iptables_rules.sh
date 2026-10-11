#!/bin/sh
# Flush existing rules and set default drop policies
iptables -F
iptables -X
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Allow loopback traffic
iptables -A INPUT -i lo -j ACCEPT

# Allow established and related incoming packets (Stateful Inspection)
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Rate-limit and protect SSH/Honeypot port (2222) against brute-force attacks
iptables -A INPUT -p tcp --dport 2222 -m conntrack --ctstate NEW -m connlimit --connlimit-above 5 -j REJECT
iptables -A INPUT -p tcp --dport 2222 -m conntrack --ctstate NEW -j ACCEPT

# Log dropped packets with rate-limiting to prevent disk overflow
iptables -A INPUT -m limit --limit 5/m --limit-burst 10 -j LOG --log-prefix "FIREWALL-DROP: "
