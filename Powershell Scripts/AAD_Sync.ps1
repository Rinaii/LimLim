Param (

    [Parameter(Position=0)][String]$DC = "MoMoDC1",
    [Parameter()][Switch]$AsJob = $false

)
write-host "Syncing from $DC to all domain controllers..."
if($AsJob) { Invoke-Command -ComputerName $DC -ScriptBlock { & repadmin /syncall /APeD } -AsJob | Out-Null }
else { Invoke-Command -ComputerName $DC -ScriptBlock { & repadmin /syncall /APeD } | Out-Null }
write-host "Syncing to Azure Active Directory.."
if($AsJob) { Invoke-Command -ComputerName laurelsync -ScriptBlock { Start-ADSyncSyncCycle -policytype delta -verbose } -AsJob | out-null } 
else { Invoke-Command -ComputerName laurelsync -ScriptBlock { Start-ADSyncSyncCycle -policytype delta -verbose } | out-null }
write-host "Complete."

if($AsJob) { Get-Job }


