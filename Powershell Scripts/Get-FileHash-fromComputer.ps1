#Invoke-SSH -ComputerName 00-kode12 -Command "Get-FileHash -Path "c:\Users\37-hub100343\AppData\Local\OneStart.ai\OneStart\Application" -Algorithm SHA256"
$computerName = "00-kode12"
$filePath = "C:\Users\02-MAS100182\AppData\Local\OneStart.ai\OneStart\Application\132.0.6834.161\Installer\setup.exe" #File Path
$hashAlgorithm = "SHA256"

Invoke-Command -ComputerName $computerName -ScriptBlock {
    param($filePath, $hashAlgorithm)
    if (Test-Path -Path $filePath) {
        Get-FileHash -Path $filePath -Algorithm $hashAlgorithm | Format-List
    } else {
        Write-Warning "File not found: $filePath"
    }
} -ArgumentList $filePath, $hashAlgorithm