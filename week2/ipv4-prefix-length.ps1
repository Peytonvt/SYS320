#Clears start of script
clear

#Get IPv4 PrefixLength from Eth0 Interface
(Get-NetIPAddress -AddressFamily IPv4 | Where-Object {
$_.InterfaceAlias -ilike "Ethernet0" }).PrefixLength