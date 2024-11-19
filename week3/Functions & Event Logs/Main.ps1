# Join path with functions to be called. 
. (Join-Path $PSScriptRoot functions_event_logs.ps1)

# Clear the page
clear

# Get Login and Logoffs from the last 15 days
$StartStopTable = LoginEvent(15)
$StartStopTable

# Get Starts and Stops from the last 25 days
$StartStopTable = StartShutTime(25)
$StartStopTable
