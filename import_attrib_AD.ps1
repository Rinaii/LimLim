Import-Module activedirectory
Get-ADUser -searchbase 'OU=Users,OU=IT,DC=Kode,DC=com' -Filter * –Properties UserPrincipalName, givenname, surname, department, title| Export-Csv -Path C:\Kode\UserAttributes.csv 
#company, department, title, telephoneNumber, PwdLastSet | Select-Object SamAccountName, Name, company, department, title, telephoneNumber
#Get-ADUser -SearchBase "OU=HR,DC=SHELLPRO,DC=LOCAL" -Filter * -Properties Name