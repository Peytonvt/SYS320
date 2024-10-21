﻿Get-Service | Where-Object { $_.Status -eq "Stopped" } | Sort-Object -Property DisplayName | Export-Csv -Path "C:\Users\champuser\Desktop\StoppedServices.csv" -NoTypeInformation