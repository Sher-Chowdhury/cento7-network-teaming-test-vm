#!/usr/bin/env bash
exit 0
set -ex

echo "####################################################"
echo "####### About to run setup-network-teaming.sh #######"
echo "####################################################"


yum install -y teamd

nmcli connection add type team con-name CodingBeeTeam0 ifname CodingBeeTeam0 config '{"runner": {"name":"activebackup"}}'
sleep 5
teamdctl CodingBeeTeam0 state
ip addr show

nmcli connection modify CodingBeeTeam0 ipv4.addresses '192.168.2.50/24'
nmcli connection modify CodingBeeTeam0 ipv4.method manual

nmcli connection add type team-slave con-name CodingBeeTeam0-port1 ifname enp0s8 master CodingBeeTeam0
nmcli connection add type team-slave con-name CodingBeeTeam0-port2 ifname enp0s9 master CodingBeeTeam0

nmcli connection up CodingBeeTeam0
nmcli connection up CodingBeeTeam0-port1
nmcli connection up CodingBeeTeam0-port2


teamdctl CodingBeeTeam0 state
ip addr show

exit 0
