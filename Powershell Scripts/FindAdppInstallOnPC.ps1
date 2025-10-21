$PCs = get-content C:\Temp\SophosPC.txt
foreach ($PC in $PCs) {

$MyApp = Get-WmiObject -Class Win32_Product | sort-object Name | select Name | where { $_.Name -match "Sophos Agent"}

if ($MyApp -match "Sophos Agent")
{
    #Write-Output $MyApp.Name
    Write-host "Sophos Agent is sitll on $PC." -ForegroundColor Green
    $fails | export-csv C:\Temp\SophosFailed.txt -NoTypeInformation
}
else
{
    Write-host "Sophos agent is GONE." -ForegroundColor DarkYellow
}
}