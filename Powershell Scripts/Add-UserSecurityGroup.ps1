#add any users from Get-content to a security membership group using Foreach
$users=import-csv c:\temp\Remoteaccess.txt
foreach($user in $users)
{
$upn = $user.upn
get-aduser -filter "userprincipalname -eq '$upn'" |
% {add-adgroupmember -identity "Intune Prod Users" -members $_} -Verbose
}