VPNIF="tun0"
NETIF="eth0"
VPNUSER="vpnuser"
TABLE_ID=42 # Can be any integer 0-253
MARK_ID=0x10 # Any 32bit value

# Get network address from IP and network mask (CIDR)
# E.g. 10.1.2.15 16 -> 10.1.0.0
function getnetmask {
	IP=$1
	PREFIX=$2
	IFS=. read -r i1 i2 i3 i4 <<< $IP
	IFS=. read -r xx m1 m2 m3 m4 <<< $(for a in $(seq 1 32); do if [ $(((a - 1) % 8)) -eq 0 ]; then echo -n .; fi; if [ $a -le $PREFIX ]; then echo -n 1; else echo -n 0; fi; done)
	printf "%d.%d.%d.%d\n" "$((i1 & (2#$m1)))" "$((i2 & (2#$m2)))" "$((i3 & (2#$m3)))" "$((i4 & (2#$m4)))"
}

function get_nic_ip {
	ip addr show $1 | grep -Po '(?<= inet )([0-9\.]+)'
}

function get_nic_subnet_mask {
	ip addr show $1 | grep -Po '(?<= inet )([0-9\.\/]+)' | cut -d "/" -f2
}
