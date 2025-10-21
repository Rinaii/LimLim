#This Powershell Script intended for Rapid7 Insight Agent Uninstallation 
    # Read the content of the text file
    $machines = Get-Content -Path "C:\Kode\RehabPCRapid7.txt"

    # Loop through each machine and execute the uninstallation command remotely
    foreach ($machine in $machines) {
        try {
            # Execute the uninstallation command remotely using Invoke-Command
            Invoke-Command -ComputerName $machine -ScriptBlock {
               Get-Package -Name "Rapid7 Insight Agent" | Uninstall-Package 
            }
            Write-Output "Rapid7 Insight Agent uninstalled successfully from $machine"
        }
        catch {
            Write-Output "Failed to uninstall Rapid7 Insight Agent from $machine"
        }
    }
