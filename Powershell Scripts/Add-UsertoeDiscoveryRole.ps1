Update-Module ExchangeOnlineManagement
Import-Module ExchangeOnlineManagement
#UNP An admin account that has sufficient privilege to make this change
$UPN = 'moedadmin365@nuhh.onmicrosoft.com'
Connect-ExchangeOnline -UserPrincipalName $UPN
Connect-IPPSSession -UserPrincipalName  $UPN
#UNP1 the user that you would like to add to eDiscoveryManager Role.
$UPN1 = 'jjadmin365@nuhh.onmicrosoft.com'
Add-RoleGroupMember -identity "eDiscoveryManager" -Member $UPN1