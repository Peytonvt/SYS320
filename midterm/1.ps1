function Get-IOC {
    param (
        [string]$url = "http://10.0.17.6/IOC.html"
    )


    # Takes the webpages content via "Invoke-WebRequest"
    $htmlContent = Invoke-WebRequest -Uri $url


    # Then parse the HTML content
    $html = $htmlContent.Content


    # Give each ioc pattern a name and explanation
    $iocPatterns = @{
        "etc/passwd" = "Access attempt to Linux users list"
        "cmd=" = "Windows reverse shell attempt"
        "/bin/bash" = "Linux shell attempt"
        "/bin/sh" = "Linux shell attempt"
        "1=1#" = "SQL injection attempt"
        "1=1--" = "SQL injection attempt"
    }


    # Finds matches witih HTML content
    $iocList = @()
    foreach ($pattern in $iocPatterns.Keys) {
        if ($html -match $pattern) {
            $iocList += [PSCustomObject]@{
                Pattern     = $pattern
                Explanation = $iocPatterns[$pattern]
            }
        }
    }


    return $iocList
}



