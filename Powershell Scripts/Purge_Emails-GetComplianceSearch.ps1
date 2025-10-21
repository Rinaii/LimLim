#*By using this module, are you going to sign into azure (Exchange)
Connect-IPPSSession -UserPrincipalName dokey365@LHCCOH.onmicrosoft.com

#*Then you are going to create a search agianst all users in your exchange server
#*Start the search
$Search=New-ComplianceSearch -Name "Costco" -ExchangeLocation All -ContentMatchQuery '(Received:09/08/2025) AND (Subject:"Great Costco Deals")'
$Search=New-ComplianceSearch -Name "Costco" -ExchangeLocation All -ContentMatchQuery '(Received:09/08/2025) AND (From:Alexus.Bardot@gmail.com)'
Start-ComplianceSearch -Identity $Search.Identity

#*Show progress
Get-ComplianceSearch

#*Show results (-Identity =  would  be the name, not the subject name)
Get-ComplianceSearch -Identity "Costco" | Format-List
Get-ComplianceSearch -Identity 'MoMo1' | Select-Object Name,Items,Size

#*Purge the results (-Searchname =  would be the search name. not the name of the subject)
New-ComplianceSearchAction -SearchName "MoMo1" -Purge -PurgeType HardDelete

#*Show the status of purge (This would be the searchname)
Get-ComplianceSearch | where-object { $_.Name -like 'MoMo1*' }
#Get-ComplianceSearch -Identity "Phis Microsoft" | Export-Csv "C:\Kode\ResultsCompliance.csv" -NoTypeInformation -Encoding utf8

