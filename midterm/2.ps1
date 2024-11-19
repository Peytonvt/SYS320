function Get-ApacheAccessLogs {
    param (
        [string]$logFilePath
    )

    # Read the log file
    $logContents = Get-Content -Path $logFilePath

    # Define regex pattern to match log entries
    $logPattern = '^(?<IP>\S+) \S+ \S+ \[(?<Time>[^\]]+)\] "(?<Method>\S+) (?<Page>\S+) (?<Protocol>[^"]+)" (?<Response>\d+) (?<Referrer>[^"]*)'

    # Parse each log entry
    $logEntries = foreach ($line in $logContents) {
        if ($line -match $logPattern) {
            [PSCustomObject]@{
                IPAddress    = $matches['IP']
                Time         = $matches['Time']
                Method       = $matches['Method']
                Page         = $matches['Page']
                Protocol     = $matches['Protocol']
                Response     = $matches['Response']
                Referrer     = $matches['Referrer']
            }
        }
    }

    return $logEntries
}


