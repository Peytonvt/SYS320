function Filter-LogsByIndicators {
    param (
        [string]$logFilePath,
        [string[]]$indicators
    )

    # Read the log file
    $logContents = Get-Content -Path $logFilePath

    # Define regex pattern to match log entries
    $logPattern = '^(?<IPAddress>\S+) \S+ \S+ \[(?<DateTime>[^\]]+)\] "(?<Method>\S+) (?<Page>\S+) (?<Protocol>[^"]+)" (?<Response>\d+) (?<Referrer>[^"]*)'

    # Parse and filter log entries
    $filteredLogs = foreach ($line in $logContents) {
        if ($line -match $logPattern) {
            $log = [PSCustomObject]@{
                IPAddress    = $matches['IPAddress']
                Time         = $matches['DateTime']
                Method       = $matches['Method']
                Page         = $matches['Page']
                Protocol     = $matches['Protocol']
                Response     = $matches['Response']
                Referrer     = $matches['Referrer']
            }

            foreach ($indicator in $indicators) {
                if ($log.Page -like "*$indicator*") {
                    return $log
                }
            }
        }
    }

    return $filteredLogs
}

