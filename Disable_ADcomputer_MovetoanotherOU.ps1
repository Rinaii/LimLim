$pclist = Get-Content C:\Temp\DisableUsers.txt
$targetOU = "OU=Computers,OU=Disabled,DC=Contoso,DC=com"  
foreach($pc in $pclist){  
    if ($pc.Trim()) {  
        Get-ADComputer $pc.Trim() | Disable-ADAccount -PassThru | Move-ADObject -TargetPath $targetOU  
    }  
}