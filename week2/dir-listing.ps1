# Clears Script 
clear

# Choose a dir where you have some .ps1 files
$PSScriptRoot = "C:\Users\champuser\SYS320\week2"

# cd into $PSCRIPTROOT
cd $PSScriptRoot

# List files based on the file name
$files=(Get-ChildItem)

for ($j=0; $j -le $files.count; $j++){

    if ($files[$j].name -ilike "*ps1"){
        Write-Host $files[$j].name;
    }
}

#Create folder if it does not exist

$folderpath="PSScriptRoot\outfolder"
if (Test-Path $folderpath){
    Write-Host "Folder Already Exists"
}
else{
    New-Item -ItemType Directory -Path $folderpath
}

cd $PSScriptRoot
$files= Get-ChildItem

$folderpath = "$PSScriptRoot/outfolder/"
$filePath = Join-Path $folderpath "out.csv"

# List all the files that has the extension ".ps1" and
# Save the results to out.csv file

$files | Where-Object {$_.Extension -eq ".ps1"} |
Export-Csv -Path $filePath

# Without changing directory (don't go in outfolder), find 
# Everyt .csv file recursively and change their extensions to .log 
# Recursively display all the files (not directories)

$files=Get-ChildItem -Recurse -File -Filter *.csv
$files | Rename-Item -Newname { $_.Name -replace '.csv', '.log' }
Get-ChildItem -Recurse -File