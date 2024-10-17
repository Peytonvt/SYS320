# Clear
Clear

# Get DNS Server IP's and Display first one
(Get-DnsClientServerAddress -AddressFamily IPV4).ServerAddresses | Select-Object -First 1