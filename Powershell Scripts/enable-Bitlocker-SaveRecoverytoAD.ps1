# Enable BitLocker on the C drive with a recovery password
Enable-BitLocker -MountPoint "C:" -RecoveryPasswordProtector -SkipHardwareTest

# Get the BitLocker volume information
$bitlockerVolume = Get-BitLockerVolume -MountPoint "C:"

# Get the recovery key protector
$recoveryProtector = $bitlockerVolume.KeyProtector | Where-Object {$_.KeyProtectorType -eq 'RecoveryPassword'}

# Backup the recovery key to Active Directory
Backup-BitLockerKeyProtector -MountPoint "C:" -KeyProtectorId $recoveryProtector.KeyProtectorId

Write-Host "BitLocker has been enabled and the recovery key has been backed up to Active Directory."