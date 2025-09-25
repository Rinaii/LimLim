$PSExecPath = "C:\Kode\psexec.exe"
Set-Alias -Name psexec -Value $PSExecPath
$source = "\\Kode\main\Installs\Trend_Uninstall"
$destination = "\\$computer\c$\Kode"
$computers = Get-Content -path "\\Kode\main\Installs\Trend_uninstall\RehabPCTrend.txt"
write-host "Start copying the files from '\Kode\main\Installs\Trend_uninstall\*' to all computers" -ForegroundColor Green
foreach ($computer in $computers){
copy-item -path "\\Kode\main\Installs\Trend_uninstall\*" -destination "\\$computer\c$\Kode" -verbose
write-host $computer "Running the Scut.exe file to uninstall Trend Micro Apex one Security Agent" -foregroundcolor Yellow
try{ 
psexec -s \\$computer cmd.exe /c "C:\Kode\SCUT.exe -noinstall -dbg"
write-host "$computer was successfully uninstalled Trend Micro."
Remove-Item -Path \\$computer\c$\Kode\SCUT.exe, \\$computer\c$\Kode\RehabPCTrend.txt}
catch {
write-host "$computer Failled to uninstall Trend." -ForegroundColor DarkRed | Export-csv -Path "C:\Kode\FailedRapid7PC.csv" -Append -NoTypeInformation }
}