$Computers = Get-Content -path "C:\Kode\Rapid7.txt"
#$ProgramList = Get-Content 'ProgramList.txt'
$Date = Get-Date -Format MMM-dd-yyyy:HH.mm

ForEach ($Computer in $Computers){
  $Installs = Get-WmiObject -Class win32_product -ComputerName $Computer -ErrorVariable wmierror -ErrorAction SilentlyContinue
  $MyApp = Get-WmiObject -Class Win32_Product -ComputerName $Computer  | sort-object Name | select Name | where { $_.Name -match "Rapid7 Insight Agent"}  
    # Test connection to remote machine
    if (!(Test-Connection -ComputerName $Computer -Count 1 -Quiet))
    {    
        # Display a message in the console if no response and output results to the log
        Write-Host "$Computer Offline" -ForegroundColor Red -BackgroundColor Black
        "$Computer Offline" + " $Date" | Out-File -FilePath "C:\Laurel\ResultLog.txt" -Append
    } 
    
    Else 
    
    { 
    if ($MyApp -match "Rapid7 Insight Agent")
{
    #Write-Output $MyApp.Name
    Write-host "Rapid7 Insight Agent One IS ON the $Computer." -ForegroundColor Green
}
else{
    Write-host "Rapid7 Insight Agent IS NOT ON $Computer." -ForegroundColor DarkYellow
}}
}
