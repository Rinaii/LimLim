# Check if BitLocker is already enabled
$bitlockerStatus = Get-BitLockerVolume -MountPoint "C:"
if ($bitlockerStatus.ProtectionStatus -eq "On") {
    Write-Host "BitLocker is already enabled on C: drive." -ForegroundColor Green
    exit
}

# Specify the recovery key file path
$RecoveryKeyPath = "C:\kode"    #This is the folder path                                                                                                                                                                                                                                                                    \RecoveryKey.txt"

# Enable BitLocker using TPM
Enable-BitLocker -MountPoint "C:" -EncryptionMethod XtsAes256 -UsedSpaceOnly -TpmProtector

# Backup the recovery key to a file
$RecoveryKey = (Get-BitLockerVolume -MountPoint "C:").KeyProtector | Where-Object { $_.KeyProtectorType -eq "RecoveryPassword" }
$RecoveryKey.RecoveryPassword | Out-File -FilePath $RecoveryKeyPath

Write-Host "BitLocker has been enabled successfully!" -ForegroundColor Green
Write-Host "Recovery key saved to: $RecoveryKeyPath" -ForegroundColor Yellow

# Start encryption
Write-Host "Starting encryption process..." -ForegroundColor Cyan
manage-bde -status C:
