$users= get-content c:\laurel\remoteaccess.txt
foreach($user in $users){

Remove-ADGroupMember -Identity "EOP1 Users" -Members $user
write-host "$user has been removed to Intube Prod User" -ForegroundColor Yellow
}