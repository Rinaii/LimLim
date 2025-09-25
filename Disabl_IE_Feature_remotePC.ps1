#$PC = get-content C:\Kode\Explorer\PCNames.txt #Get a list of computer from C:\Kode\explorer
#Foreach ($pc in $computers){
try {
    Invoke-Command -ComputerName 500-PC -ScriptBlock {
    Disable-windowsoptionalfeature -online -res -featureName Internet-Explorer-Optional-amd64
    #dism /online /Disable-Feature /FeatureName:Internet-Explorer-Optional-amd64 -force
    Restart-Computer $PC -force
        } #-erroraction Stop | out-file C:\Kode\Explorer\failed.txt
}
catch {
    $_.Exception.Message | Out-File C:\Kode\Explorer\failed.txt
}
