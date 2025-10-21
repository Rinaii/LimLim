$pclist = Get-Content C:\Kode\DisableUsers.txt
$targetOU = "OU=Computers,OU=Disabled,DC=Kode,DC=com"  
foreach($pc in $pclist){  
    if ($pc.Trim()) {  
        Get-ADComputer $pc.Trim() | Disable-ADAccount -PassThru | Move-ADObject -TargetPath $targetOU  
    }  
}