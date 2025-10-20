#This is a powershell script written in purposed of uninstall Adobe Flash Player from Window computer
#Remediation Project
#(\\kode\main\Installs\Adobe Uninstall\*) Consists of 3 files, machines_need_uninstall, Uninstall_flash_player, and uninstallflash.bat.

$PSExecPath = "C:\Kode\psexec.exe"
$source = '\\MMT\main\Installs\Adobe Uninstall\*'
$destination = "\\$computer\c$\Kode"
#Insert the file name "PC_Uninstall.txt" instead of test1.txt
$computers = Get-Content -path c:\Kode\test1.txt
write-host "Start copying the files from '\MMT\main\Installs\Adobe Uninstall\*' to all computers" -ForegroundColor Green
foreach ($computer in $computers){
copy-item -path $source -destination $destination -verbo
write-host $computers "Running the UninstallFlash.bat file to uninstall Adobe Flash Play" -foregroundcolor Yellow
try { Invoke-command -computername $computer -scriptblock { & C:\kode\uninstallflash.bat } -ErrorAction stop}
catch { Set-Alias -Name psexec -Value $PSExecPath
& psexec -s \\$computername cmd.exe /c "C:\Kode\uninstallflash.bat" }
Remove-Item -Path \\$computer\c$\kode\uninstall_flash_player.exe, \\$computer\c$\kode\uninstallflash.bat, \\$computer\c$\kode\PC_Uninstall.txt
}
