# Import the required module
Import-Module ActiveDirectory

#Put all the computer name into this text file (TMPComputer.txt) on your local computer
$PSExecPath = "C:\temp\psexec.exe"
$allPC = get-content c:\temp\TPMComputer.txt
#Source, can be a file share from your local server
$source = "\\mncc\app\Installs\TPM\TPM.bat"
#Destination can be anywhere on user local drive. Ex. temp folder
$destination = "\\$PC\c$\temp"

$result = foreach ($PC in $allPC){
    if (Test-Connection -ComputerName $PC -count 1 -ErrorAction SilentlyContinue){
         Write-Host "$PC is up" -ForegroundColor Green
         write-host "Copy TPM.bat file to all computer to C:\Temp" -ForegroundColor Yellow
         copy-item -path $source $destination -verbose -verbose
         write-host "Checking $PC TPM version" -foregroundcolor Magenta
try { Invoke-command -computername $PC -scriptblock { & Get-WmiObject -Namespace ROOT\CIMV2\Security\MicrosoftTpm -Class Win32_Tpm} | export-csv C:\Temp\TPMComputers.csv -append -ErrorAction stop}
catch { Set-Alias -Name psexec -Value $PSExecPath
& psexec -s \\$PC cmd.exe /c "C:\Temp\TPM.bat" }
write-host "Trying PSexec script"
Remove-Item -Path \\$PC\c$\Temp\TPM.bat -Verbose
    }
    else{
        $PC | Out-File -FilePath c:\Temp\TPMOffline.csv -Append
        Write-host "$PC is down" -ForegroundColor Darkred
    }
    
} 

