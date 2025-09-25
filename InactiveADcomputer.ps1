$domain = "kode.com"  
$DaysInactive = 15
$time = (Get-Date).Adddays(-($DaysInactive))
$oldPC = Get-ADcomputer -Filter {(whenchanged -lt $time) -and (OperatingSystem -Like "Windows 7*") -and (Enabled -eq $true) -and (Name -notlike "*survey*")} -SearchBase "OU=Intune Testing,OU=Computers,OU=IT,DC=Kode,DC=com" -Properties OperatingSystem, LastLogonDate, modified, description, whenchanged | Export-Csv -Path C:\Kode\ITOU.csv -Force -NoTypeInformation
#$oldUsers | select Userprincipalname, modified, whenchanged, DistinguishedName, description | sort modified | Export-Csv -Path C:\Kode\Disable_User_60\6monthsPC.csv -Force -NoTypeInformation