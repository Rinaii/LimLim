#Add-AdGroupmember -ID $O365_Intune_Enrollment -Members {Get-ADComputer (get-content C:\temp\remoteacess.txt)}
$Computers = Get-Content -Path ‘C:\temp\Remoteaccess.txt’
foreach ($computer in $computers)
{$dns=get-adcomputer $computer
$b=$dns.distinguishedname
Add-ADPrincipalGroupMembership $b ‘O365_Intune_Enrollment’
}
