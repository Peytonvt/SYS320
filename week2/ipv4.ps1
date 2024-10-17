#Clears lines above script
Clear

#Get IPv4 Addr from Eth0 Interface
(Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ilike "Ethernet0" }).IPAddress