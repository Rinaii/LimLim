
    # Read the content of the text file
    $machines = Get-Content -Path "C:\Kode\obsoletejava.txt"

    # Loop through each machine and execute the uninstallation command remotely
    foreach ($machine in $machines) {
        try {
            # Execute the uninstallation command remotely using Invoke-Command
            Invoke-Command -ComputerName $machine -ScriptBlock {
                # Uninstall all versions of Java using the WMIC command
               gwmi Win32_Product -filter "name like 'Jav%' OR name like 'J2S%'" | % { $_.Uninstall() } 
            }
            Write-Output "Java uninstalled successfully from $machine"
        }
        catch {
            Write-Output "Failed to uninstall Java from $machine"
        }
    }


