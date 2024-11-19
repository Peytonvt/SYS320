# Function gets login and logoff records from Windows Events and saves to a variable
# $days var allows user to change day range to search from
Function LoginEvent($days) {

$loginouts = Get-EventLog System -source Microsoft-Windows-winlogon -After (Get-Date).AddDays(-$days)

$loginoutsTable = @()
for ($i=0; $i -lt $loginouts.Count; $i++){

# Create event property value
$event = ""
if($loginouts[$i].EventId -eq 7001) {$event="Logon"}
if($loginouts[$i].EventId -eq 7002) {$event="Logoff"}

$userid = $loginouts[$i].ReplacementStrings[1]
$SID = New-Object System.Security.Principal.SecurityIdentifier($userid)
$user = $SID.Translate([System.Security.Principal.NTAccount])

# Adding each line within our array (custom object)
$loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated; `
                                       "Id" = $loginouts[$i].EventID; `
                                    "Event" = $event;
                                     "User" = $user.value;                     
                                     }

} # End of for loop
return $loginoutsTable
}

# This function gets start and stop records from Windows Events and saves to a variable
# $days var allows user to change day range to search from
Function StartShutTime ($days){

$startstop = Get-EventLog System -After (Get-Date).AddDays(-$days) | Where-Object { $_.EventID -in 6005, 6006}

$StartStopTable = @()
for ($i=0; $i -lt $startstop.Count; $i++){

# Creating event property value
$event = ""
if($startstop[$i].EventId -eq 6005) {$event="Startup"}
if($startstop[$i].EventId -eq 6006) {$event="Shutdown"}

# Adding each new line to our empty array
$StartStopTable += [pscustomobject]@{"Time" = $startstop[$i].TimeGenerated; `
                                       "Id" = $startstop[$i].EventID; `
                                    "Event" = $event;
                                     "User" = "System"                   
                                     }

} # End of for loop
return $StartStopTable
}