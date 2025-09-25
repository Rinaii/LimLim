$pclist = Get-Content C:\Kode\DisableUsers.txt
$targetOU = "OU=Users,OU=Disabled,DC=kode,DC=com"  
foreach($pc in $pclist){  
    if ($pc.Trim()) {  
        Get-ADUser $pc.Trim() | Disable-ADAccount -PassThru | Move-ADObject -TargetPath $targetOU  
    }  
}