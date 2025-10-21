# Check if TPM is enabled
$tpm = Get-WmiObject -Namespace "Root\CIMv2\Security\MicrosoftTpm" -Class Win32_Tpm

# A flag if restart is needed
$restartNeeded = 0

# If TPM is not enabled, enable it
if ($tpm.TpmPresent -eq $false -or $tpm.TpmEnabled -eq $false) {
    Write-Host "TPM is not enabled. Enabling TPM..."

    # Here you would enable TPM in the BIOS. This is vendor-specific.
    # For Lenovo devices, you might use Lenovo BIOS management tools:
    (gwmi -Namespace root\wmi -Class Lenovo_SetBIOSSetting).SetBIOSSetting("SecurityChip,Enable")
    (gwmi -Namespace root\wmi -Class Lenovo_SaveBIOSSettings).SaveBIOSSettings()

    Write-Host "TPM enabled successfully. Proceeding with BIOS setting changes."

    # Set restartNeeded flag to 1 since enabling TPM typically requires a restart
    $restartNeeded = 1

    # Wait for the system to apply the settings
    Start-Sleep -Seconds 10
} else {
    Write-Host "TPM is already enabled. Skipping TPM enablement."
}

# Output whether a restart is needed (1) or not (0)
Write-Host "Restart needed: $restartNeeded"
