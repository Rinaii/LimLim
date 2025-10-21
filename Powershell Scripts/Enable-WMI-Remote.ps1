# Enable WinRM service and set it to start automatically
Set-Service WinRM -StartupType Automatic
Start-Service WinRM

# Configure WinRM for quick configuration
winrm quickconfig -quiet

# Enable firewall rules for WMI
netsh advfirewall firewall set rule group="Windows Management Instrumentation (WMI)" new enable=yes

# Optional: Configure TrustedHosts if the remote computer is in a workgroup
# Set-Item WSMan:\localhost\Client\TrustedHosts -Value "*" -Force 
# Use with caution as it allows connections from any host