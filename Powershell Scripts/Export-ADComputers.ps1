﻿Import-Module activedirectory
Get-ADComputer -SearchBase 'OU=Rehab,OU=Computers,OU=Norworth,OU=Facilities,DC=momotecho,DC=com' -Filter * -Property * |
Select-Object Name,OperatingSystem,LastLogonDate,DistinguishedName |
Export-CSV "C:\MoMo\Norworth Migration\ADcomputersNor-Reh.csv" -NoTypeInformation -Encoding UTF8