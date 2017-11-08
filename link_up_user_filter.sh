#!/usr/bin/env bash
SRC_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$SRC_DIR" ]]; then SRC_DIR="$PWD"; fi

# Run scripts
echo "Config Routing Table"
"$SRC_DIR/user_filter/vpn_routing_table.sh"
echo "Config IPTables"
"$SRC_DIR/user_filter/iptables_user_filter.sh"
echo "Start Deluge"
"$SRC_DIR/start_deluge.sh"
