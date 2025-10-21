# Import the required module
Import-Module ActiveDirectory
#Quary the computer from the domain
$allPC = get-content c:\laurel\TPMComputer.txt
$source = "\\Kode\main\Installs\TPM\TPM.bat"
$destination = "\\$PC\c$\Laurel"
foreach ($PC in $allPC){
    write-host "Copy TPM.bat file to all computer to C:\Laurel" -ForegroundColor Yellow
    copy-item -path "\\Kode\main\Installs\TPM\TPM.bat" -destination "\\$PC\c$\Kode" -verbose #Kode is the folder
    write-host "Checking $PC TPM version" -foregroundcolor green
try { Invoke-command -computername $PC -scriptblock { & Get-WmiObject -Namespace ROOT\CIMV2\Security\MicrosoftTpm -Class Win32_Tpm} | export-csv C:\Kode\Alltpm.csv -append -ErrorAction stop}
catch { Set-Alias -Name psexec -Value $PSExecPath
& psexec -s \\$PC cmd.exe /c "C:\Kode\TPM.bat" }
write-host "Trying PSexec script"
Remove-Item -Path \\$PC\c$\Kode\TPM.bat -Verbose
}
