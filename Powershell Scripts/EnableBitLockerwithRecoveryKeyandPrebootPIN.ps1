# Get the BitLocker volume information
$bitlockerVolume = Get-BitLockerVolume -MountPoint "C:"

# Check if BitLocker is already enabled
if ($bitlockerVolume.ProtectionStatus -eq 'On') {
    Write-Host "BitLocker is already enabled on the C: drive. Skipping enabling BitLocker."
} else {
    # Enable BitLocker on the C drive with a recovery password
    Enable-BitLocker -MountPoint "C:" -RecoveryPasswordProtector -SkipHardwareTest

    # Get the updated BitLocker volume information
    $bitlockerVolume = Get-BitLockerVolume -MountPoint "C:"

    # Get the recovery key protector
    $recoveryProtector = $bitlockerVolume.KeyProtector | Where-Object {$_.KeyProtectorType -eq 'RecoveryPassword'}

    # Backup the recovery key to Active Directory
    Backup-BitLockerKeyProtector -MountPoint "C:" -KeyProtectorId $recoveryProtector.KeyProtectorId

    Write-Host "BitLocker has been enabled, and the recovery key has been backed up to Active Directory."
}

# Enable BitLocker preboot with a PIN
$pin = "MoMo1234"  # You can change this PIN or prompt the user for it

# Convert the PIN to a SecureString
$securePin = ConvertTo-SecureString -String $pin -AsPlainText -Force

# Check if PIN is already set for preboot authentication
$prebootAuth = Get-BitLockerVolume -MountPoint "C:" | Select-Object -ExpandProperty KeyProtector | Where-Object { $_.KeyProtectorType -eq "TPMAndPIN" }

if ($prebootAuth) {
    Write-Host "A preboot PIN is already enabled."
} else {
    # Enable BitLocker with a TPM and PIN protector
    Enable-BitLocker -MountPoint "C:" -TpmAndPinProtector -Pin $securePin

    Write-Host "BitLocker preboot with PIN has been enabled."
}
