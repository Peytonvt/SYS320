#Show classes of Win32 Lib, that starts with Net. Sorted Alphabetically
Get-WmiObject -List | Where-Object { $_.Name -ilike "Win32_NetworkAdapter*" } | Sort-Object